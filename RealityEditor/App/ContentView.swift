// App/ContentView.swift
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
                    // Viewport
                    ViewportView(sceneManager: sceneManager)
                    
                    // Toolbar
                    viewportToolbar()
                }
                
                // Inspector Panel
                if showInspector {
                    InspectorView(sceneManager: sceneManager)
                }
            }
            .navigationTitle("RealityViewport")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(showInspector ? "Hide Inspector" : "Show Inspector") {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showInspector.toggle()
                        }
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
        .navigationViewStyle(.stack) // Prevents sidebar on iPad
    }
    
    // MARK: - Viewport Toolbar
    private func viewportToolbar() -> some View {
        HStack {
            // Import button
            Button("Import USDZ") {
                isShowingFilePicker = true
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.regular)
            
            Spacer()
            
            // Selection actions
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
            
            // View controls
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
        .background(Color(.systemGray6))
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
