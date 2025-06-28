//
//  LightNode.swift
//  RealityEditor
//
//  Created by Tyler Allen on 6/15/25.
//


// Core/Nodes/LightNode.swift
import Foundation
import RealityKit
import simd

class LightNode: BaseSceneNode {
    @Published var lightType: LightType
    @Published var color: SIMD3<Float>
    @Published var intensity: Float
    @Published var range: Float // For point lights
    
    enum LightType: String, CaseIterable {
        case directional = "Directional"
        case point = "Point"
    }
    
    init(name: String = "Light", type: LightType = .directional) {
        self.lightType = type
        self.color = [1, 1, 1] // White light
        self.intensity = 1000
        self.range = 10
        
        let startPosition: SIMD3<Float> = type == .directional ? [0, 3, 0] : [0, 2, 2]
        super.init(name: name, type: .light, position: startPosition)
        
        // Default directional light pointing down
        if type == .directional {
            self.rotation = simd_quatf(angle: -Float.pi/4, axis: [1, 0, 0])
        }
    }
    
    // Create RealityKit light entity
    func createRealityKitLight() -> Entity? {
        switch lightType {
        case .directional:
            let light = DirectionalLight()
            light.light.intensity = intensity
            light.light.color = .init(red: CGFloat(color.x), green: CGFloat(color.y), blue: CGFloat(color.z), alpha: 1.0)
            return light
        case .point:
            let light = PointLight()
            light.light.intensity = intensity
            light.light.color = .init(red: CGFloat(color.x), green: CGFloat(color.y), blue: CGFloat(color.z), alpha: 1.0)
            light.light.attenuationRadius = range
            return light
        }
    }
}
