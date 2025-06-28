//  PropertiesView.swift
//  RealityEditor

import SwiftUI
import simd

struct PropertiesView: View {
    var selectedNode: (any SceneNode)?

    // Mirror properties
    @State private var position: SIMD3<Float> = .zero
    @State private var rotation: simd_quatf = simd_quatf(angle: 0, axis: [0, 1, 0])
    @State private var scale: SIMD3<Float> = .one

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                GroupBox(label: Label("Transform", systemImage: "move.3d")) {
                    Vector3Editor(vector: $position)
                    QuaternionEditor(quaternion: $rotation)
                    Vector3Editor(vector: $scale)
                }

                if let light = selectedNode as? LightNode {
                    LightPropertiesView(light: light)
                } else if let modelNode = selectedNode as? ModelNode {
                    ModelPropertiesView(modelNode: modelNode)
                } else {
                    EmptyPropertiesView()
                }
            }
            .padding()
        }
        .onAppear {
            syncWithNode()
        }
    }

    private func syncWithNode() {
        guard let node = selectedNode else { return }
        position = node.position
        rotation = node.rotation
        scale = node.scale
    }
}

#Preview {
    PropertiesView(selectedNode: nil)
}
