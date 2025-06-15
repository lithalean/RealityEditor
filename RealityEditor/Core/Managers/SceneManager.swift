//
//  SceneManager.swift
//  RealityEditor
//
//  Created by Tyler Allen on 6/15/25.
//


// Core/SceneManager/SceneManager.swift
import Foundation
import simd

class SceneManager: ObservableObject {
    @Published var nodes: [any SceneNode] = []
    @Published var selectedNode: (any SceneNode)?
    @Published var activeCamera: CameraNode?
    
    init() {
        setupDefaultScene()
    }
    
    // MARK: - Scene Setup
    private func setupDefaultScene() {
        // Default camera (Blender-style position)
        let camera = CameraNode(name: "Camera")
        camera.position = [7.48, 5.34, 6.50]
        camera.lookAt(target: [0, 0, 0])
        camera.isActive = true
        addNode(camera)
        setActiveCamera(camera)
        
        // Default light (Blender-style position)
        let light = LightNode(name: "Light", type: .point)
        light.position = [4.08, 5.90, -1.00]
        addNode(light)
    }
    
    // MARK: - Node Management
    func addNode(_ node: any SceneNode) {
        nodes.append(node)
    }
    
    func removeNode(_ node: any SceneNode) {
        nodes.removeAll { $0.id == node.id }
        
        // Clear selection if removing selected node
        if selectedNode?.id == node.id {
            selectedNode = nil
        }
        
        // Handle camera removal
        if let camera = node as? CameraNode, camera.id == activeCamera?.id {
            activeCamera = cameraNodes.first
            activeCamera?.isActive = true
        }
    }
    
    func selectNode(_ node: any SceneNode) {
        selectedNode = node
        
        // If selecting a camera, make it active
        if let camera = node as? CameraNode {
            setActiveCamera(camera)
        }
    }
    
    func deselectNode() {
        selectedNode = nil
    }
    
    // MARK: - Camera Management
    func setActiveCamera(_ camera: CameraNode) {
        // Deactivate current camera
        activeCamera?.isActive = false
        
        // Activate new camera
        camera.isActive = true
        activeCamera = camera
    }
    
    // MARK: - Model Import
    func importModel(from url: URL) async {
        let modelNode = ModelNode()
        await modelNode.loadModel(from: url)
        
        await MainActor.run {
            addNode(modelNode)
            selectNode(modelNode)
        }
    }
    
    // MARK: - Typed Node Access
    var cameraNodes: [CameraNode] {
        nodes.compactMap { $0 as? CameraNode }
    }
    
    var lightNodes: [LightNode] {
        nodes.compactMap { $0 as? LightNode }
    }
    
    var modelNodes: [ModelNode] {
        nodes.compactMap { $0 as? ModelNode }
    }
    
    // MARK: - Scene Queries
    func node(withId id: UUID) -> (any SceneNode)? {
        return nodes.first { $0.id == id }
    }
    
    func nodes(ofType type: NodeType) -> [any SceneNode] {
        return nodes.filter { $0.nodeType == type }
    }
}