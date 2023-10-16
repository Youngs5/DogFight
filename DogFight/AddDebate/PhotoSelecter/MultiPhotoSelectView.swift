//
//  MultiPhotoSelectView.swift
//  DogFight
//
//  Created by 오영석 on 2023/09/16.
//

import SwiftUI

struct MultiPhotoSelectView: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]
    @Binding var selectedImageNames: [String]
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<MultiPhotoSelectView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<MultiPhotoSelectView>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: MultiPhotoSelectView

        init(_ parent: MultiPhotoSelectView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let imageURL = info[.imageURL] as? URL
            {
                let selectedImageNames = imageURL.lastPathComponent
                parent.selectedImageNames.append(selectedImageNames)
            }
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.selectedImages.append(selectedImage)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

