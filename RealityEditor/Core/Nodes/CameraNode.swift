//
//  CameraNode.swift
//  RealityEditor
//
//  Created by Tyler Allen on 6/15/25.
//


// Core/Nodes/CameraNode.swift
import Foundation
import simd

class CameraNode: BaseSceneNode {
    @Published var fov: Float
    @Published var nearPlane: Float
    @Published var farPlane: Float
    @Published var projectionType: ProjectionType
    @Published var isActive: Bool = false
    
    enum ProjectionType: String, CaseIterable {
        case perspective = "Perspective"
        case orthogonal = "Orthogonal"
    }
    
    init(name: String = "Camera") {
        self.fov = 60.0
        self.nearPlane = 0.1
        self.farPlane = 100.0
        self.projectionType = .perspective
        super.init(name: name, type: .camera, position: [0, 0, 5])
    }
    
    // Camera-specific methods
    func lookAt(target: SIMD3<Float>, up: SIMD3<Float> = [0, 1, 0]) {
        let forward = normalize(target - position)
        let right = normalize(cross(forward, up))
        let actualUp = cross(right, forward)
        
        let rotationMatrix = float3x3(columns: (right, actualUp, -forward))
        rotation = simd_quatf(rotationMatrix)
    }
    
    var viewMatrix: float4x4 {
        return transformMatrix.inverse
    }
    
    var projectionMatrix: float4x4 {
        switch projectionType {
        case .perspective:
            return float4x4(perspectiveProjectionFov: fov.degreesToRadians,
                          aspectRatio: 1.0,
                          nearZ: nearPlane,
                          farZ: farPlane)
        case .orthogonal:
            let size = fov
            return float4x4(orthographicProjectionLeft: -size/2,
                          right: size/2,
                          bottom: -size/2,
                          top: size/2,
                          nearZ: nearPlane,
                          farZ: farPlane)
        }
    }
}