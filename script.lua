LastTime = nil
ProjectName = string

function cliName()
    local osName, isArm = app.os.name, app.os.arm64
    if osName == "Windows" then
        return isArm and "wakatime-cli-windows-arm64.exe" or "wakatime-cli-windows-amd64.exe"
    elseif osName == "Linux" then
        return isArm and "wakatime-cli-linux-arm64" or "wakatime-cli-linux-amd64"
    elseif osName == "macOS" then
        return isArm and "wakatime-cli-darwin-arm64" or "wakatime-cli-darwin-amd64"
    end
end

function getUserPath()
    if app.os.name == "Windows" then
        return os.getenv("USERPROFILE")
    else
        return os.getenv("HOME")
    end
end

function updateSprite()
    if not LastTime or LastTime < os.time() - 60 then
        sendData()
        LastTime = os.time()
    end
end

function registerSprite()
    if SpriteListener then
        Sprite.events:off(SpriteListener)
    end
    if app.sprite then
        Sprite = app.sprite
        SpriteListener = Sprite.events:on('change', updateSprite)
    end
end

function sendData()
    print(CurrentFile())
    print(getCursorPos())
    local cmd = string.format(
        '%s/.wakatime/%s --category designing --plugin aseprite --time %d --project %s --lineno %s --lines-in-file %s --entity %s',
        getUserPath(),
        cliName(),
        os.time(),
        ProjectName,
        getCursorPos(),
        getSpriteHeight(),
        CurrentFile()
    )
    print(cmd)
    os.execute(cmd)
end

function CurrentFile()
    return Sprite.filename
end

function getSpriteHeight()
    local h = Sprite.height
    return h
end

function getCursorPos()
    local cel = app.cel
    local position = cel.position
    return position.x
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
            ProjectName = dlg.data.projectName
            if plugin then
                plugin.preferences.projectName = ProjectName
            end
            dlg:close()
        end
    }
    dlg:show()
end

function init(plugin)
    if plugin.preferences.projectName then
        ProjectName = plugin.preferences.projectName
    else
        ProjectName = "Untitled"
        plugin.preferences.projectName = ProjectName
    end

    app.alert("Wakatime plugin is loaded")
    if ProjectName == "Untitled" then
        app.alert(
            "Don't forget to add your project name and change it. It's at the end of the burger menu -> Set Project Name")
    end

    registerSprite()

    local timer = Timer {
        interval = 2.0,
        ontick = function()
            registerSprite()
        end
    }
    timer:start()

    plugin:newCommand {
        id = "setProjectName",
        title = "Set Project Name",
        group = "palette_generation",
        onclick = function()
            setProjectName(plugin)
        end
    }
end

return {
    init = init
}
