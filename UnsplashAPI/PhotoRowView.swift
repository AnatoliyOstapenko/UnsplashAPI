//
//  PhotoRowView.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import SwiftUI
import Kingfisher

struct PhotoRowView: View {
    let photo: UnsplashPhoto
    let geometry: GeometryProxy

    var body: some View {
        HStack {
            KFImage(URL(string: photo.urls.thumb))
                .placeholder {
                    ProgressView()
                        .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                }
                .fade(duration: 0.3)
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                .clipped()
                .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(photo.user.name)
                    .font(.headline)

                if let description = photo.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
}
