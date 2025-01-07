//
//  ImageDetailView.swift
//  Unsplash
//
//  Created by MAZEL Florian on 07/01/2025.
//

import SwiftUI

struct ImageDetailView: View {
    let photo: UnsplashPhoto

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: photo.urls.full)) { phase in
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

                VStack(alignment: .leading, spacing: 8) {
                    Text("Une image de " + photo.user.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
}
