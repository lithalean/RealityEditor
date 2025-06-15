//
//  ModelNode.swift
//  RealityEditor
//
//  Created by Tyler Allen on 6/15/25.
//


// Core/Nodes/ModelNode.swift
import Foundation
import RealityKit
import simd

class ModelNode: BaseSceneNode {
    @Published var modelEntity: ModelEntity?
    @Published var modelURL: URL?
    @Published var isLoading: Bool = false
    
    init(name: String = "Model") {
        super.init(name: name, type: .model)
    }
    
    // Load model from URL
    func loadModel(from url: URL) async {
        await MainActor.run {
            isLoading = true
        }
        
        do {
            let entity = try await ModelEntity(contentsOf: url)
            
            // Auto-scale to reasonable size
            let bounds = entity.model?.mesh.bounds.extents ?? [1, 1, 1]
            let maxDimension = max(bounds.x, bounds.y, bounds.z)
            let scaleFactor = 2.0 / maxDimension
            entity.scale = [scaleFactor, scaleFactor, scaleFactor]
            
            await MainActor.run {
                self.modelEntity = entity
                self.modelURL = url
                self.name = url.deletingPathExtension().lastPathComponent
                self.isLoading = false
            }
        } catch {
            print("Failed to load model: \(error)")
            await MainActor.run {
                self.isLoading = false
            }
        }
    }
    
    // Get current bounds for camera framing
    var bounds: SIMD3<Float> {
        guard let entity = modelEntity else { return [1, 1, 1] }
        return entity.model?.mesh.bounds.extents ?? [1, 1, 1]
    }
}