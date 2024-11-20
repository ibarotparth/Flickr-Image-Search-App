//
//  Flickr.swift
//  Flickr App
//
//  Created by Parth Barot on 11/19/24.
//

import Foundation

struct FlickrResponse: Codable {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [Flickr]
}

struct Flickr: Identifiable, Codable {
    let title: String
    let link: String
    let media: Media
    let dateTaken: String
    let description: String
    let published: String
    let author: String
    let authorId: String
    let tags: String
    
    var id: String { link } // Conforming to Identifiable
    
    struct Media: Codable {
        let m: String
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case link
        case media
        case dateTaken = "date_taken"
        case description
        case published
        case author
        case authorId = "author_id"
        case tags
    }
}
