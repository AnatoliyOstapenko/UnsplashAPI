//
//  PhotoListView.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import SwiftUI

struct PhotoListView: View {
    @StateObject var viewModel: PhotoListViewModel
    @State private var showingSnackbar = false
    
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
                    
                    // Empty View
                    if !viewModel.state.isLoading && viewModel.state.photos.isEmpty {
                        ErrorEmptyView(type: .emptyList)
                    }
                }
                .frame(maxHeight: .infinity)
            }
            .navigationTitle("Unsplash Photos")
            
            // Show Snackbar if an error exists
            if let error = viewModel.state.error {
                ErrorSnackbarView(
                    message: error.localizedDescription,
                    onRetry: {
                        viewModel.fetchPhotos()
                        showingSnackbar = false
                    },
                    onDismiss: {
                        showingSnackbar = false
                    }
                )
                .onAppear {
                    showingSnackbar = true
                }
            }
            
            // Loading Overlay
            if viewModel.state.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color(.secondarySystemBackground).ignoresSafeArea())
            }
        }
    }
}
