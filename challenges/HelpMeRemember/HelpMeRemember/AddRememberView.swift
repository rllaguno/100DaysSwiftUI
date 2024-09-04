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
    @State private var selectedUIImage: UIImage?
    
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
                            .onChange(of: pickerItem) { _, newItem in
                                Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        if let uiImage = UIImage(data: data) {
                                            selectedUIImage = uiImage
                                            selectedImage = Image(uiImage: uiImage)
                                        }
                                    }
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
                        if let selectedUIImage = selectedUIImage {
                            let imageData = uiImageToData(selectedUIImage)
                            let remember = Remember(name: name, photo: imageData)
                            modelContext.insert(remember)
                            dismiss()
                        }
                    } label: {
                        Text("Save")
                    }
                    .disabled(name == "" || selectedImage == nil)
                }
            }
        }
    }
    
    func uiImageToData(_ uiImage: UIImage) -> Data {
        return uiImage.jpegData(compressionQuality: 0.8)!
    }
    
}

#Preview {
    AddRememberView()
}
