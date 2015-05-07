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


let kQuoteRefreshed  = "QuoteRefreshed"
let kAuthorRefreshed = "AuthorRefreshed"
let notificationCenter = NSNotificationCenter.defaultCenter()
let mainQueue = NSOperationQueue.mainQueue()

class MainViewController: UIViewController {

    @IBOutlet weak var addButton:     UIButton!
    @IBOutlet weak var randomButton:  UIButton!
    @IBOutlet weak var nextButton:    UIButton!
    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var busySpinner: UIActivityIndicatorView!
    
    var currentQuote   : Quote?  = nil
    var currentAuthor  : Author? = nil
    var quoteObserver  : NSObjectProtocol?
    var authorObserver : NSObjectProtocol?
    var numberOfQuotes = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        quoteObserver = notificationCenter.addObserverForName(kQuoteRefreshed,
            object: nil, queue: mainQueue) { (note:NSNotification!) in
                let quote = note.object as! Quote
                self.quoteTextView.text = quote.text }
        
        authorObserver = notificationCenter.addObserverForName(kAuthorRefreshed,
            object: nil, queue: mainQueue, usingBlock:  { (note:NSNotification!) in
                             println(" authorUpdated")
                             let auth = note.object as! Author
                             var name = auth.firstName + " "
                             name +=  auth.lastName
                             self.authorTextField.text = name
        })
        
        quoteTextView.text = "Please wait..."
        dispatch_async(GlobalUserInitiatedQueue) {
           var query = PFQuery(className:"Quotes")
           quoteStore.shared.count = query.countObjects()
           self.displayRandomQuote()
           }
        }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addButtonTapped(sender: AnyObject) {
    }
    
    @IBAction func randomButtonTapped(sender: AnyObject) {
        displayRandomQuote()
    }
    
    @IBAction func nextButtonTapped(sender: AnyObject) {
    }
    
    // =====================
    func displayQuote( quote : Quote? ) -> Void {
        if let q = quote {
           quoteTextView.text = q.text
        }
    }
    
    
    // =====================
    func displayRandomQuote() {
       let qnum  = Int(arc4random_uniform( UInt32( quoteStore.shared.count)))
        println("there are \(self.numberOfQuotes) quotes in the system")
        quoteStore.shared.getNthQuote( qnum, completion:{(quote:Quote) ->() in
                    notificationCenter.postNotificationName(kAuthorRefreshed, object: nil)
                    self.displayQuote(quote)} )
    }

}
