//
//  FlickrAPIService.swift
//  Flickr App
//
//  Created by Parth Barot on 11/19/24.
//

import Foundation
import Combine

class FlickrAPIService {
    private let baseURL = "https://api.flickr.com/services/feeds/photos_public.gne"
    
    func searchImages(for tags: String) -> AnyPublisher<[Flickr], Error> {
        let encodedTags = tags.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)?format=json&nojsoncallback=1&tags=\(encodedTags)"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: FlickrResponse.self, decoder: JSONDecoder())
            .map(\.items)
            .eraseToAnyPublisher()
    }
}
