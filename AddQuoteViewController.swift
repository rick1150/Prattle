//
//  AddQuoteViewController.swift
//  Prattle
//
//  Created by Rick Zemer on 5/6/15.
//  Copyright (c) 2015 blockpuppy. All rights reserved.
//

import UIKit
import XCGLogger

class AddQuoteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    var quoteDirty  = false
    var authorDirty = false
    var authorID    = 0
    var authorObserver : NSObjectProtocol?
    
    @IBOutlet weak var quoteLabel      : UILabel!
    @IBOutlet weak var quoteTextView   : UITextView!
    @IBOutlet weak var authorLabel     : UILabel!
    @IBOutlet weak var authorTextField : UITextField!
    @IBOutlet weak var doneButton      : UIBarButtonItem!
    @IBOutlet weak var authorPickerView: UIPickerView!
    
    @IBOutlet weak var multipleMatchTextLabel: UILabel!
    
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
        if authorDirty {
            let names = authorTextField.text.splitAtChar(" ")
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
            authorStore.shared.findAuthorByName( fname, lname: lname, completion:{(authors:[Author]?) in
                notificationCenter.postNotificationName(kAuthorFound, object: authors)
                 })
        }
        
        quoteStore.shared.quoteAlreadyExists( quoteTextView.text, completion:{(exists : Bool) -> Void in
            if exists { println("duplicate quote") }
            else { println(" new quote") }
            })
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
