# LovelyEngine 

### A fully functional game engine project written in Lua using the LÖVE (love2d) framework.

[![Lua](https://img.shields.io/badge/Lua-5.4-blue?style=for-the-badge&logo=lua&logoColor=white)](https://www.lua.org/)
[![LÖVE](https://img.shields.io/badge/LÖVE-11.4-FF0000?style=for-the-badge&logo=love&logoColor=white)](https://love2d.org/)

## Overview
### LovelyEngine is a modular game engine built on top of the LÖVE framework, providing additional structure and utilities for game development. It includes scene management, audio handling, font management, and a debugging system.

## ✨ Features

- 🎮 **Scene Management** - Easy scene transitions and management
- 🔊 **Audio System** - Advanced audio handling with volume control
- 🔤 **Font Manager** - Dynamic font loading and caching
- 🐛 **Debug Tools** - Built-in debugging utilities
- 🧩 **Modular Architecture** - Easy to extend and modify

## 🚀 Getting Started

### Prerequisites

- [LÖVE framework](https://love2d.org/) installed

### Installation

```bash
git clone https://github.com/yourusername/LovelyEngine.git
cd LovelyEngine
```

### Build

```bash
chmod +x scripts/build.sh 
./scripts/build.sh
```

### run

```bash
chmod +x scripts/run.sh
./scripts/run.sh
```

## 📁 Project Structure
```
LovelyEngine/
├── assets/          # Game assets
│   ├── fonts/       # Font files
│   ├── icons/       # Icon files
│   ├── images/      # Image assets
│   └── musics/      # Audio files
├── src/             # Source code
│   ├── core/        # Core engine systems
│   ├── entities/    # Game entities
│   ├── scenes/      # Game scenes
│   ├── ui/          # UI components
│   └── utils/       # Utility functions
├── conf.lua         # Configuration file
└── main.lua         # Entry point
```

## 📝 License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/Jarlok17/LovelyEngine/blob/main/LICENSE) file for details.
