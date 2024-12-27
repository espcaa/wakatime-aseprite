LastTime = nil
ProjectName = "Untitled"
PluginVer = "1.1.1"
AsepriteVer = app.version
Sprite = nil
SpriteListener = nil

function cliName()
    local osName, isArm = app.os.name, app.os.arm64
    if osName == "Windows" then
        return isArm and "wakatime-cli-windows-arm64.exe" or "wakatime-cli-windows-amd64.exe"
    elseif osName == "Linux" then
        return isArm and "wakatime-cli-linux-arm64" or "wakatime-cli-linux-amd64"
    elseif osName == "macOS" then
        return isArm and "wakatime-cli-darwin-arm64" or "wakatime-cli-darwin-amd64"
end

function getUserPath()
    if app.os.name == "Windows" then
        return os.getenv("USERPROFILE")
    else
        return os.getenv("HOME")
    end
end

function isSpriteValid()
    return Sprite ~= nil and app.sprite ~= nil and Sprite == app.sprite
end

function sendData()
    local cmd = string.format(
        '%s/.wakatime/%s --language Aseprite --category designing --plugin "Aseprite/%s (%s-none-none) aseprite-wakatime/%s" --time %d --project "%s" --lineno %d --lines-in-file %d --entity "%s"',
        getUserPath(),
        cliName(),
        AsepriteVer.major .. "." .. AsepriteVer.minor,
        app.os.name,
        PluginVer,
        os.time(),
        ProjectName,
        getCursorPos(),
        getSpriteHeight(),
        CurrentFile()
    )

    local success, _, exit_code = os.execute(cmd)
end

function updateSprite()
    if isSpriteValid() and (not LastTime or LastTime < os.time() - 60) then
        sendData()
        LastTime = os.time()
    end
end

function registerSprite()
    if SpriteListener and Sprite then
        Sprite.events:off(SpriteListener)
        SpriteListener = nil
    end

    if app.sprite then
        Sprite = app.sprite
        SpriteListener = Sprite.events:on('change', updateSprite)
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

function getSpriteHeight()
    if isSpriteValid() then
        return Sprite.height
    else
        return 0
    end
end

function getCursorPos()
    local cel = app.cel
    if cel == nil then
        return 0
    else
        return cel.position.y
    end
end

function setProjectName(plugin)
    local dlg = Dialog {
        title = "Set Project Name"
    }
    dlg:entry {
        id = "projectName",
        label = "Project Name",
        text = ProjectName
    }
    dlg:button {
        id = "ok",
        text = "OK",
        onclick = function()
            local newName = dlg.data.projectName:match("^%s*(.-)%s*$")
            if newName ~= "" then
                ProjectName = newName
                if plugin then
                    plugin.preferences.projectName = ProjectName
                end
                dlg:close()
            else
                app.alert("Project name cannot be empty.")
            end
        end
    }
    dlg:button {
        id = "cancel",
        text = "Cancel",
        onclick = function()
            dlg:close()
        end
    }
    dlg:show { wait = true }
end

function init(plugin)
    AsepriteVer = app.version

    plugin:newCommand {
        id = "setProjectName",
        title = "Set Project Name",
        group = "palette_generation",
        onclick = function()
            setProjectName(plugin)
        end
    }

    if plugin.preferences.projectName and plugin.preferences.projectName ~= "" then
        ProjectName = plugin.preferences.projectName
    else
        ProjectName = "Untitled"
        plugin.preferences.projectName = ProjectName
    end

    app.alert("Wakatime plugin is loaded.")

    if ProjectName == "Untitled" then
        app.alert(
            "Don't forget to set your project name for accurate tracking." ..
            "Access it via the burger menu -> Set Project Name."
        )
    end

    registerSprite()

    local timer = Timer {
        interval = 2.0,
        ontick = function()
            registerSprite()
        end
    }
    timer:start()



    sendData()
end

return {
    init = init
}
