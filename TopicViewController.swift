//
//  TopicViewController.swift
//  Prattle
//
//  Created by Rick Zemer on 5/12/15.
//  Copyright (c) 2015 blockpuppy. All rights reserved.
//

import UIKit

class TopicViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var sortedTopics : [String] = []
    var searchTopics : [String] = []
    var searchString : String   = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        for topic in Topic.allValues {
            sortedTopics.append( topic.rawValue )
        }
        sortedTopics.sort{ $0 < $1 }
        searchTopics = sortedTopics

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var topicTableView: UITableView!
    
    // MARK: - TableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TopicTableViewCell", forIndexPath: indexPath) as! TopicTableViewCell
        let row = indexPath.row
        cell.topicLabel.text = searchTopics[row]
        
        // Configure the cell...
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rv = searchTopics.count
        return( rv )
    }
    
    // MARK: - TableViewDelegate
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    // MARK: - Search Bar Delegate
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
        if searchText.isEmpty {
            searchTopics = sortedTopics
        }
        else {
            searchTopics = []
            for topic in sortedTopics {
                if topic.hasPrefix( searchString ) {
                    searchTopics.append(topic)
                }
            }
        }
        self.topicTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
