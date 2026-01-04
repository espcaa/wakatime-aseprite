<img width="400" height="640" alt="image" src="https://github.com/user-attachments/assets/cd6a92ad-604c-4f20-b5e9-6a4222b0b1f7" />

# Wakatime-Aseprite

A simple Aseprite plugin to track your time in Wakatime.
This implementation is basic (Don't hesitate to contribute!) and thus doesn't do a few things you'd expect from an official wakatime-plugin:
- It doesn't automatically download and update your wakatime-cli (Another editor will probably do this for you, I hope at least)
- Doesn't ask you to add your api key (You can add it manually in your .wakatime.cfg)

## Installation

1. Download the latest release from the [releases page](https://github.com/espcaa/wakatime-aseprite/releases)
2. Open Aseprite
3. Go to settings (`Ctrl + ,`, `⌘ + ,`, `Ctrl + K`, or `⌘ + K`)
4. Go to extensions & add an extension with the file you just downloaded.
5. You can now define your project name by clicking there: \
   \
<img width="252" alt="Screenshot 2024-12-27 at 18 47 18" src="https://github.com/user-attachments/assets/5a348684-113d-4440-9bac-148e0e9769a5" /> \
\
and then on this option at the end
\
\
<img width="333" alt="Screenshot 2024-12-27 at 18 55 51" src="https://github.com/user-attachments/assets/c25fa90d-dde5-4598-8e9a-d0a20966ba66" /> \
\
You'll need to do that each time you start a project for it to appear correctly on wakatime. (folder based detection is in the works)

## "Building"

Just run the `package.sh` script at the root of the repo to create a wakatme-aseprite.aseprite-extension file in the `dist/` folder.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
