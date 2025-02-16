//
//  PhotoDetailView.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import SwiftUI
import Kingfisher

struct PhotoDetailView: View {
    let photo: UnsplashPhoto

    var body: some View {
        ScrollView {
            VStack {
                KFImage(URL(string: photo.urls.regular))
                    .placeholder {
                        ProgressView()
                    }
                    .fade(duration: 0.3)
                    .resizable()
                    .scaledToFit()
                Group {
                    Text("Photographer: \(photo.user.name)")
                        .font(.title2)
                    if let description = photo.description {
                        Text(description)
                            .font(.body)
                            .foregroundStyle(Color.gray)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
        }
        .navigationTitle("Photo Details")
    }
}

