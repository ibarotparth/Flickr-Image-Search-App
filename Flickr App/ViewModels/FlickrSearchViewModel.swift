//
//  FlickrSearchViewModel.swift
//  Flickr App
//
//  Created by Parth Barot on 11/19/24.
//

import Foundation
import Combine

class FlickrSearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var images: [Flickr] = []
    @Published var isLoading = false
    
    private let apiService = FlickrAPIService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.searchImages(for: searchText)
            }
            .store(in: &cancellables)
    }
    
    private func searchImages(for tags: String) {
        guard !tags.isEmpty else {
            images = []
            return
        }
        
        isLoading = true
        
        apiService.searchImages(for: tags)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("Error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] images in
                self?.images = images
            }
            .store(in: &cancellables)
    }
}
