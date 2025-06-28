//  EditorComponents.swift
//  RealityEditor

import SwiftUI
import simd

// MARK: - Vector3Editor
struct Vector3Editor: View {
    @Binding var vector: SIMD3<Float>

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<3, id: \.self) { index in
                VStack(alignment: .leading, spacing: 2) {
                    let label = ["X", "Y", "Z"][index]
                    Text(label).font(.caption2)
                    TextField(label, value: Binding(
                        get: { vector[index] },
                        set: { vector[index] = $0 }
                    ), format: .number)
                        .frame(width: 60)
                        .textFieldStyle(.roundedBorder)
                }
            }
        }
    }
}

// MARK: - QuaternionEditor
struct QuaternionEditor: View {
    @Binding var quaternion: simd_quatf

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Rotation (Quaternion)")
                .font(.caption)

            HStack(spacing: 12) {
                let components: [(String, Float)] = [
                    ("X", quaternion.imag.x),
                    ("Y", quaternion.imag.y),
                    ("Z", quaternion.imag.z),
                    ("W", quaternion.real)
                ]
                ForEach(components.indices, id: \.self) { index in
                    let label = components[index].0
                    let value = components[index].1
                    VStack(alignment: .leading) {
                        Text(label).font(.caption2)
                        TextField(label, value: .constant(value), format: .number)
                            .frame(width: 60)
                            .textFieldStyle(.roundedBorder)
                            .disabled(true)
                    }
                }
            }
        }
    }
}

// MARK: - LightPropertiesView
struct LightPropertiesView: View {
    var light: (any SceneNode)?
    @State private var intensity: Float = 1000
    @State private var color: Color = .white

    var body: some View {
        GroupBox(label: Label("Light", systemImage: "lightbulb")) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Intensity:")
                    Slider(value: $intensity, in: 0...2000)
                    Text("\(Int(intensity))")
                        .frame(width: 40, alignment: .trailing)
                }

                ColorPicker("Color", selection: $color)
            }
        }
    }
}

// MARK: - ModelPropertiesView
struct ModelPropertiesView: View {
    var modelNode: (any SceneNode)?
    @State private var visible: Bool = true
    @State private var opacity: Double = 1.0

    var body: some View {
        GroupBox(label: Label("Model", systemImage: "cube")) {
            Toggle("Visible", isOn: $visible)
            HStack {
                Text("Opacity")
                Slider(value: $opacity, in: 0.0...1.0)
                    .frame(width: 100)
                Text("\(Int(opacity * 100))%")
                    .frame(width: 40, alignment: .trailing)
            }
        }
    }
}

// MARK: - EmptyPropertiesView
struct EmptyPropertiesView: View {
    var body: some View {
        GroupBox(label: Label("Empty", systemImage: "square.dashed")) {
            Text("No properties available.")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}
