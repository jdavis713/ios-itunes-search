//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Jordan Davis on 5/21/19.
//  Copyright © 2019 Jordan Davis. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping(Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let searchTermQueryItem2 = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        urlComponents?.queryItems = [searchTermQueryItem, searchTermQueryItem2]
        
        
        guard let requestURL = urlComponents?.url else {
            NSLog("Unable to create URL from components")
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
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
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
