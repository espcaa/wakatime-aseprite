
-- global variables
LastTime = nil
ProjectName = "Untitled"
PluginVer = "2.2.0"
Sprite = nil
SpriteListener = nil

-- initialization
AsepriteVer = app.version

-- types
--
---@class Heartbeat
---@field entity string
---@field time number
---@field project string|nil
---@field branch string|nil
---@field is_write boolean|nil
---@field lineno integer|nil
---@field cursorpos integer|nil
---@field lines_in_file integer|nil
---@field plugin string|nil

local function newHeartbeat(opts)
    return {
        entity = opts.entity,
        time = opts.time,
        project = opts.project,
        branch = opts.branch,
        is_write = opts.is_write,
        lineno = opts.lineno,
        cursorpos = opts.cursorpos,
        lines_in_file = opts.lines_in_file,
        plugin = opts.plugin,
    }
end

-- utils
local function getUserDirPath()
    if app.os then
        if app.os.name == "Windows" then
            return os.getenv("USERPROFILE")
        else
            return os.getenv("HOME")
        end
    else
        -- weird but can happen on some strange linux builds
        return os.getenv("HOME")
    end
end

local function isSpriteValid()
    return Sprite ~= nil and app.sprite ~= nil and Sprite == app.sprite
end

local function getWakatimeCliPath()
    -- wakatime-cli is in the .wakatime folder in the user's home directory, and has a wakatime-cli-* pattern
    local userDir = getUserDirPath()
    local wakatimeDir = userDir .. app.fs.pathSeparator .. ".wakatime"
    local files = app.fs.listFiles(wakatimeDir)
    for _, file in ipairs(files) do
        if file:match("^wakatime%-cli") then
            return wakatimeDir .. app.fs.pathSeparator .. file
        end
    end
end

local function updateSprite(bypass_timer, is_write)
    if isSpriteValid() and (not LastTime or LastTime < os.time() - 120 or bypass_timer) then

        -- create the heartbeat

        if Sprite.filename == "" or Sprite.filename == nil then
            -- spawn dialog saying that they need to save the file or that tracking won't work

            app.alert("you need to save this sprite as a file for wakatime to track it.")
            return
        end

        local heartbeat = newHeartbeat({
            entity = Sprite.filename,
            time = os.time(),
            project = ProjectName,
            lineno = GetCurrentLine(),
            cursorpos = GetCursorPos(),
            lines_in_file = GetSpriteHeight(),
            plugin = string.format(
                "Aseprite/%s (%s-none-none) aseprite-wakatime/%s",
                AsepriteVer.major .. "." .. AsepriteVer.minor,
                (app.os and app.os.name) or "Unknown",
                PluginVer
            ),
            is_write = is_write or false,
        })

        -- send the heartbeat
        SendHeartbeat(heartbeat)
        if not bypass_timer then
            LastTime = os.time()
        end
    end
end

function SendHeartbeat(heartbeat)
    local wakatimeCliPath = getWakatimeCliPath()
    if not wakatimeCliPath then
        app.alert("Wakatime CLI not found. Please ensure it is installed in the .wakatime folder.")
        return
    end

    local cmd = string.format(
        '"%s" --language Aseprite --category designing --plugin "%s" --time %d --project "%s" --lineno %d --lines-in-file %d --entity "%s"',
        wakatimeCliPath,
        heartbeat.plugin,
        heartbeat.time,
        heartbeat.project,
        heartbeat.lineno,
        heartbeat.lines_in_file,
        heartbeat.entity
    )

    if heartbeat.is_write then
        cmd = cmd .. " --write"
    end

    if app.os and app.os.name == "Windows" then
        os.execute("start /b " .. cmd)
    else
        os.execute(cmd .. " &")
    end
end

local function registerSprite()
    -- if the sprite changed, or we didn't have one
    if app.sprite ~= Sprite then
        -- remove old listener first
        if SpriteListener and Sprite then
            Sprite.events:off(SpriteListener)
            SpriteListener = nil
        end

        -- update current sprite
        Sprite = app.sprite

        if Sprite then
            -- send heartbeat for new sprite
            updateSprite(true, false)

            -- register listener for any changes
            SpriteListener = Sprite.events:on("change", function()
                -- bypass timer to send heartbeat immediately
                updateSprite(false, false)
            end)
        end
    end
end

function CurrentFile()
    if isSpriteValid() then
        return Sprite.filename or "Untitled"
    else
        return "No File"
    end
end

function GetSpriteHeight()
    if isSpriteValid() then
        return Sprite.height
    else
        return 0
    end
end

function GetCursorPos()
    local cel = app.cel
    if cel == nil then
        return 0
    else
        return cel.position.x
    end
end

function GetCurrentLine()
    local cel = app.cel
    if cel == nil then
        return 0
    else
        return cel.position.y
    end
end

function SetProjectName(plugin)
    local dlg = Dialog({
        title = "Set Project Name",
    })
    if not dlg then
        app.alert("Failed to create dialog.")
        return
    end
    dlg:entry({
        id = "projectName",
        label = "Wakatime project name",
        text = ProjectName,
    })
    dlg:button({
        id = "ok",
        text = "OK",
        onclick = function()
            local newName = dlg.data.projectName
            if newName ~= "" then
                ProjectName = newName
                if plugin then
                    plugin.preferences.projectName = ProjectName
                end
                dlg:close()
            else
                app.alert("Project name cannot be empty.")
            end
        end,
    })
    dlg:button({
        id = "cancel",
        text = "Cancel",
        onclick = function()
            dlg:close()
        end,
    })
    dlg:show({ wait = true })
end

function GetModTime(path)
    local handle, result
    if package.config:sub(1,1) == "\\" then
        -- Windows
        handle = io.popen('powershell -Command "(Get-Item \''..path..'\').LastWriteTimeUtc.ToUnixTimeSeconds()"')
        result = handle:read("*n")
    elseif package.config:sub(1,1) == "/" then
        -- macOS or Linux
        -- check OS
        local os_name = app.os.name or "Unknown"

        if os_name == "macOS" then
            handle = io.popen('stat -f %m \''..path..'\'')
        else
            -- assume Linux
            handle = io.popen('stat -c %Y \''..path..'\'')
        end
        result = handle:read("*n")
    else
        -- unknown OS
        return nil
    end
    handle:close()
    return result
end

function CheckForSave()
    local spr = app.sprite
    if not spr then return end

    local filename = spr.filename
    if filename == "" or not app.fs.isFile(filename) then return end

    local currentMod = GetModTime(filename)
    if not currentMod then return end

    local now = os.time()
    if now - currentMod <= 2 then
        -- file was saved in the last 2 seconds
        updateSprite(true, true)
    end
end


function UpdateSpriteHelper()
    updateSprite(false, false)
end

function init(plugin)
    AsepriteVer = app.version

    plugin:newCommand({
        id = "setProjectName",
        title = "Set wakatime project name",
        group = "palette_generation",
        onclick = function()
            SetProjectName(plugin)
        end,
    })

    if plugin.preferences.projectName and plugin.preferences.projectName ~= "" then
        ProjectName = plugin.preferences.projectName
    else
        ProjectName = "Untitled"
        plugin.preferences.projectName = ProjectName
    end

    app.alert("Wakatime Aseprite plugin v" .. PluginVer .. " loaded!!")

    if ProjectName == "Untitled" then
        app.alert(
            "Don't forget to set your project name for accurate tracking. "
            .. "Access it via the burger menu -> Set wakatime project name."
        )
    end

    registerSprite()

    local timer = Timer({
        interval = 2.0,
        ontick = function()
            registerSprite()
            CheckForSave()
        end,
    })
    timer:start()
end

return {
    init = init,
}
