//
//  ImageDetailView.swift
//  Unsplash
//
//  Created by MAZEL Florian on 07/01/2025.
//

import SwiftUI
import PhotosUI

struct ImageDetailView: View {
    let photo: UnsplashPhoto

    @State private var selectedImageUrl: String
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""

    init(photo: UnsplashPhoto) {
        self.photo = photo
        _selectedImageUrl = State(initialValue: photo.urls.regular)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: selectedImageUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .padding()
                    case .failure:
                        Color.red
                            .frame(height: 300)
                            .cornerRadius(12)
                            .overlay(Text("Failed to load image").foregroundColor(.white))
                    @unknown default:
                        Color.gray
                            .frame(height: 300)
                            .cornerRadius(12)
                    }
                }

                HStack(spacing: 12) {
                    formatButton(label: "Small", url: photo.urls.small)
                    formatButton(label: "Regular", url: photo.urls.regular)
                    formatButton(label: "Full", url: photo.urls.full)
                }
                .padding(.horizontal)

                authorInfo()

                Button(action: downloadImage) {
                    HStack {
                        Image(systemName: "arrow.down.circle.fill")
                        Text("Download Image")
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .padding(.vertical)
        }
    }

    @ViewBuilder
    private func formatButton(label: String, url: String) -> some View {
        Button(action: { selectedImageUrl = url }) {
            Text(label)
                .padding()
                .frame(maxWidth: .infinity)
                .background(selectedImageUrl == url ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }

    @ViewBuilder
    private func authorInfo() -> some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: photo.user.profileImage)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                case .failure:
                    Color.gray
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                @unknown default:
                    Color.gray
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }
            }

            VStack(alignment: .leading) {
                Text(photo.user.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                if let profileUrl = URL(string: photo.user.profileUrl) {
                    Link("View Profile", destination: profileUrl)
                        .font(.body)
                        .foregroundColor(.blue)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }

    func downloadImage() {
        guard let url = URL(string: selectedImageUrl) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                showErrorAlert(message: "Unable to download the image.")
                return
            }

            if let image = UIImage(data: data) {
                PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
                    if status == .authorized || status == .limited {
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        showSuccessAlert(message: "The image has been saved to your Photos.")
                    } else {
                        showErrorAlert(message: "Access to Photos is denied.")
                    }
                }
            } else {
                showErrorAlert(message: "Unable to save the image.")
            }
        }
        task.resume()
    }

    private func showErrorAlert(message: String) {
        DispatchQueue.main.async {
            alertTitle = "Download Failed"
            alertMessage = message
            showAlert = true
        }
    }

    private func showSuccessAlert(message: String) {
        DispatchQueue.main.async {
            alertTitle = "Download Successful"
            alertMessage = message
            showAlert = true
        }
    }
}
