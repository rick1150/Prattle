//
//  AddQuoteViewController.swift
//  Prattle
//
//  Created by Rick Zemer on 5/6/15.
//  Copyright (c) 2015 blockpuppy. All rights reserved.
//

import UIKit

class AddQuoteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    var quoteDirty  = false
    var authorDirty = false
    var authorID    = 0
    var authorObserver : NSObjectProtocol?
    
    @IBOutlet weak var quoteLabel      : UILabel!
    @IBOutlet weak var quoteTextView   : UITextView!
    @IBOutlet weak var authorLabel     : UILabel!
    @IBOutlet weak var authorTextField : UITextField!
    
    @IBOutlet weak var doneButton      : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   // MARK: - textField Delegate methods
    func textFieldDidBeginEditing(textField: UITextField) {
        println("+/- textFieldDidBeginEditing")
        authorDirty = true
    }
    
    func textFieldDidEndEditing(textField: UITextField) { println("+/- textFieldDidEndEditing") }
   // MARK: - textView Delegate methods
    func textViewDidChange(textView: UITextView) {
        println("+/- textViewDidChange")
        quoteDirty = true
    }
    
    func textViewDidBeginEditing(textView: UITextView) { println("+/- textViewDidBeginEditing") }
    func textViewDidEndEditing(textView: UITextView)   { println("+/- textViewDidEndEditing"  ) }
   
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
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
    }
    
}
