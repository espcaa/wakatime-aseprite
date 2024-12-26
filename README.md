# Wakatime-Aseprite

A simple Aseprite plugin to track your time in Wakatime.
This implementation is very lazy (Don't hesitate to contribute!) and thus doesnt do a few things you'd expect from an official wakatime-plugin:
- It doesnt automatically download and update your wakatime-cli (Another editor will probably do this for you, I hope at least)
- Doesnt ask you to add your api key (You can add it manually in your .wakatime.cfg)

## Installation

1. Download the latest release from the [releases page](https://github.com/spectralo/hackatime-aseprite/releases)
2. Open Aseprite
3. Go to `File > Plugins > Install Plugin...`
4. Select the downloaded file
5. Restart Aseprite
6. Enjoy!

## Usage

The plugin should automatically start tracking your time after you installed it.

## Building

You don't really build an aseprite plugin, you just need to zip the whole folder and rename the extension to `.aseprite-extension`.
Step-by step:

1. Clone the repo
2. Cd into the repo
    ```bash
    cd wakatime-Aseprite
    ```
2. Zip & rename the folder:
    ```bash
    zip -r wakatime-aseprite.aseprite-extension src
    ```

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
