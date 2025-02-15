//
//  PhotoListView.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import SwiftUI

struct PhotoListView: View {
    @ObservedObject var viewModel: PhotoListViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader { geometry in
                    List {
                        ForEach(viewModel.photos) { photo in
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
                    if !viewModel.isLoading && viewModel.photos.isEmpty {
                        ErrorEmptyView(type: .emptyList)
                    }
                }
                .frame(maxHeight: .infinity)
            }
            .navigationTitle("Unsplash Photos")
            .blur(radius: viewModel.isLoading ? 5 : 0)
            .alert(
                isPresented: $viewModel.hasError,
                error: viewModel.errorMessage,
                actions: {
                    Button("OK", role: .cancel) {}
                })

            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color(.secondarySystemBackground).ignoresSafeArea())
            }
        }
    }
}
