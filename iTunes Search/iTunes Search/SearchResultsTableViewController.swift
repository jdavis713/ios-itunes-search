//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Jordan Davis on 5/21/19.
//  Copyright © 2019 Jordan Davis. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        var resultType: ResultType!
       
        switch segmentedConrol.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
            
        searchResultsController.performSearch(with: searchTerm, resultType: resultType) {_ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        let SearchResultObject = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = SearchResultObject.title
        cell.detailTextLabel?.text = SearchResultObject.creator

        return cell
    }


    //MARK: - Properties

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedConrol: UISegmentedControl!
    
    let searchResultsController = SearchResultController()
}
