# 🛠️ RealityEditor

*Next-Generation 3D Scene Editor for Apple Silicon*

![Platform](https://img.shields.io/badge/platform-macOS%2026%2B-blue)
![Architecture](https://img.shields.io/badge/arch-ARM64%20ONLY-green)
![Swift Version](https://img.shields.io/badge/swift-6.0%2B-orange)
![Xcode](https://img.shields.io/badge/Xcode-26%2B-red)
![Intel Support](https://img.shields.io/badge/Intel%20Support-NONE-black)

---

## 🚀 Built for the Future

**RealityEditor** is a cutting-edge 3D scene editor that leverages the absolute latest Apple technologies. This is not a compatibility project.

> ⚡ **Minimum Requirements**  
> - **macOS 26** (required)  
> - **iOS 26** (required)  
> - **Xcode 26** (required)  
> - **Apple Silicon** (M1/M2/M3/M4 only)  
> - **Swift 6** language features

> - ❌ NO Intel support (ever)  
> - ❌ NO backward compatibility  
> - ❌ NO cross-platform considerations  
> - ❌ NO legacy API usage

---

## 🎯 Why These Requirements?

This project uses APIs and frameworks that **only exist** in the 2025+ Apple ecosystem:
- Latest RealityKit rendering pipeline
- Swift 6 concurrency features
- Modern SwiftUI layout system
- Apple Silicon-exclusive Metal features
- New file coordination APIs

---

## 📊 Current Status

### Phase 1: Foundation ✅
- Modern RealityKit viewport with persistent entities
- Advanced selection system with visual feedback
- Transform gizmos (translate, rotate, scale)
- Multi-platform architecture (macOS/iOS)

### Phase 2: Scene Management 🚧
- Multi-selection with modern gestures
- Scene graph persistence
- Undo/redo with Swift 6 features
- Advanced node relationships
- iPhone adaptive inspector panel ✅
- Resizable inspector on both platforms ✅
- Unified icon-only toolbar (Mac + iOS) ✅

---

## 🏗️ Architecture


```
RealityEditor/
├── Core/                   # Pure Swift 6 business logic
│   ├── Nodes/             # Actor-based scene graph
│   ├── Managers/          # @Observable state management
│   └── Components/        # Modular tools
├── RealityViewport/       # Next-gen RealityKit rendering
├── RealityInspector/      # SwiftUI 5.0 property system
└── Views/                 # Platform-adaptive layouts
    ├── Mac/               # macOS 26 specific
    └── iPhone/            # iOS 26 specific
```

---

## 💻 Development Requirements

### You MUST Have:
- **Mac with Apple Silicon** (M1 minimum, M3 recommended)
- **macOS 26** Developer Beta or later
- **Xcode 26** Developer Beta or later
- **Active Apple Developer account** (for beta access)

### You CANNOT Use:
- Intel Macs (will not compile)
- macOS 25 or earlier (missing APIs)
- Xcode 25 or earlier (missing Swift 6)
- Rosetta 2 (explicitly disabled)

---

## 🚧 Current Development Focus

Working on features that are only possible with 2025+ APIs:
- Entity persistence with new RealityKit features
- Swift 6 actor-based scene graph
- Metal 4 rendering optimizations
- SwiftData integration for project files
- iPhone-specific UI improvements (sliding inspector, grey theming)
