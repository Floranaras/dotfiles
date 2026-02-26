# FCONV | Professional Media & Document Converter
**Version 1.2.1** | **MacOS & Linux Compatible**

A high-performance CLI utility for streamlined file conversion. `fconv` acts as an intelligent wrapper around `FFmpeg` and `LibreOffice`, abstracting complex command-line arguments into a simple, user-friendly interface.

---

## Key Features

* **Intelligent Transcoding:** Automated codec selection for Video (H.264), Audio (AAC/MP3), and Images (WebP/JPG).
* **Discord-Ready Compression:** Dynamic bitrate calculation to fit specific file size targets (default 10MB) for seamless sharing.
* **Document Processing:** Headless integration with LibreOffice for converting PPTX, DOCX, and ODT to PDF.
* **Audio Extraction:** One-step audio stripping from video containers.
* **Cross-Platform Architecture:** Specialized logic to handle MacOS (Zsh/Bash 3.2) and Linux (Bash 4.0+) environments.

---

## Installation

### Prerequisites

Ensure the core engines are installed on your system.

**MacOS:**
```bash
brew install ffmpeg libreoffice bc
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt update
sudo apt install ffmpeg libreoffice bc
```

### Script Setup

Move the script to your local bin to enable global access:

```bash
mkdir -p ~/.local/bin
mv your_script_name.sh ~/.local/bin/fconv
chmod +x ~/.local/bin/fconv
```

Ensure `~/.local/bin` is in your `$PATH`.

---

## Usage Guide

### Simple Format Conversion

Convert any file by specifying the input and the desired output format.

```bash
fconv presentation.pptx pdf
fconv image.png webp
fconv voice_note.m4a mp3
```

### Video Extraction & Compression

`fconv` automatically detects when you are moving from video to audio containers.

```bash
fconv music_video.mp4 song.mp3
fconv high_res_movie.mov compressed.mp4 --discord
fconv raw_footage.mkv share.mp4 --discord --size 25
```

### Advanced Media Processing

Fine-tune the output using professional flags.

```bash
fconv input.mp4 output.mp4 --res 1280x720 --audio 192
fconv vinyl_rip.wav hifi_track.mp3 -a 320
```

---

## Command Reference

| Flag | Argument | Description |
| :--- | :--- | :--- |
| `-d, --discord` | N/A | Enables automatic bitrate calculation for size limits. |
| `-s, --size` | MB | Sets target size in Megabytes (Default: 10). |
| `-a, --audio` | kbps | Sets audio bitrate (Default: 128). |
| `-crf` | 0-51 | Constant Rate Factor (Lower is higher quality). |
| `-r, --res` | WxH | Scales video to specific resolution (e.g., 1920x1080). |
| `-o, --output` | file | Defines a custom output filename and path. |

---

## Technical Specifications

* **Video Engine:** FFmpeg with `libx264` video codec and `aac` audio.
* **Audio Engine:** `libmp3lame` (MP3), `pcm_s16le` (WAV), `libvorbis` (OGG).
* **Document Engine:** LibreOffice Headless (Soffice binary).
* **Path Handling:** Integrated `realpath` simulation for MacOS to prevent source-file overwriting and data loss.

---

## Error Handling

* **Dependency Check:** Validates presence of `ffmpeg` and `bc` on launch.
* **Format Validation:** Rejects unsupported MIME types with descriptive exit codes.
* **Overwrite Protection:** Detects if output path matches input and appends `_converted` to prevent data corruption.

---

**Author:** Amane Kai / 雨音カイ  
**Maintenance:** Stable (v1.2.1)  
**License:** Open Source / Professional Utility
