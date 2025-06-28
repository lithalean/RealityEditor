//
//  ContentView.swift
//  RealityEditor
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @StateObject private var sceneManager = SceneManager()
    @State private var isShowingFilePicker = false
    @State private var showInspector = true

    var body: some View {
        NavigationView {
            HStack(spacing: 0) {
                // Main Viewport
                VStack {
                    ViewportView(sceneManager: sceneManager)
                    viewportToolbar()
                }

                // Inspector Panel
                if showInspector {
                    InspectorView(sceneManager: sceneManager)
                }
            }
            .toolbar {
                Button(showInspector ? "Hide Inspector" : "Show Inspector") {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        showInspector.toggle()
                    }
                }
            }
            .fileImporter(
                isPresented: $isShowingFilePicker,
                allowedContentTypes: [
                    UTType(filenameExtension: "usdz")!,
                    UTType(filenameExtension: "reality")!
                ],
                allowsMultipleSelection: false
            ) { result in
                handleFileSelection(result)
            }
        }
    }

    // MARK: - Viewport Toolbar
    private func viewportToolbar() -> some View {
        HStack {
            Button("Import USDZ") {
                isShowingFilePicker = true
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.regular)

            Spacer()

            if let selectedNode = sceneManager.selectedNode {
                Button("Delete \(selectedNode.name)") {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        sceneManager.removeNode(selectedNode)
                    }
                }
                .buttonStyle(.bordered)
                .foregroundColor(.red)
                .controlSize(.regular)
            }

            if let activeCamera = sceneManager.activeCamera {
                Menu("View") {
                    Button("Frame All") {
                        // TODO: Implement frame all
                    }

                    Button("Frame Selected") {
                        if let selectedNode = sceneManager.selectedNode {
                            // TODO: Implement frame selected
                        }
                    }
                    .disabled(sceneManager.selectedNode == nil)

                    Divider()

                    Button("Reset View") {
                        // TODO: Implement reset view
                    }
                }
                .buttonStyle(.bordered)
                .controlSize(.regular)
            }
        }
        .padding()
        .background(.gray.opacity(0.1)) // macOS-compatible background
    }

    // MARK: - File Handling
    private func handleFileSelection(_ result: Result<[URL], Error>) {
        switch result {
        case .success(let urls):
            guard let url = urls.first else { return }
            Task {
                await sceneManager.importModel(from: url)
            }
        case .failure(let error):
            print("File selection error: \(error)")
            // TODO: Show error alert
        }
    }
}
