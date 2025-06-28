//
//  ViewportView.swift
//  RealityEditor
//

import SwiftUI
import RealityKit
import simd

struct ViewportView: View {
    @ObservedObject var sceneManager: SceneManager
    @StateObject private var cameraController = CameraController()
    
    var body: some View {
        RealityView { content in
            // MARK: - Initial Setup (One-Time)
            let gridSize: Float = 20
            let gridSpacing: Float = 1
            let lineCount = Int(gridSize / gridSpacing)
            
            var gridMaterial = SimpleMaterial()
            gridMaterial.color = .init(tint: .gray.withAlphaComponent(0.3))
            gridMaterial.metallic = .float(0)
            gridMaterial.roughness = .float(1)
            
            // Create proper grid lines using cylinders
            for i in -lineCount...lineCount {
                let offset = Float(i) * gridSpacing
                
                // X lines (running along X axis)
                let xLine = ModelEntity(
                    mesh: .generateCylinder(height: gridSize, radius: 0.005),
                    materials: [gridMaterial]
                )
                xLine.position = [0, 0, offset]
                xLine.orientation = simd_quatf(angle: .pi/2, axis: [0, 0, 1])
                xLine.name = "grid_x_\(i)"
                content.add(xLine)
                
                // Z lines (running along Z axis)
                let zLine = ModelEntity(
                    mesh: .generateCylinder(height: gridSize, radius: 0.005),
                    materials: [gridMaterial]
                )
                zLine.position = [offset, 0, 0]
                zLine.orientation = simd_quatf(angle: .pi/2, axis: [1, 0, 0])
                zLine.name = "grid_z_\(i)"
                content.add(zLine)
            }
            
            // Origin Axes
            let axisLength: Float = 2.0
            let axisRadius: Float = 0.02
            
            let xAxis = ModelEntity(
                mesh: .generateCylinder(height: axisLength, radius: axisRadius),
                materials: [SimpleMaterial(color: .red, isMetallic: false)]
            )
            xAxis.position = [axisLength / 2, 0, 0]
            xAxis.orientation = simd_quatf(angle: .pi / 2, axis: [0, 0, 1])
            xAxis.name = "grid_axis_x"
            content.add(xAxis)
            
            let yAxis = ModelEntity(
                mesh: .generateCylinder(height: axisLength, radius: axisRadius),
                materials: [SimpleMaterial(color: .green, isMetallic: false)]
            )
            yAxis.position = [0, axisLength / 2, 0]
            yAxis.name = "grid_axis_y"
            content.add(yAxis)
            
            let zAxis = ModelEntity(
                mesh: .generateCylinder(height: axisLength, radius: axisRadius),
                materials: [SimpleMaterial(color: .blue, isMetallic: false)]
            )
            zAxis.position = [0, 0, axisLength / 2]
            zAxis.orientation = simd_quatf(angle: .pi / 2, axis: [1, 0, 0])
            zAxis.name = "grid_axis_z"
            content.add(zAxis)
            
            // Ambient Light
            let light = DirectionalLight()
            light.light.intensity = 1000
            light.light.isRealWorldProxy = true
            light.orientation = simd_quatf(angle: -.pi/4, axis: [1, 0, 0])
            light.name = "ambient_light"
            content.add(light)
            
        } update: { content in
            // MARK: - Frame Updates
            content.entities.removeAll {
                !($0.name.hasPrefix("grid_") || $0.name == "ambient_light")
            }
            
            for lightNode in sceneManager.lightNodes {
                if let light = lightNode.createRealityKitLight() {
                    light.position = lightNode.position
                    light.orientation = lightNode.rotation
                    light.name = "light_\(lightNode.id.uuidString)"
                    content.add(light)
                }
            }
            
            for modelNode in sceneManager.modelNodes {
                if let entity = modelNode.modelEntity {
                    let clone = entity.clone(recursive: true)
                    clone.position = modelNode.position
                    clone.orientation = modelNode.rotation
                    clone.scale = modelNode.scale
                    clone.name = "model_\(modelNode.id.uuidString)"
                    
                    // Add selection highlight
                    if sceneManager.selectedNode?.id == modelNode.id,
                       let modelEntity = clone as? ModelEntity,
                       let model = modelEntity.model {
                        
                        var highlightedMaterials: [RealityKit.Material] = []
                        
                        for material in model.materials {
                            if var simpleMaterial = material as? SimpleMaterial {
                                // Tint blue for selection
                                #if os(macOS)
                                let currentColor = simpleMaterial.color.tint
                                var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
                                currentColor.getRed(&r, green: &g, blue: &b, alpha: &a)
                                simpleMaterial.color = .init(tint: NSColor(
                                    red: r * 0.7,
                                    green: g * 0.7,
                                    blue: min(b * 0.7 + 0.3, 1.0),
                                    alpha: a
                                ))
                                #else
                                simpleMaterial.color = .init(tint: .systemBlue.withAlphaComponent(0.8))
                                #endif
                                highlightedMaterials.append(simpleMaterial)
                            } else {
                                highlightedMaterials.append(material)
                            }
                        }
                        
                        modelEntity.model?.materials = highlightedMaterials
                    }
                    
                    content.add(clone)
                }
            }
            
            if let activeCamera = sceneManager.activeCamera {
                cameraController.syncWithCamera(activeCamera)
            }
        }
        .gesture(cameraControlGestures())
        .onTapGesture {
            sceneManager.deselectNode()
        }
    }
    
    // MARK: - Gesture Handling
    private func cameraControlGestures() -> some Gesture {
        let drag = DragGesture().onChanged { value in
            guard let camera = sceneManager.activeCamera else { return }
            let dx = Float(value.translation.width) * 0.01
            let dy = Float(value.translation.height) * 0.01
            cameraController.orbitCamera(camera, deltaX: dx, deltaY: -dy)
        }
        
        let zoom = MagnificationGesture().onChanged { value in
            guard let camera = sceneManager.activeCamera else { return }
            let delta = Float(value - 1.0)
            cameraController.zoomCamera(camera, delta: -delta)
        }
        
        return drag.simultaneously(with: zoom)
    }
}
