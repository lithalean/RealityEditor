//
//  InspectorView.swift
//  RealityEditor
//
//  Created by Tyler Allen on 6/15/25.
//


// RealityInspector/InspectorView.swift
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
            PropertiesView(sceneManager: sceneManager)
            
            Spacer()
        }
        .frame(width: 280)
        .background(Color(.systemGray6))
    }
}