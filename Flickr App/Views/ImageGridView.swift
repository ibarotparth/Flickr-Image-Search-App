//
//  ImageGridView.swift
//  Flickr App
//
//  Created by Parth Barot on 11/19/24.
//

import SwiftUI

struct ImageGridView: View {
    let images: [Flickr]
    let columns = [GridItem(.adaptive(minimum: 100))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(images) { image in
                    NavigationLink(destination: ImageDetailView(image: image)) {
                        AsyncImage(url: URL(string: image.media.m)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipped()
                            case .failure:
                                Image(systemName: "photo")
                                    .frame(width: 100, height: 100)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ImageGridView(images: [
        Flickr(
            title: "Porcupine 1",
            link: "https://www.flickr.com/photos/sample/12345/",
            media: Flickr.Media(m: "https://live.staticflickr.com/65535/12345_abcdef_m.jpg"),
            dateTaken: "2023-11-19T10:00:00-08:00",
            description: "A cute porcupine in the wild",
            published: "2023-11-19T18:00:00Z",
            author: "nobody@flickr.com (\"Nature Photographer\")",
            authorId: "12345@N00",
            tags: "porcupine wildlife nature"
        ),
        Flickr(
            title: "Porcupine 2",
            link: "https://www.flickr.com/photos/sample/67890/",
            media: Flickr.Media(m: "https://live.staticflickr.com/65535/67890_ghijkl_m.jpg"),
            dateTaken: "2023-11-20T11:00:00-08:00",
            description: "Another porcupine sighting",
            published: "2023-11-20T19:00:00Z",
            author: "nobody@flickr.com (\"Wildlife Enthusiast\")",
            authorId: "67890@N00",
            tags: "porcupine forest animal"
        )
    ])
}
