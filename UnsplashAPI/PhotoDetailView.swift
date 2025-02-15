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
                    .padding()

                Text("Photographer: \(photo.user.name)")
                    .font(.title2)
                    .padding(.bottom)

                if let description = photo.description {
                    Text(description)
                        .font(.body)
                        .padding()
                }
            }
        }
        .navigationTitle("Photo Details")
    }
}

