//
//  TopicViewController.swift
//  Prattle
//
//  Created by Rick Zemer on 5/12/15.
//  Copyright (c) 2015 blockpuppy. All rights reserved.
//

import UIKit

protocol TopicsSaverProtocol {
    func saveTopicsToQuote( topics : String ) -> Void
}

class TopicViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var delegate : TopicsSaverProtocol!
    var sortedTopics : [String] = []
    var searchTopics : [String] = []
    var searchString : String   = ""
    var selections   : [String:Bool] = [String:Bool]()
    
    // MARK: outlets/actions
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topicTableView: UITableView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil )
    }
    
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBAction func doneButtonTapped(sender: AnyObject) {
        var rv = ""
        for (key, value) in selections {
            if value == true {
                rv += key + ","
            }
        }
        self.delegate.saveTopicsToQuote( rv )
        self.dismissViewControllerAnimated(true, completion: nil )
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for topic in Topic.allValues {
            sortedTopics.append( topic.rawValue )
            selections[topic.rawValue] = false
        }
        sortedTopics.sort{ $0 < $1 }
        searchTopics = sortedTopics

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - TableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TopicTableViewCell", forIndexPath: indexPath) as! TopicTableViewCell
        let row = indexPath.row
        let text = searchTopics[row]
        cell.topicLabel.text = text
    
        cell.accessoryType = (selections[text] == true)  ? .Checkmark : .None
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rv = searchTopics.count
        return( rv )
    }
    
    // MARK: - TableViewDelegate
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let text  = searchTopics[indexPath.row]
        selections[text] = false
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .None
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let text  = searchTopics[indexPath.row]
        selections[text] = true
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
    }
    
    // MARK: - Search Bar Delegate
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            searchTopics = sortedTopics
        }
        else {
            if searchText.length < searchString.length {
                searchTopics = sortedTopics
            }
            searchTopics = searchTopics.filter( {$0.uppercaseString.hasPrefix( searchText.uppercaseString )})
        }
        searchString = searchText.uppercaseString
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
