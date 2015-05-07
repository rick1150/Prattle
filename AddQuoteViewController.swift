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
    
    @IBOutlet weak var quoteLabel      : UILabel!
    @IBOutlet weak var quoteTextView   : UITextView!
    @IBOutlet weak var authorLabel     : UILabel!
    @IBOutlet weak var authorTextField : UITextField!
    
    @IBOutlet weak var doneButton      : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    func textViewDidEndEditing(textView: UITextView) { println("+/- textViewDidEndEditing") }
   
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        if authorDirty {
            
        }
    }
    
}
