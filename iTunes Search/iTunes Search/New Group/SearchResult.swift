//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Jordan Davis on 5/21/19.
//  Copyright © 2019 Jordan Davis. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String
    let creator: String
    
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
