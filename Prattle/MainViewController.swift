//
//  MainViewController.swift
//  Prattle
//
//  Created by Rick Zemer on 5/1/15.
//  Copyright (c) 2015 blockpuppy. All rights reserved.
//

import UIKit
import Parse

var GlobalMainQueue: dispatch_queue_t {
    return dispatch_get_main_queue()
}

var GlobalUserInteractiveQueue: dispatch_queue_t {
    return dispatch_get_global_queue(Int(QOS_CLASS_USER_INTERACTIVE.value), 0)
}

var GlobalUserInitiatedQueue: dispatch_queue_t {
    return dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)
}

var GlobalUtilityQueue: dispatch_queue_t {
    return dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.value), 0)
}

var GlobalBackgroundQueue: dispatch_queue_t {
    return dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.value), 0)
}
class MainViewController: UIViewController {

    @IBOutlet weak var addButton:     UIButton!
    @IBOutlet weak var randomButton:  UIButton!
    @IBOutlet weak var nextButton:    UIButton!
    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var busySpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quoteTextView.text = "Please wait..."
        dispatch_async(GlobalUserInitiatedQueue) {
           var query = PFQuery(className:"Quotes")
           let maxN  : UInt32 = UInt32(query.countObjects())
           self.busySpinner.stopAnimating()
           self.busySpinner.hidden = true
           let qnum  = arc4random_uniform( maxN )
           self.getNthQuote( qnum, completion:{(quote:Quote?) -> Void in self.displayQuote(quote)} )
           }
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addButtonTapped(sender: AnyObject) {
    }
    @IBAction func randomButtonTapped(sender: AnyObject) {
    }
    @IBAction func nextButtonTapped(sender: AnyObject) {
    }
    
    
    func getNthQuote( nth : UInt32, completion:(quote : Quote? ) -> Void ) -> Void {
        var rv : Quote? = nil
        var query = PFQuery(className:"Quotes")
        query.whereKey("AuthorID", equalTo:1)
        query.findObjectsInBackgroundWithBlock {
            (quote: [AnyObject]?, error: NSError?) -> Void in
            if error == nil && quote != nil {
                println(quote)
                if let pobj = quote!.first as? PFObject {
                    rv = self.toQuote( pobj )
                    completion(quote:rv )
                }
            } else {
                println(error)
            }
        }
//        return rv
    }
    
    func toQuote(pobj : PFObject) -> Quote? {
        var rv : Quote = Quote()
        let authorID  : Int = pobj["AuthorID"] as! Int
        let quotetext : String = pobj["Text"] as! String
        println("authorID = \(authorID) quotetext = \(quotetext)")
        rv.author = nil
        rv.text = quotetext
        return( rv )
    }
    
    func displayQuote( quote : Quote? ) -> Void {
        if let q = quote {
           quoteTextView.text = q.text
        }
    }
//        query.whereKey("QuoteID", equalTo: "\(nth )")
//        
//        query.getFirstObjectInBackgroundWithBlock{ (success, error) ->  // completion?() }
//        if error == nil {
//            if let obj = object as? PFObject
//            
//            }
//            return( rv )
//        }
//        println("Successfully retrieved \(objects!.count) scores.")
//    // Do something with the found objects
//    if let objects = objects as? [PFObject] {
//    for object in objects {
//    println(object.objectId)
//    }
//    }
//    } else {
//    // Log details of the failure
//    println("Error: \(error!) \(error!.userInfo!)")
}
