//  InspectorView.swift
//  RealityEditor

import SwiftUI

struct InspectorView: View {
    @ObservedObject var sceneManager: SceneManager

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Outliner section
            OutlinerView(sceneManager: sceneManager)
                .frame(height: 250)

            Divider()

            // Properties section
            if let selectedNode = sceneManager.selectedNode {
                PropertiesView(selectedNode: selectedNode)
            } else {
                VStack {
                    Image(systemName: "square.dashed")
                        .font(.system(size: 48))
                        .foregroundColor(.secondary)
                    Text("No Selection")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

            Spacer()
        }
        .frame(width: 280)
        .background(Color(.windowBackgroundColor))
    }
}

#Preview {
    InspectorView(sceneManager: SceneManager())
}
