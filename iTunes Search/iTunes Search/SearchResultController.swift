//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Jordan Davis on 5/21/19.
//  Copyright © 2019 Jordan Davis. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/us/")!
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping() -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        
        urlComponents?.queryItems = [searchTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            NSLog("Unable to create URL from components")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                jsonDecoder.keyDecodingStrategy = .custom({ (CodingKeys) -> CodingKey in
                    <#code#>
                })
                let searchResult = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResult.results
                completion(nil)
            } catch {
                NSLog("Unable to decode data into object type of [SearchResult]: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    
    
    
    //MARK: - Properties
    
    var searchResults: [SearchResult] = []

}
