
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
    if isSpriteValid() and (not LastTime or LastTime < os.time() - 120) then

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
        LastTime = os.time()
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
    if isSpriteValid() then
        Sprite.events:off(SpriteListener)
        SpriteListener = nil
    end

    if app.sprite then

        if app.sprite == Sprite then
            return
        else
            -- change detected
            -- sending a heartbeat for the new sprite
            updateSprite(true, false)
            Sprite = app.sprite
            SpriteListener = Sprite.events:on("change", function()
                updateSprite(false, false)
            end)
        end
    else
        Sprite = nil
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

function CheckForSave()
    local spr = app.activeSprite
    if not spr then
        app.alert("No active sprite")
        return
    end

    local filename = spr.filename
    if filename == "" then
        app.alert("Sprite has not been saved yet")
        return
    end

    -- Check if file exists
    if not app.fs.isFile(filename) then
        app.alert("File does not exist on disk")
        return
    end

    -- Get last modification time
    -- Lua doesn't have a direct file mod time, but we can use lfs if available
    local success, lfs = pcall(require, "lfs")
    if success then
        local attr = lfs.attributes(filename)
        if attr and attr.modification then
            -- if saved within last 2 seconds, consider it a save event
            local currentTime = os.time()
            if currentTime - attr.modification <= 2 then
                updateSprite(true, true)
                app.alert("Save event detected and heartbeat sent")
            else
                return
            end
        else
            return
        end
    else
        app.alert("LuaFileSystem (lfs) not available (uh?)")
    end
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

    app.alert("Wakatime plugin is loaded.")

    if ProjectName == "Untitled" then
        app.alert(
            "Don't forget to set your project name for accurate tracking. "
            .. "Access it via the burger menu -> Set Project Name."
        )
    end

    registerSprite()

    local timer = Timer({
        interval = 2.0,
        ontick = function()
            registerSprite()
        end,
    })
    timer:start()
end

return {
    init = init,
}
