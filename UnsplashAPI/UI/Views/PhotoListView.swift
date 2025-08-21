//
//  PhotoListView.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import SwiftUI

struct PhotoListView: View {
    @StateObject var viewModel: PhotoListViewModel
    @EnvironmentObject private var snackBarHelper: SnackBarHelper
    
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader { geometry in
                    List {
                        ForEach(viewModel.state.photos) { photo in
                            NavigationLink(destination: PhotoDetailView(photo: photo)) {
                                PhotoRowView(photo: photo, geometry: geometry)
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .refreshable {
                        viewModel.fetchPhotos()
                    }
                    .scrollIndicators(.hidden)
                    .scrollContentBackground(.hidden)
                    .snackBar(using: snackBarHelper)
                    
                    // Empty View
                    if !viewModel.state.isLoading && viewModel.state.photos.isEmpty {
                        EmptyView(type: .emptyList)
                    }
                }
                .frame(maxHeight: .infinity)
            }
            .navigationTitle("Unsplash Photos")
            .blur(radius: viewModel.state.isLoading ? 5 : 0)
            .progressView(viewModel.state.isLoading)
        }
    }
}
