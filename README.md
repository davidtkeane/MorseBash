<p align="center">
  <img src="https://img.shields.io/badge/script-Bash-blue?logo=gnu-bash" alt="Bash">
  <img src="https://img.shields.io/badge/license-MIT-green" alt="MIT License">
  <img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" alt="PRs Welcome">
</p>

<p align="center">
  <img src="https://github.com/DouglasFreshHabian/MorseBash/blob/main/Graphics/Tux-Spy-Telegraph.png?raw=true" alt="My Image" width="400">
</p>

<h1 align="center">
🔊 MorseBash.sh
	</h1>

[MorseBash.sh](https://github.com/DouglasFreshHabian/MorseBash/blob/main/morseBash.sh) is a fun and colorful Bash script that converts text into Morse code with both **audio playback** and **live visual output**. It plays dots and dashes using `aplay`, displays real-time `.` and `-` characters, and includes a randomly colored ASCII art banner for style. 

[MorseMac.sh] MorseMac is now available for Macbook users with just a slight change from aplay to afplay, which also includes play, these are the only differences between the DouglasFreshHabian/MorseBash and this repo. The changes were needed for the morse code to play on Macbooks.

---

![AppleMac-Badge](https://img.shields.io/badge/Apple-macOS-000000?logo=apple&logoColor=white&labelColor=black)
![Linux-Badge](https://img.shields.io/badge/Linux-FCC624?logo=linux&logoColor=black&labelColor=white)

## ✨ Features

- 🔈 **Audio output**: Plays `dot.wav` and `dash.wav` using `aplay`
- 👀 **Visual output**: Prints `.` and `-` characters for each Morse symbol
- 🌈 **ASCII banner**: Styled with a randomly selected color on each run
- 🔤 Supports lowercase a–z, numbers 0–9, and some punctuation
- 📦 Minimal dependencies (just `aplay` and  `bc`)

---

## 🚀 Usage

For Kali Linux or another linux Dist

```bash
./morseBash.sh your message here
```
or For Macbooks

```bash
./morseMac.sh your message here
```
> If no arguments are given, a sample message is played to demonstrate usage.
---

## 💬 If you get an error

If you get an error 'morseBash.sh: line 206: bc: command not found' install bc. Run your update first.

For Kali Linux - Now install bc

```bash
sudo apt install bc
```

## 🎵 Requirements

* aplay (usually provided by the alsa-utils package on Debian-based systems)

* dot.wav and dash.wav in the same directory as the script

To install aplay:

```bash
sudo apt install alsa-utils
```

## 📂 Example

Play hello world

```bash
$ ./morseBash.sh hello world
```
Output:
```bash
.... . .-.. .-.. ---   .-- --- .-. .-.. -..
```
(Plus audible Morse code tones.)

![GitHub last commit](https://img.shields.io/github/last-commit/davidtkeane/MorseBash?style=flat-square)
![GitHub commit activity](https://img.shields.io/github/commit-activity/w/davidtkeane/MorseBash?authorFilter=davidtkeane)
![GitHub issues](https://img.shields.io/github/issues-raw/davidtkeane/MorseBash?style=flat-square)
![GitHub commit status](https://img.shields.io/github/checks-status/davidtkeane/MorseBash/fff3b211e20881582eeea4e035dcdd452548ed7a)


## 💬 [License](https://github.com/DouglasFreshHabian/MorseBash/blob/main/LICENSE)

MIT License. Feel free to use, modify, and share.

## 〰️ May the Morse be with you!
[![Typing SVG](https://readme-typing-svg.demolab.com?font=Fira+Code&pause=1000&color=FFF7FE&width=435&lines=..-.+.-.+.+...+....+++;+..-.+---+.-.+.+-.+...+..+-.-.+...)](https://git.io/typing-svg)



<!-- echo dfresh9tutanota1com|tr 91 @.  -->
