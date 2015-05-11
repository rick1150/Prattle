//
//  AddQuoteViewController.swift
//  Prattle
//
//  Created by Rick Zemer on 5/6/15.
//  Copyright (c) 2015 blockpuppy. All rights reserved.
//

import UIKit
import XCGLogger

let addLoopSleepTime : UInt32 = (200 * 1000)
let TimeoutSeconds   : UInt32 = 10
let AnonymousID      : Int    =  0
let AuthorNotFound   : Int    = -1
let QueryPending     : Int    = -2

class AddQuoteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    var quoteDirty  = false
    var authorDirty = false
    var authorID    = AnonymousID
    var authorObserver : NSObjectProtocol?
    
    @IBOutlet weak var busySpinner: UIActivityIndicatorView!
    @IBOutlet weak var quoteLabel      : UILabel!
    @IBOutlet weak var quoteTextView   : UITextView!
    @IBOutlet weak var authorLabel     : UILabel!
    @IBOutlet weak var authorTextField : UITextField!
    @IBOutlet weak var doneButton      : UIBarButtonItem!
    @IBOutlet weak var sourceLabel     : UILabel!
    @IBOutlet weak var sourceTextField : UITextField!
    
/*==============================================================================
 * Method: 
 * 
 * Description:
 *
 * Parameters:
 *
 * Caveats:
 *
 * Returns:
 *============================================================================*/
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        log.verbose("+")
        authorObserver = notificationCenter.addObserverForName(kAuthorFound,
            object: nil, queue: mainQueue, usingBlock:  { (note:NSNotification!) in
                var auths : [Author]? = note.object as! [Author]?
                if note.object == nil {
                    println(" author NOT Found")
                }
                else if auths!.count > 1 {
                    println("more than one found")
                }
                else
                {   self.authorID = auths![0].authorID }
        })
        log.verbose("observer for AuthorFound added")
        // Do any additional setup after loading the view.
        log.verbose("-")
    }
    
    /*==============================================================================
    * Method:
    *
    * Description:
    *
    * Parameters:
    *
    * Caveats:
    *
    * Returns:
    *============================================================================*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        log.error(" * DidReceiveMemoryWarning *")
        // Dispose of any resources that can be recreated.
    }
    
    
    /*==============================================================================
    * Method:
    *
    * Description:
    *
    * Parameters:
    *
    * Caveats:
    *
    * Returns:
    *============================================================================*/
   // MARK: - textField Delegate methods
    func textFieldDidBeginEditing(textField: UITextField) {
    }
    
    @IBAction func authorNameEditingBegan(sender: AnyObject) {
        log.verbose("+/-")
        authorDirty = true
    }
    
    /*==============================================================================
    * Method:
    *
    * Description:
    *
    * Parameters:
    *
    * Caveats:
    *
    * Returns:
    *============================================================================*/
    

    func textViewDidBeginEditing(textView: UITextView) {
        log.verbose("+/-")
        if !quoteDirty {
            quoteTextView.text = ""
        }
        quoteDirty = true
    }
    
   
    
    /*==============================================================================
    * Method:
    *
    * Description:
    *
    * Parameters:
    *
    * Caveats:
    *
    * Returns:
    *============================================================================*/
    @IBAction func doneButtonTapped(sender: AnyObject) {
        log.verbose("+")
        log.verbose("author spec: \(self.authorTextField.text) ")
        log.verbose("quote text:  \(self.quoteTextView.text) ")
        if quoteDirty {
            self.busySpinner.startAnimating()
            self.busySpinner.hidden = false
            if authorDirty {
                lookUpAuthor( authorTextField.text )
            }
            else { authorID = AnonymousID }
        
       
            let md5 = quoteTextView.text.computeFlatMD5()
            quoteStore.shared.quoteSignatureAlreadyExists( md5, completion:{(exists : Bool) -> Void in
                if exists { println("duplicate quote") }
                else {
                    println(" new quote")
                    let quote = Quote( txt: self.quoteTextView.text, md5: md5, source: self.sourceTextField.text )
                        self.addNewQuote( quote )
                }
            })
        }
    }
    
    /*==============================================================================
    * Method: func lookUpAuthor( name : String ) {
    *
    * Description:
    *
    * Parameters:
    *
    * Caveats:
    *
    * Returns:
    *============================================================================*/
    func lookUpAuthor( name : String ) {
        let (fname, lname) = parseAuthorName( name )

        authorID = QueryPending
        authorStore.shared.findAuthorByName( fname, lname: lname, completion:{(authors:[Author]?) in
            if let author = authors?.first {
                self.authorID = author.authorID
            }
            else { self.authorID = AuthorNotFound }
         })
    }

    /*==============================================================================
    * Method: func parseAuthorName( name : String ) -> (String, String) {
    *
    * Description:
    *
    * Parameters:
    *
    * Caveats:
    *
    * Returns:
    *============================================================================*/
    func parseAuthorName( name : String ) -> (String, String) {
        let names = name.splitAtChar(" ")
        var fname : String = ""
        var lname : String = ""
        var ii = 0
        if names?.count == 1 {
            lname = names![0]
        }
        else if names?.count == 2 {
            fname = names![0]; lname = names![1]
        }
        if names?.count > 2 {
            for ii in 0..<(names!.count - 1) {
                fname = fname + names![ii]
            }
        }
        return( fname, lname )
    }
    
    /*==============================================================================
    * Method: func addNewQuote( quote : Quote ){
    *
    * Description:
    *
    * Parameters:
    *
    * Caveats:
    *
    * Returns:
    *============================================================================*/
    func addNewQuote( quote : Quote ){
        log.verbose("+addNewQuote")
        var stop = false
       
        // so we don't wait forever.
        var timeoutObserver = notificationCenter.addObserverForName(kAddQuoteTimeout,
            object: nil, queue: mainQueue, usingBlock:  { (note:NSNotification!) in
                log.verbose("stop is true -- TIMEOUT")
                stop = true
        })
        
        dispatch_async(GlobalUserInitiatedQueue) {
            sleep( TimeoutSeconds )
            log.verbose("sending TIMEOUT notification")
            notificationCenter.postNotificationName(kAddQuoteTimeout, object: nil)
        }
        
        while ( authorID == QueryPending && !stop) { usleep(addLoopSleepTime) }
        if authorID == AuthorNotFound {
            log.verbose(" author not found -- adding new")
        }
        else { quote.authorID = authorID }
        quoteStore.shared.createQuote( quote, completion:{(success, error) -> Void in
            if error != nil {
                println(error)
            }
            else {   println(" quote saved" ) }
            self.busySpinner.stopAnimating()
            self.busySpinner.hidden = true
        })
        notificationCenter.removeObserver(timeoutObserver)
    }
    
    
    /*==============================================================================
    * Method: func addNewAuthor( name : String ) {
    *
    * Description:
    *
    * Parameters:
    *
    * Caveats:
    *
    * Returns:
    *============================================================================*/
    func addNewAuthor( name : String ) {
        let (fname, lname) = parseAuthorName( name )
        let author = Author(fname: fname, lname: lname)
        authorStore.shared.createAuthor(author, completion: nil)
    }
    
   
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return("")
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
}
