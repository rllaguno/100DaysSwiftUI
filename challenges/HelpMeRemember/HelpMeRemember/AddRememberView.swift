//
//  AddRememberView.swift
//  HelpMeRemember
//
//  Created by Rodrigo Llaguno on 02/09/24.
//

import PhotosUI
import SwiftUI
import UIKit

struct AddRememberView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of person to remember", text: $name)
                }
                
                Section {
                    Button {
                        //Photo Picker
                    } label: {
                        if selectedImage == nil {
                            VStack {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 64.0, height: 64.0)
                                PhotosPicker("Tap to import an image of a person you want to remember.", selection: $pickerItem, matching: .images)
                            }
                            .onChange(of: pickerItem) {
                                Task {
                                    selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
                                }
                            }
                        } else {
                            selectedImage?
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
            }
            .navigationTitle("Add Remember")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        guard let uiImage = convertToUIImage(from: selectedImage ?? Image(systemName: "photo")) else { return }
                        guard let imageData = convertToData(from: uiImage) else { return }
                        let remember = Remember(name: name, photo: imageData)
                        modelContext.insert(remember)
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(name == "" || selectedImage == nil)
                }
            }
        }
    }
    
    private func convertToUIImage(from image: Image) -> UIImage? {
        let controller = UIHostingController(rootView: image.resizable().scaledToFit().frame(width: 300, height: 300))
        let view = controller.view
        
        let renderer = UIGraphicsImageRenderer(bounds: view?.bounds ?? CGRect.zero)
        let uiImage = renderer.image { _ in
            view?.drawHierarchy(in: view?.bounds ?? CGRect.zero, afterScreenUpdates: true)
        }
        return uiImage
    }

    private func convertToData(from uiImage: UIImage) -> Data? {
        return uiImage.jpegData(compressionQuality: 0.8)
    }
}

#Preview {
    AddRememberView()
}
