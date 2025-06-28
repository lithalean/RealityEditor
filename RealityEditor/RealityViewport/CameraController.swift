// RealityViewport/CameraController.swift
import Foundation
import simd

class CameraController: ObservableObject {
    @Published var controlMode: ControlMode = .orbit
    
    // Orbit control state
    private var orbitTarget: SIMD3<Float> = [0, 0, 0]
    private var orbitRadius: Float = 10.0
    private var orbitAngleX: Float = 0.78  // Blender default horizontal angle
    private var orbitAngleY: Float = 0.65  // Blender default vertical angle
    
    // State tracking to prevent feedback loops
    private var isUpdatingFromCamera = false
    
    enum ControlMode: String, CaseIterable {
        case orbit = "Orbit"
        case locked = "Locked"
    }
    
    // MARK: - Sync with Camera Node
    func syncWithCamera(_ camera: CameraNode) {
        guard !isUpdatingFromCamera else { return }
        
        // Calculate orbit parameters from camera position
        let toCamera = camera.position - orbitTarget
        let distance = length(toCamera)
        
        if distance > 0.001 {
            orbitRadius = distance
            let normalized = normalize(toCamera)
            
            // Calculate angles from position
            orbitAngleY = asin(normalized.y)
            orbitAngleX = atan2(normalized.z, normalized.x)
        }
    }
    
    // MARK: - Orbit Controls
    func orbitCamera(_ camera: CameraNode, deltaX: Float, deltaY: Float) {
        guard controlMode == .orbit else { return }
        
        orbitAngleX += deltaX
        orbitAngleY += deltaY
        
        // Clamp vertical rotation to prevent flipping
        orbitAngleY = max(-Float.pi/2 + 0.1, min(Float.pi/2 - 0.1, orbitAngleY))
        
        updateCameraFromOrbit(camera)
    }
    
    func zoomCamera(_ camera: CameraNode, delta: Float) {
        guard controlMode == .orbit else { return }
        
        orbitRadius *= (1.0 + delta)
        orbitRadius = max(0.5, min(50.0, orbitRadius))
        
        updateCameraFromOrbit(camera)
    }
    
    func panCamera(_ camera: CameraNode, deltaX: Float, deltaY: Float) {
        guard controlMode == .orbit else { return }
        
        // Calculate right and up vectors
        let forward = normalize(orbitTarget - camera.position)
        let right = normalize(cross(forward, [0, 1, 0]))
        let up = normalize(cross(right, forward))
        
        // Pan the orbit target
        let panSpeed = orbitRadius * 0.002
        orbitTarget += right * deltaX * panSpeed - up * deltaY * panSpeed
        
        updateCameraFromOrbit(camera)
    }
    
    private func updateCameraFromOrbit(_ camera: CameraNode) {
        isUpdatingFromCamera = true
        
        // Convert spherical coordinates to cartesian
        let x = orbitRadius * cos(orbitAngleY) * cos(orbitAngleX)
        let y = orbitRadius * sin(orbitAngleY)
        let z = orbitRadius * cos(orbitAngleY) * sin(orbitAngleX)
        
        camera.position = orbitTarget + [x, y, z]
        camera.lookAt(target: orbitTarget)
        
        isUpdatingFromCamera = false
    }
    
    // MARK: - Camera Utilities
    func focusOnNode(_ camera: CameraNode, node: any SceneNode) {
        orbitTarget = node.position
        
        // Set appropriate distance based on node type
        switch node.nodeType {
        case .model:
            if let modelNode = node as? ModelNode {
                let bounds = modelNode.bounds
                let maxDimension = max(bounds.x, bounds.y, bounds.z) * max(modelNode.scale.x, modelNode.scale.y, modelNode.scale.z)
                orbitRadius = maxDimension * 3.0
            } else {
                orbitRadius = 5.0
            }
        case .camera, .light, .empty:
            orbitRadius = 3.0
        }
        
        updateCameraFromOrbit(camera)
    }
    
    func frameAllNodes(_ camera: CameraNode, nodes: [any SceneNode]) {
        guard !nodes.isEmpty else { return }
        
        // Calculate bounding box of all nodes
        var minBounds = SIMD3<Float>(Float.greatestFiniteMagnitude, Float.greatestFiniteMagnitude, Float.greatestFiniteMagnitude)
        var maxBounds = SIMD3<Float>(-Float.greatestFiniteMagnitude, -Float.greatestFiniteMagnitude, -Float.greatestFiniteMagnitude)
        
        for node in nodes {
            let nodePos = node.position
            
            if let modelNode = node as? ModelNode {
                // Include model bounds
                let halfBounds = (modelNode.bounds * modelNode.scale) / 2
                minBounds = min(minBounds, nodePos - halfBounds)
                maxBounds = max(maxBounds, nodePos + halfBounds)
            } else {
                minBounds = min(minBounds, nodePos)
                maxBounds = max(maxBounds, nodePos)
            }
        }
        
        // Set orbit target to center of bounding box
        orbitTarget = (minBounds + maxBounds) / 2
        
        // Set distance based on bounding box size
        let boundingSize = maxBounds - minBounds
        let maxDimension = max(boundingSize.x, boundingSize.y, boundingSize.z)
        orbitRadius = max(maxDimension * 2.0, 5.0)
        
        updateCameraFromOrbit(camera)
    }
    
    func resetCamera(_ camera: CameraNode) {
        orbitTarget = [0, 0, 0]
        orbitRadius = 10.0
        orbitAngleX = 0.78
        orbitAngleY = 0.65
        updateCameraFromOrbit(camera)
    }
}
