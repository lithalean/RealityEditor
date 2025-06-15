//
//  PropertiesView.swift
//  RealityEditor
//
//  Created by Tyler Allen on 6/15/25.
//


// RealityInspector/PropertiesView.swift
import SwiftUI

struct PropertiesView: View {
    @ObservedObject var sceneManager: SceneManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let selectedNode = sceneManager.selectedNode {
                Text("\(selectedNode.name) Properties")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 16)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Transform properties (all nodes have these)
                        TransformSection(node: selectedNode)
                        
                        // Type-specific properties
                        if let camera = selectedNode as? CameraNode {
                            CameraSection(camera: camera, sceneManager: sceneManager)
                        } else if let light = selectedNode as? LightNode {
                            LightSection(light: light)
                        } else if let model = selectedNode as? ModelNode {
                            ModelSection(model: model)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            } else {
                VStack {
                    Spacer()
                    Text("No object selected")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    Text("Select an object in the outliner or viewport")
                        .foregroundColor(.tertiary)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding()
            }
        }
    }
}

// MARK: - Transform Section
struct TransformSection: View {
    let node: any SceneNode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeader(title: "Transform", icon: "move.3d")
            
            VStack(alignment: .leading, spacing: 8) {
                // Location
                PropertyGroup(title: "Location") {
                    VStack(spacing: 4) {
                        HStack {
                            PropertyLabel("X", color: .red)
                            Text(String(format: "%.3f", node.position.x))
                                .font(.system(.caption, design: .monospaced))
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        HStack {
                            PropertyLabel("Y", color: .green)
                            Text(String(format: "%.3f", node.position.y))
                                .font(.system(.caption, design: .monospaced))
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        HStack {
                            PropertyLabel("Z", color: .blue)
                            Text(String(format: "%.3f", node.position.z))
                                .font(.system(.caption, design: .monospaced))
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                    }
                }
                
                // Scale
                PropertyGroup(title: "Scale") {
                    VStack(spacing: 4) {
                        HStack {
                            PropertyLabel("X", color: .red)
                            Text(String(format: "%.3f", node.scale.x))
                                .font(.system(.caption, design: .monospaced))
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        HStack {
                            PropertyLabel("Y", color: .green)
                            Text(String(format: "%.3f", node.scale.y))
                                .font(.system(.caption, design: .monospaced))
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        HStack {
                            PropertyLabel("Z", color: .blue)
                            Text(String(format: "%.3f", node.scale.z))
                                .font(.system(.caption, design: .monospaced))
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Camera Section
struct CameraSection: View {
    @ObservedObject var camera: CameraNode
    let sceneManager: SceneManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeader(title: "Camera", icon: "camera")
            
            PropertyGroup(title: "Lens") {
                VStack(spacing: 12) {
                    // Focal Length (FOV)
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Focal Length")
                                .font(.caption)
                            Spacer()
                            Text("\(Int(camera.fov))mm")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Slider(value: $camera.fov, in: 14...200, step: 1)
                            .accentColor(.blue)
                    }
                    
                    // Clipping
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Clip Start")
                                .font(.caption)
                            Spacer()
                            Text(String(format: "%.3f", camera.nearPlane))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("Clip End")
                                .font(.caption)
                            Spacer()
                            Text(String(format: "%.1f", camera.farPlane))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // Active camera button
                    Button(camera.isActive ? "Active Camera" : "Set as Active Camera") {
                        sceneManager.setActiveCamera(camera)
                    }
                    .buttonStyle(.bordered)
                    .disabled(camera.isActive)
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

// MARK: - Light Section
struct LightSection: View {
    @ObservedObject var light: LightNode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeader(title: "Light", icon: "lightbulb")
            
            PropertyGroup(title: "Light") {
                VStack(spacing: 12) {
                    // Light type
                    Picker("Type", selection: $light.lightType) {
                        ForEach(LightNode.LightType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    // Power/Intensity
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Power")
                                .font(.caption)
                            Spacer()
                            Text("\(Int(light.intensity))W")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Slider(value: $light.intensity, in: 0...5000, step: 100)
                            .accentColor(.yellow)
                    }
                    
                    // Color (read-only for now)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Color")
                            .font(.caption)
                        
                        HStack {
                            Circle()
                                .fill(Color(red: Double(light.color.x), 
                                          green: Double(light.color.y), 
                                          blue: Double(light.color.z)))
                                .frame(width: 20, height: 20)
                            
                            Text("RGB(\(String(format: "%.2f", light.color.x)), \(String(format: "%.2f", light.color.y)), \(String(format: "%.2f", light.color.z)))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Model Section
struct ModelSection: View {
    @ObservedObject var model: ModelNode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeader(title: "Model", icon: "cube")
            
            PropertyGroup(title: "Mesh") {
                VStack(alignment: .leading, spacing: 8) {
                    if model.isLoading {
                        HStack {
                            ProgressView()
                                .scaleEffect(0.8)
                            Text("Loading...")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    } else if let url = model.modelURL {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("File")
                                .font(.caption)
                            Text(url.lastPathComponent)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Bounds")
                                .font(.caption)
                            let bounds = model.bounds
                            Text("(\(String(format: "%.2f", bounds.x)), \(String(format: "%.2f", bounds.y)), \(String(format: "%.2f", bounds.z)))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    } else {
                        Text("No mesh loaded")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

// MARK: - Helper Components
struct SectionHeader: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.caption)
            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding(.bottom, 4)
    }
}

struct PropertyGroup<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundColor(.tertiary)
            
            content
        }
        .padding(12)
        .background(Color(.systemGray5))
        .cornerRadius(8)
    }
}

struct PropertyLabel: View {
    let text: String
    let color: Color
    
    init(_ text: String, color: Color) {
        self.text = text
        self.color = color
    }
    
    var body: some View {
        Text(text)
            .font(.caption2)
            .fontWeight(.semibold)
            .foregroundColor(color)
            .frame(width: 12, alignment: .leading)
    }
}