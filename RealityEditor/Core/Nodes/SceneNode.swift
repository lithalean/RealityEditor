//
//  SceneNode.swift
//  RealityEditor
//
//  Created by Tyler Allen on 6/15/25.
//


// Core/Nodes/SceneNode.swift
import Foundation
import simd

// MARK: - Scene Node Protocol
protocol SceneNode: AnyObject, ObservableObject, Identifiable {
    var id: UUID { get }
    var name: String { get set }
    var position: SIMD3<Float> { get set }
    var rotation: simd_quatf { get set }
    var scale: SIMD3<Float> { get set }
    var nodeType: NodeType { get }
}

enum NodeType: String, CaseIterable {
    case camera = "Camera"
    case light = "Light"
    case model = "Model"
    case empty = "Empty"
    
    var iconName: String {
        switch self {
        case .camera: return "camera"
        case .light: return "lightbulb"
        case .model: return "cube"
        case .empty: return "circle"
        }
    }
}

// MARK: - Base Scene Node Implementation
class BaseSceneNode: SceneNode {
    let id = UUID()
    @Published var name: String
    @Published var position: SIMD3<Float>
    @Published var rotation: simd_quatf
    @Published var scale: SIMD3<Float>
    let nodeType: NodeType
    
    init(name: String, type: NodeType, position: SIMD3<Float> = [0, 0, 0]) {
        self.name = name
        self.nodeType = type
        self.position = position
        self.rotation = simd_quatf(angle: 0, axis: [0, 1, 0])
        self.scale = [1, 1, 1]
    }
    
    // Transform matrix for RealityKit
    var transformMatrix: float4x4 {
        let translationMatrix = float4x4(translation: position)
        let rotationMatrix = float4x4(rotation)
        let scaleMatrix = float4x4(scale: scale)
        return translationMatrix * rotationMatrix * scaleMatrix
    }
}
