//
//  NewsTableViewController.swift
//  SimpleRSSReader
//
//  Created by Simon Ng on 26/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    private var rssItems: [(title: String, description: String, pubDate: String)]?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 155.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let feedParser = FeedParser()
        feedParser.parseFeed(feedURL: "https://www.apple.com/main/rss/hotnews/hotnews.rss") { (rssItems) in
            self.rssItems = rssItems
            OperationQueue.main.addOperation({
                self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            })
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        guard let rssItems = rssItems else {
            return 0
        }
        return rssItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        
        //Configure Cell
        if let item = rssItems?[indexPath.row] {
            cell.titleLabel.text = item.title
            cell.descriptionLabel.text = item.description
            cell.dateLabel.text = item.pubDate
        }
        return cell
    }

}














