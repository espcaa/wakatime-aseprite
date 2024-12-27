![image](https://github.com/user-attachments/assets/91b614e6-9e19-4d31-a38d-603608e3034e)

# Wakatime-Aseprite

A simple Aseprite plugin to track your time in Wakatime.
This implementation is basic (Don't hesitate to contribute!) and thus doesn't do a few things you'd expect from an official wakatime-plugin:
- It doesn't automatically download and update your wakatime-cli (Another editor will probably do this for you, I hope at least)
- Doesn't ask you to add your api key (You can add it manually in your .wakatime.cfg)

## Installation

1. Download the latest release from the [releases page](https://github.com/spectralo/hackatime-aseprite/releases)
2. Open Aseprite
3. Go to settings (Ctrl+, or Cmd+,)
4. Go to extensions
5. Click on "Add extension"
6. Select the downloaded file
8. Enjoy!

9. Next you can define your project name by clicking on this icon \
<img width="252" alt="Screenshot 2024-12-27 at 18 47 18" src="https://github.com/user-attachments/assets/5a348684-113d-4440-9bac-148e0e9769a5" /> \
and then on this button at the end \
<img width="333" alt="Screenshot 2024-12-27 at 18 55 51" src="https://github.com/user-attachments/assets/c25fa90d-dde5-4598-8e9a-d0a20966ba66" /> \
You need to do that each time you start a project to change its name in Wakatime

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
