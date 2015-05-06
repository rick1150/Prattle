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
                            object: nil, queue: mainQueue) { _ in
                                println(" quoteUpdated")
                            self.quoteTextView.text = self.currentQuote?.text }
        
        authorObserver = notificationCenter.addObserverForName(kAuthorRefreshed,
                             object: nil, queue: mainQueue) { _ in
                             println(" authorUpdated")
                                
                             var name = self.currentAuthor!.firstName + " "
                             name +=  self.currentAuthor!.lastName
                             self.authorTextField.text = name
        }
        
        quoteTextView.text = "Please wait..."
        dispatch_async(GlobalUserInitiatedQueue) {
           var query = PFQuery(className:"Quotes")
           self.numberOfQuotes = query.countObjects()
           }
           self.displayRandomQuote()
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
//    func getNthQuote( nth : UInt32, completion:(quote : Quote? ) -> Void ) -> Void {
    func getNthQuote( nth : UInt32, completion:() -> () ) -> Void {
        var rv : Quote? = nil
        var num : CGFloat = CGFloat(nth)
        var query = PFQuery(className:"Quotes")
        query.whereKey("QuoteID", greaterThanOrEqualTo: num )
        query.getFirstObjectInBackgroundWithBlock {
            (quote: AnyObject?, error: NSError?) -> Void in
            if error == nil && quote != nil {
                println(quote)
                if let pobj = quote! as? PFObject {
                    rv = self.toQuote( pobj )
                    notificationCenter.postNotificationName(kQuoteRefreshed, object: nil)
                    let aID = rv?.author?.authorID
                    self.getAuthorWithID(aID!, completion: completion)
                }
            } else {
                println(error)
            }
        }
    }
    
    // =====================
    
    func getAuthorWithID(authorID : Int, completion:( ()->() ))
    {
        var auth : Author? = nil
        var num : CGFloat = CGFloat(authorID)
        var query = PFQuery(className:"Authors")
        query.whereKey("AuthorID", equalTo: num )
        query.getFirstObjectInBackgroundWithBlock {
            (author: AnyObject?, error: NSError?) -> Void in
            if error == nil && author != nil {
                println(author)
                if let pobj = author! as? PFObject {
                    auth = self.toAuthor( pobj )
        
                }
            } else {
                println(error)
            }
        }
    }
    
    func toAuthor(pobj : PFObject) -> Author? {
        var rv : Author = Author()
        
    }
    // =====================
    func toQuote(pobj : PFObject) -> Quote? {
        var rv : Quote = Quote()
        let authorID  : Int = pobj["AuthorID"] as! Int
        let quotetext : String = pobj["Text"] as! String
        println("authorID = \(authorID) quotetext = \(quotetext)")
        rv.author = Author()
        rv.author?.authorID = authorID
        rv.text = quotetext
        return( rv )
    }
    
    // =====================
    func displayQuote( quote : Quote? ) -> Void {
        if let q = quote {
           quoteTextView.text = q.text
        }
    }
    
    
    // =====================
    func displayRandomQuote() {
       let qnum  = arc4random_uniform( UInt32( self.numberOfQuotes))
//       self.getNthQuote( qnum, completion:{(quote:Quote?) -> Void in self.displayQuote(quote)} )
       self.getNthQuote( qnum, completion:{() ->() in
                    notificationCenter.postNotificationName(kAuthorRefreshed, object: nil) } )
    }

}
