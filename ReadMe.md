# 🛠️ RealityEditor

*Modern Apple Silicon Game Engine — ARM64 ONLY*

![Platform Support](https://img.shields.io/badge/platform-Apple%20Silicon%20ONLY-blue)
![Architecture](https://img.shields.io/badge/arch-ARM64%20ONLY-green)
![Swift Version](https://img.shields.io/badge/swift-6.0%2B-orange)
![Editor Phase](https://img.shields.io/badge/Phase%202-In%20Progress-yellow)
![No Intel](https://img.shields.io/badge/Intel%20Support-NONE-red)

---

## 🧠 Modern Game Engine for Modern Apple Hardware

**RealityEditor** is a native 3D engine editor built exclusively with **Xcode 26**, targeting **RealityKit**, **Swift 6**, and **Metal**. It is optimized for **Apple Silicon ARM64** and requires the latest operating systems currently in beta:

> 🔒 **Minimum Requirements**  
> - macOS 26  
> - iOS 26  
> - iPadOS 26  
> - tvOS 26  
> - Xcode 26  
> - Swift 6

**This is intentional.** RealityEditor leverages many new frameworks, APIs, and Swift language features that are **only available in the current 2025 OS cycle**.

> 🚫 No cross-platform hacks  
> 🚫 No C# runtimes  
> 🚫 No Intel binaries  
> 🔒 100% closed-source (for now)

---

## 📐 Editor Breakdown

| Module                | Description |
|----------------------|-------------|
| `RealityViewport`     | SwiftUI + RealityKit scene renderer (grid, camera, axis, gizmos) |
| `RealityInspector`    | Node outliner, property editor, selection handling |
| `RealityFileSystem`   | USDZ/Reality file import and internal asset tracking |
| `Core/Nodes`          | Protocol-driven scene node types (Model, Light, Camera) |
| `Core/Managers`       | Runtime logic: scene updates, selection, transform sync |
| `Views/Mac`, `Views/iPhone` | Platform-specific layout logic for desktop and mobile (iPad & tvOS planned) |

---

## ✅ Implemented Features

- ✅ Modular scene graph with `SceneNode` protocol
- ✅ SwiftUI `RealityView` 3D rendering
- ✅ Orbit, pan, zoom controls (Blender-style)
- ✅ Selection outlines, glow, and gizmo overlays
- ✅ USDZ + Reality file import (async, sandbox-safe)
- ✅ Multi-platform layout (macOS full; iOS basic)

---

## 🚧 In Progress (Phase 2)

- [x] Core camera + node selection system
- [ ] Node duplication & multi-selection
- [ ] Scene save/load file format (`.realityscene`)
- [ ] Undo/redo system
- [ ] Live property editing via SwiftData
- [ ] Inspector panel enhancements

---

## 🧱 Future Modularization

Once RealityEditor is more mature, it will be broken down into standalone, **closed-source** Apple-native frameworks:

- `RealityViewport.xcframework` — 3D view, grid, camera, lighting
- `RealityInspector.xcframework` — Outliner, properties panel, selection UI
- `RealityFileSystem.xcframework` — File import, asset sandboxing

These components will power **Orchard**, a Swift+C++ runtime engine for Apple platforms.

---

## 🔐 Licensing & Distribution

- Orchard and RealityEditor are **private** and will remain **closed source**
- This repository contains **public documentation only**
- Future `.xcframework` binaries may be released to assist others building native tools — once **IP protection** is in place
- No source code will be published

---

## ⚠️ Important Notes

- This project **requires Xcode 26 and OS versions currently in beta**
- Do not attempt to build unless you have **developer access to macOS 26+ / iOS 26+**
- Some APIs in use are **exclusive to 2025 platform releases**

> RealityEditor is forward-looking by design. It's not built for legacy compatibility — it’s built for what’s next.

---

## 📚 Philosophy: Teach by Blueprint, Not by Source

- Learn how a native SwiftUI+RealityKit editor is architected
- Get inspired by modular structure
- Build your own tools, from scratch, with confidence

> Questions?  
> Tag `@Lithalean` on GitHub.  
> Public `#darwin-dev` community server coming soon.

---
