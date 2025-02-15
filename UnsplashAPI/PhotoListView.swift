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
            ZStack {
                GeometryReader { geometry in
                    List {
                        ForEach(viewModel.photos) { photo in
                            NavigationLink(destination: PhotoDetailView(photo: photo)) {
                                PhotoRowView(photo: photo, geometry: geometry)
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .scrollIndicators(.hidden)
                    .scrollContentBackground(.hidden)
                    
                }
                .refreshable {
                    viewModel.fetchPhotos()
                }
                
                .navigationTitle("Unsplash Photos")
                
                .blur(radius: viewModel.isLoading ? 5 : 0)
                .alert(
                    isPresented: $viewModel.hasError,
                    error: viewModel.errorMessage,
                    actions: {
                        Button("OK", role: .cancel) {}
                    })
                // Empty statement
                if !viewModel.isLoading && viewModel.photos.isEmpty  {
                    ErrorEmptyView(type: .emptyList)
                }
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .background(Color(.secondarySystemBackground).ignoresSafeArea())
                }
            }
        }
    }
}


