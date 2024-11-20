//
//  ImageDetailView.swift
//  Flickr App
//
//  Created by Parth Barot on 11/19/24.
//

import SwiftUI

struct ImageDetailView: View {
    let image: Flickr
    
    private var formattedDate: String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        
        if let date = dateFormatter.date(from: image.published) {
            return date.formatted(date: .abbreviated, time: .shortened)
        } else {
            return "Unknown Date"
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: image.media.m)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 300)
                
                Text(image.title)
                    .font(.title)
                
                Text(image.description)
                    .font(.body)
                
                Text("Author: \(image.author)")
                    .font(.subheadline)
                
                Text("Published: \(formattedDate)")
                    .font(.subheadline)
                
                Text("Tags: \(image.tags)")
                    .font(.subheadline)
            }
            .padding()
        }
        .navigationTitle("Image Details")
    }
}

#Preview {
    ImageDetailView(image: Flickr(
        title: "Sample Porcupine",
        link: "https://www.flickr.com/photos/sample/12345/",
        media: Flickr.Media(m: "https://live.staticflickr.com/65535/12345_abcdef_m.jpg"),
        dateTaken: "2023-11-19T10:00:00-08:00",
        description: "A cute porcupine in the wild",
        published: "2023-11-19T18:00:00Z",
        author: "nobody@flickr.com (\"Nature Photographer\")",
        authorId: "12345@N00",
        tags: "porcupine wildlife nature"
    ))
}
