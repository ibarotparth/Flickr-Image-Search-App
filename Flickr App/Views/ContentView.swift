//
//  ContentView.swift
//  Flickr App
//
//  Created by Parth Barot on 11/19/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var viewModel = FlickrSearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                
                ScrollView {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        ImageGridView(images: viewModel.images)
                    }
                }
                
            }
            .navigationTitle("Flickr Image Search")
            
        }
    }
}

#Preview {
    ContentView()
}
