local config_file_path = os.getenv("HOME") .. "/.wakatime.cfg"

local function getPlatformInfo()
    local osName, isArm = app.os.name, app.os.arm64
    local cliNames = {
        Windows = isArm and "/.wakatime/wakatime-cli-windows-arm64" or "/.wakatime/wakatime-cli-windows-amd64",
        Linux = isArm and "/.wakatime/wakatime-cli-linux-arm64" or "/.wakatime/wakatime-cli-linux-amd64",
        macOS = isArm and "/.wakatime/wakatime-cli-darwin-arm64" or "/.wakatime/wakatime-cli-darwin-amd64"
    }
    local downloadPaths = {
        Windows = isArm and "windows-arm64.zip" or "windows-amd64.zip",
        Linux = isArm and "linux-arm64.zip" or "linux-amd64.zip",
        macOS = isArm and "darwin-arm64.zip" or "darwin-amd64.zip"
    }
    return {
        cliName = cliNames[osName] or "",
        downloadPath = "https://github.com/wakatime/wakatime-cli/releases/latest/download/wakatime-cli-" ..
        (downloadPaths[osName] or "")
    }
end

local function readConfig(filePath)
    local file = io.open(filePath, "r")
    if not file then return nil end
    local prefs = {}
    for line in file:lines() do
        local key, value = line:match("([^=]+)%s*=%s*(.+)")
        if key and value then prefs[key:match("%S+")] = value:match("%S+") end
    end
    file:close()
    return prefs
end

function init(plugin)
    local prefs = plugin.preferences
    if not prefs.api_url or not prefs.api_token then
        app.alert("Getting data from your .wakatime.cfg")
        local config = readConfig(config_file_path)
        if not config then
            app.alert("Can't read your wakatime config file :/")
            return
        end
        prefs.api_url, prefs.api_token = config.api_url, config.api_token
        app.alert("Data saved!")
    end

    local platform = getPlatformInfo()
    local fullPath = os.getenv("HOME") .. platform.cliName
    app.alert("Getting CLI path: " .. fullPath)

    if app.fs.isFile(fullPath) then
        app.alert("Wakatime-cli found!")
    else
        app.alert("Wakatime-cli isn't installed :/ Downloading it ....")
        app.alert("Downloading CLI from " .. platform.downloadPath)
    end
end
