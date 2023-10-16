//
//  PhotoSelectView.swift
//  DogFight
//
//  Created by 오영석 on 2023/09/16.
//
import SwiftUI
import Photos
import UIKit

struct PhotoSelectView: View {
    @Binding var selectedImages: [UIImage]
    @Binding  var selectedImageNames: [String]
    @State private var isImagePickerPresented = false
    @State private var isGalleryPermissionGranted = false

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    if selectedImages.count < 5 {
                        Button {
                            requestGalleryPermission()
                            if isGalleryPermissionGranted {
                                isImagePickerPresented.toggle()
                            }

                        } label: {
                            Image(systemName: "camera")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .padding(30)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, style: .init(lineWidth: 3, lineCap: .round, dash: [10,10]))
                                }

                        }

                    }
                    ForEach(selectedImages, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .cornerRadius(10)
                            .frame(width: 80, height: 80)
                            .padding(.leading, 5)
                            .aspectRatio(contentMode: .fill)
                            .overlay(alignment: .topTrailing) {
                                Button {
                                    guard let index = selectedImages.firstIndex(where: {
                                        $0 == image
                                    }) else {
                                        return
                                    }
                                    selectedImages.remove(at: index)
                                    selectedImageNames.remove(at: index)
                                } label: {
                                    Image(systemName: "xmark.square.fill")
                                        .foregroundColor(.white)
                                }
                            }
                    }
                }
            }
            .sheet(isPresented: $isImagePickerPresented) {
                MultiPhotoSelectView(selectedImages: $selectedImages, selectedImageNames: $selectedImageNames)
            }
        }
    }

    func requestGalleryPermission() {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                if status == .authorized {
                    isGalleryPermissionGranted = true
                } else {
                    isGalleryPermissionGranted = false
                }
            }
        }
    }

}

struct PhotoSelectView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSelectView(selectedImages: .constant([]), selectedImageNames: .constant([""]))
    }
}
