//
//  ViewportView.swift
//  RealityEditor
//
//  Created by Tyler Allen on 6/15/25.
//


// RealityViewport/ViewportView.swift
import SwiftUI
import RealityKit
import simd

struct ViewportView: View {
    @ObservedObject var sceneManager: SceneManager
    @StateObject private var cameraController = CameraController()
    
    var body: some View {
        RealityView { content in
            setupViewport(content)
        } update: { content in
            updateViewport(content)
        }
        .gesture(cameraControlGestures())
        .onTapGesture { location in
            handleViewportTap(at: location)
        }
    }
    
    // MARK: - Viewport Setup
    private func setupViewport(_ content: RealityViewContent) {
        // Add 3D grid
        addGrid(to: content)
    }
    
    private func updateViewport(_ content: RealityViewContent) {
        // Clear existing scene entities (keep grid)
        content.entities.removeAll { entity in
            // Don't remove grid entities
            return !(entity.name.hasPrefix("grid_"))
        }
        
        // Add grid if not present
        if content.entities.isEmpty || !content.entities.contains(where: { $0.name.hasPrefix("grid_") }) {
            addGrid(to: content)
        }
        
        // Add lights
        for lightNode in sceneManager.lightNodes {
            if let light = lightNode.createRealityKitLight() {
                light.position = lightNode.position
                light.orientation = lightNode.rotation
                light.name = "light_\(lightNode.id.uuidString)"
                content.add(light)
            }
        }
        
        // Add models
        for modelNode in sceneManager.modelNodes {
            if let entity = modelNode.modelEntity {
                // Create a copy to avoid entity being in multiple scenes
                let entityCopy = entity.clone(recursive: true)
                entityCopy.position = modelNode.position
                entityCopy.orientation = modelNode.rotation
                entityCopy.scale = modelNode.scale
                entityCopy.name = "model_\(modelNode.id.uuidString)"
                content.add(entityCopy)
            }
        }
    }
    
    // MARK: - Grid System
    private func addGrid(to content: RealityViewContent) {
        let gridSize: Float = 20
        let gridSpacing: Float = 1
        let lineCount = Int(gridSize / gridSpacing)
        
        // Create grid material
        var gridMaterial = SimpleMaterial()
        gridMaterial.color = .init(tint: .gray.withAlphaComponent(0.3))
        gridMaterial.isMetallic = false
        gridMaterial.roughness = 1.0
        
        for i in -lineCount...lineCount {
            let offset = Float(i) * gridSpacing
            
            // X-direction lines (parallel to X-axis)
            let xLine = createGridLine(
                from: [-gridSize/2, 0, offset],
                to: [gridSize/2, 0, offset],
                material: gridMaterial
            )
            xLine.name = "grid_x_\(i)"
            content.add(xLine)
            
            // Z-direction lines (parallel to Z-axis)
            let zLine = createGridLine(
                from: [offset, 0, -gridSize/2],
                to: [offset, 0, gridSize/2],
                material: gridMaterial
            )
            zLine.name = "grid_z_\(i)"
            content.add(zLine)
        }
        
        // Add origin axes (brighter colored)
        addOriginAxes(to: content)
    }
    
    private func createGridLine(from start: SIMD3<Float>, to end: SIMD3<Float>, material: SimpleMaterial) -> ModelEntity {
        let distance = length(end - start)
        let center = (start + end) / 2
        
        let mesh = MeshResource.generateCylinder(height: distance, radius: 0.005)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        entity.position = center
        
        // Align with the line direction
        let direction = normalize(end - start)
        if abs(direction.x) > 0.5 {
            // Line is along X-axis, rotate to align
            entity.orientation = simd_quatf(angle: Float.pi/2, axis: [0, 0, 1])
        }
        // Z-axis lines are already aligned correctly (default orientation)
        
        return entity
    }
    
    private func addOriginAxes(to content: RealityViewContent) {
        let axisLength: Float = 2.0
        let axisRadius: Float = 0.02
        
        // X-axis (Red)
        var redMaterial = SimpleMaterial()
        redMaterial.color = .init(tint: .red)
        redMaterial.isMetallic = false
        
        let xAxis = ModelEntity(
            mesh: MeshResource.generateCylinder(height: axisLength, radius: axisRadius),
            materials: [redMaterial]
        )
        xAxis.position = [axisLength/2, 0, 0]
        xAxis.orientation = simd_quatf(angle: Float.pi/2, axis: [0, 0, 1])
        xAxis.name = "grid_axis_x"
        content.add(xAxis)
        
        // Y-axis (Green)
        var greenMaterial = SimpleMaterial()
        greenMaterial.color = .init(tint: .green)
        greenMaterial.isMetallic = false
        
        let yAxis = ModelEntity(
            mesh: MeshResource.generateCylinder(height: axisLength, radius: axisRadius),
            materials: [greenMaterial]
        )
        yAxis.position = [0, axisLength/2, 0]
        yAxis.name = "grid_axis_y"
        content.add(yAxis)
        
        // Z-axis (Blue)
        var blueMaterial = SimpleMaterial()
        blueMaterial.color = .init(tint: .blue)
        blueMaterial.isMetallic = false
        
        let zAxis = ModelEntity(
            mesh: MeshResource.generateCylinder(height: axisLength, radius: axisRadius),
            materials: [blueMaterial]
        )
        zAxis.position = [0, 0, axisLength/2]
        zAxis.orientation = simd_quatf(angle: Float.pi/2, axis: [1, 0, 0])
        zAxis.name = "grid_axis_z"
        content.add(zAxis)
    }
    
    // MARK: - Input Handling
    private func cameraControlGestures() -> some Gesture {
        guard let camera = sceneManager.activeCamera else {
            return DragGesture().onChanged { _ in }
        }
        
        return SimultaneousGesture(
            // Orbit gesture
            DragGesture()
                .onChanged { value in
                    let deltaX = Float(value.translation.x) * 0.01
                    let deltaY = Float(value.translation.y) * 0.01
                    cameraController.orbitCamera(camera, deltaX: deltaX, deltaY: -deltaY)
                },
            
            // Zoom gesture
            MagnificationGesture()
                .onChanged { value in
                    let delta = Float(value - 1.0)
                    cameraController.zoomCamera(camera, delta: -delta)
                }
        )
    }
    
    private func handleViewportTap(at location: CGPoint) {
        // For now, just deselect
        // TODO: Implement 3D picking to select objects
        sceneManager.deselectNode()
    }
}