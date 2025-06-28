// RealityInspector/OutlinerView.swift
import SwiftUI

struct OutlinerView: View {
    @ObservedObject var sceneManager: SceneManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Outliner")
                .font(.headline)
                .padding(.horizontal, 16)
                .padding(.top, 12)
            
            // Scene hierarchy
            List {
                // Scene header
                Label("Scene", systemImage: "globe")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .listRowBackground(Color.gray.opacity(0.15))
                
                // Camera nodes
                ForEach(sceneManager.cameraNodes, id: \.id) { camera in
                    NodeRow(
                        node: camera,
                        isSelected: sceneManager.selectedNode?.id == camera.id,
                        isActive: camera.isActive
                    ) {
                        sceneManager.selectNode(camera)
                    }
                }
                
                // Light nodes
                ForEach(sceneManager.lightNodes, id: \.id) { light in
                    NodeRow(
                        node: light,
                        isSelected: sceneManager.selectedNode?.id == light.id
                    ) {
                        sceneManager.selectNode(light)
                    }
                }
                
                // Model nodes
                ForEach(sceneManager.modelNodes, id: \.id) { model in
                    NodeRow(
                        node: model,
                        isSelected: sceneManager.selectedNode?.id == model.id
                    ) {
                        sceneManager.selectNode(model)
                    }
                }
            }
            .listStyle(.sidebar)
        }
    }
}

// MARK: - Node Row Component
struct NodeRow: View {
    let node: any SceneNode
    let isSelected: Bool
    let isActive: Bool
    let onTap: () -> Void
    
    init(node: any SceneNode, isSelected: Bool, isActive: Bool = false, onTap: @escaping () -> Void) {
        self.node = node
        self.isSelected = isSelected
        self.isActive = isActive
        self.onTap = onTap
    }
    
    var body: some View {
        HStack {
            // Node type icon
            Image(systemName: node.nodeType.iconName)
                .foregroundColor(.blue)
                .frame(width: 20)
            
            // Node name
            Text(node.name)
                .lineLimit(1)
                .foregroundColor(.primary)
            
            Spacer()
            
            // Active indicator (for cameras)
            if isActive {
                Image(systemName: "eye.fill")
                    .foregroundColor(.green)
                    .font(.caption)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
        .listRowBackground(
            isSelected ? Color.blue.opacity(0.3) : Color.clear
        )
    }
}
