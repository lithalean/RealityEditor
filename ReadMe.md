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

**Node System** 
- SceneNode protocol with transform properties
- BaseSceneNode implementation
- Node types: Camera, Light, Model
- Complete transform system (position, rotation, scale)

**Viewport**
- RealityView integration with modern API
- 3D grid with colored axes (X=red, Y=green, Z=blue)
- Camera controller with orbit controls
- Grid rendering system
- Model entity rendering
- Light entity creation and rendering
- Selection highlighting system

**Inspector**
- InspectorView container
- OutlinerView for scene hierarchy
- PropertiesView for node properties
- Node selection system

**Scene Management**
- SceneManager with node collection
- Default scene setup (Camera + Light at Blender positions)
- Active camera tracking
- Node addition/removal
- Model import functionality

### 🚧 In Progress

- Camera zoom/pan controls (orbit works)
- Property editing binding
- Frame all/selected implementation
- 3D object picking in viewport
- Camera sync improvements

---

## 📋 Development Phases

### Phase 1: Foundation
**Status**: ✅ **COMPLETED**

#### Completed Features
- ✅ Project structure with modular architecture
- ✅ Complete node system (Camera, Light, Model)
- ✅ RealityViewport with grid and axes
- ✅ Model loading and rendering pipeline
- ✅ Light rendering system
- ✅ Basic camera orbit controls
- ✅ Selection highlighting
- ✅ Inspector UI with outliner and properties
- ✅ USDZ import functionality
- ✅ Default scene setup matching Blender

#### Known Issues to Address
- Camera zoom needs gesture refinement
- Pan controls not yet implemented
- Property fields need two-way binding
- 3D picking for viewport selection

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

### Quick Fixes (Before Phase 2)
1. **Camera Controls**
   - Add pan gesture support
   - Refine zoom sensitivity
   - Implement reset camera function

2. **Property Binding**
   - Connect transform fields to node values
   - Add value validation
   - Implement live updates

3. **Frame Operations**
   - Wire up "Frame All" button
   - Wire up "Frame Selected" button
   - Add keyboard shortcuts

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

*Last updated: Phase 1 complete, ViewportView rendering fixed*  
*Next milestone: Camera control polish & Phase 2 start*