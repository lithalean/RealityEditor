// App/ContentView.swift
import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @StateObject private var sceneManager = SceneManager()
    @State private var isShowingFilePicker = false
    @State private var showInspector = true
    
    var body: some View {
        HSplitView {
            // Main Viewport
            VStack(spacing: 0) {
                // Toolbar
                HStack {
                    Button("Import USDZ") {
                        isShowingFilePicker = true
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                    
                    // Selection info
                    if let selectedNode = sceneManager.selectedNode {
                        Text("Selected: \(selectedNode.name)")
                            .foregroundColor(.secondary)
                        
                        Button("Delete") {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                sceneManager.removeNode(selectedNode)
                            }
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(.red)
                    }
                    
                    // View controls
                    if let camera = sceneManager.activeCamera {
                        Menu("View") {
                            Button("Frame All") {
                                // TODO: Implement
                            }
                            
                            Button("Frame Selected") {
                                // TODO: Implement
                            }
                            .disabled(sceneManager.selectedNode == nil)
                            
                            Divider()
                            
                            Button("Reset View") {
                                // TODO: Implement
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                    
                    // Inspector toggle
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showInspector.toggle()
                        }
                    }) {
                        Label(showInspector ? "Hide Inspector" : "Show Inspector",
                              systemImage: showInspector ? "sidebar.right" : "sidebar.left")
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                .background(Color(NSColor.controlBackgroundColor))
                
                // Viewport
                ViewportView(sceneManager: sceneManager)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(minWidth: 400)
            
            // Inspector Panel
            if showInspector {
                InspectorView(sceneManager: sceneManager)
                    .frame(width: 280)
                    .frame(maxHeight: .infinity)
            }
        }
        .frame(minWidth: 800, minHeight: 600)
        .fileImporter(
            isPresented: $isShowingFilePicker,
            allowedContentTypes: [
                UTType(filenameExtension: "usdz") ?? .item,
                UTType(filenameExtension: "reality") ?? .item
            ],
            allowsMultipleSelection: false
        ) { result in
            handleFileSelection(result)
        }
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
        }
    }
}
