# RealityEditor Project Roadmap

> **Goal**: Build a Godot-inspired 3D scene editor optimized for Apple's ecosystem using RealityKit and Darwin ARM64.

---

## 🎯 Project Vision

**RealityEditor** = RealityViewport + RealityInspector + Future Modules

Starting with core scene editing functionality, then gradually adding Godot-inspired features as modular Apple-native components.

---

## 📊 Current Project Status

### ✅ Implemented Features

**Project Structure**
- macOS project with SwiftUI + RealityKit (Xcode 16, macOS 16)
- Modular folder organization (Core, RealityViewport, RealityInspector, App)
- Basic SwiftData integration
- HSplitView for proper macOS panel layout

**Node System** 
- SceneNode protocol with transform properties
- BaseSceneNode implementation
- Node types: Camera, Light, Model
- Complete transform system (position, rotation, scale)
- Model loading from USDZ files with auto-scaling

**Viewport** ✨
- RealityView with PerspectiveCamera entity
- Proper 3D perspective rendering
- 3D grid with thin cylinder lines
- Colored axes (X=red, Y=green, Z=blue)
- Camera controller with working orbit controls
- Model entity rendering with cloning
- Light entity creation (Directional, Point)
- Selection highlighting (blue tint)
- Ambient lighting for visibility

**Inspector**
- InspectorView with proper macOS styling
- OutlinerView for scene hierarchy
- PropertiesView for node properties
- Working inspector toggle button
- Node selection system with visual feedback

**Scene Management**
- SceneManager with observable node collection
- Default scene setup (Camera + Light at Blender positions)
- Active camera tracking and switching
- Node addition/removal with selection handling
- Async model import functionality

### 🔧 Issues Fixed
- ✅ 3D perspective now working (added PerspectiveCamera entity)
- ✅ Grid rendering fixed (cylinders instead of boxes)
- ✅ Inspector toggle working (HSplitView + proper button)
- ✅ macOS color handling (NSColor instead of UIColor)
- ✅ Proper entity management in update loop

### 🚧 Remaining Polish

- Camera zoom sensitivity adjustment
- Pan controls implementation
- Property editing two-way binding
- 3D picking for viewport selection
- Frame all/selected button functionality

---

## 📋 Development Phases

### Phase 1: Foundation
**Status**: ✅ **COMPLETED** 🎉

#### Completed Features
- ✅ Project structure with modular architecture
- ✅ Complete node system (Camera, Light, Model)
- ✅ 3D RealityViewport with proper perspective
- ✅ Grid rendering with thin lines and colored axes
- ✅ Model loading and rendering pipeline
- ✅ Light entity rendering (Point, Directional)
- ✅ Camera orbit controls with gestures
- ✅ Selection highlighting with blue tint
- ✅ Inspector UI with working toggle
- ✅ USDZ import with file picker
- ✅ Scene hierarchy in outliner
- ✅ Property display panels

#### Technical Achievements
- Proper PerspectiveCamera entity in RealityView
- Efficient entity cloning for updates
- Clean separation of grid/scene entities
- Cross-platform color handling (macOS/iOS)
- Modern RealityKit API usage

---

### Phase 2: Scene Management
**Status**: ⏳ Ready to Start

#### Core Features
- Multi-selection system
- Node duplication
- Advanced deletion (with children)
- Parent/unparent operations
- Focus/frame operations
- Basic scene persistence

#### Success Criteria
- Can select multiple nodes
- Can duplicate nodes with offset
- Can save/load scenes
- Frame selected works properly
- Smooth performance with 50+ nodes

---

### Phase 3: Transform Tools
**Status**: ⏳ Planned

#### Core Features
- Visual transform gizmos
- 3D object picking
- Drag-based manipulation
- Numerical transform input
- Axis constraints
- Snap functionality

#### Success Criteria
- Intuitive gizmo interaction
- Precise object positioning
- Smooth dragging performance
- Working snap system

---

### Phase 4: Advanced Inspector
**Status**: ⏳ Planned

#### Core Features
- Live property editing
- Material property inspector
- Advanced camera controls
- Light property editing
- Search/filter in outliner
- Property animation preview

#### Success Criteria
- Real-time property updates
- Professional UI polish
- Efficient property panels
- Responsive editing

---

### Phase 5: Asset Pipeline
**Status**: ⏳ Planned

#### Core Features
- Asset browser
- Thumbnail generation
- Drag & drop from browser
- Multiple format support
- Asset organization
- Quick preview

#### Success Criteria
- Fast asset browsing
- Reliable import pipeline
- Good thumbnail quality
- Intuitive organization

---

## 🚀 Future Modules

### Short Term
- **RealityScript** - Swift-based scripting system
- **RealityPhysics** - Physics simulation and debugging
- **RealityAnimation** - Timeline and keyframe animation

### Medium Term
- **RealityAudio** - Spatial audio tools
- **RealityTerrain** - Terrain generation and editing
- **RealityEffects** - Particle systems and VFX

### Long Term
- **RealityAR** - AR-specific tools and preview
- **RealityNetwork** - Collaborative editing
- **RealityBuild** - Export and optimization tools

---

## 🛠️ Technical Priorities

### Immediate Focus
1. Complete model loading and rendering
2. Fix camera controls
3. Implement selection visualization
4. Connect property editing

### Architecture Goals
- Maintain clean module separation
- Keep RealityKit usage isolated
- Design for testability
- Optimize for Apple Silicon

### Quality Standards
- 60fps viewport performance
- Smooth interaction feedback
- Memory-efficient scene handling
- No crashes during normal use

---

## 📈 Milestone Tracking

### Next Milestone: Basic Editor
- [ ] Import and display models
- [ ] Working camera controls
- [ ] Selection and highlighting
- [ ] Property editing
- [ ] Save/load scenes

### Following Milestone: Production Ready
- [ ] Multi-selection
- [ ] Transform gizmos
- [ ] Undo/redo system
- [ ] Asset browser
- [ ] Performance optimization

---

## 🎯 Immediate Next Steps

### Quick Polish (Before Phase 2)
1. **Camera Enhancements**
   - Add pan gesture (Option+drag or right-click drag)
   - Fine-tune zoom sensitivity
   - Wire up Frame All/Selected buttons
   - Add reset camera function

2. **Property Editing**
   - Implement two-way binding for transform fields
   - Add numeric input validation
   - Enable real-time updates
   - Format numbers properly (2 decimal places)

3. **Keyboard Shortcuts**
   - F - Frame selected
   - A - Frame all
   - Delete - Remove selected node
   - Cmd+D - Duplicate node
   - Cmd+I - Import model

### Code Snippets for Quick Wins

**Pan Gesture Addition:**
```swift
// Add to cameraControlGestures()
let pan = DragGesture(minimumDistance: 0)
    .modifiers(.option)
    .onChanged { value in
        let dx = Float(value.translation.width) * 0.002
        let dy = Float(value.translation.height) * 0.002
        cameraController.panCamera(camera, deltaX: dx, deltaY: dy)
    }
```

**Frame Operations:**
```swift
// In ContentView toolbar
Button("Frame All") {
    if let camera = sceneManager.activeCamera {
        cameraController.frameAllNodes(camera, nodes: sceneManager.nodes)
    }
}
```

### Phase 2 Implementation Plan
1. Create SelectionManager class
2. Update OutlinerView for multi-selection
3. Implement node operations (duplicate, group)
4. Add scene file format (.reality)
5. Create keyboard shortcut system

---

## 🛠️ Technical Details

### Current Stack
- **Platform**: macOS 16+ (originally iOS, now desktop)
- **IDE**: Xcode 16
- **Frameworks**: SwiftUI, RealityKit, SwiftData
- **Architecture**: MVVM with ObservableObject

### Code Structure
```
RealityEditor/
├── App/
│   ├── ContentView.swift
│   └── RealityEditorApp.swift
├── Core/
│   ├── Nodes/
│   │   ├── SceneNode.swift
│   │   ├── BaseSceneNode.swift
│   │   ├── CameraNode.swift
│   │   ├── LightNode.swift
│   │   └── ModelNode.swift
│   └── Managers/
│       └── SceneManager.swift
├── RealityViewport/
│   ├── ViewportView.swift
│   └── CameraController.swift
└── RealityInspector/
    ├── InspectorView.swift
    ├── OutlinerView.swift
    └── PropertiesView.swift
```

---

*Last updated: Phase 1 COMPLETE! 3D rendering working perfectly*  
*Next milestone: Polish camera controls, then Phase 2 multi-selection*