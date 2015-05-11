//
//  Author.swift
//  Prattle
//
//  Created by Rick Zemer on 4/30/15.
//  Copyright (c) 2015 blockpuppy. All rights reserved.
//
// Note: The intent is to never delete an author so that the Count + 1
// can always be used as the author id.  This eliminates the issue of 
// holes, and duplicate authorIDs.  If an author should be marked as
// invalid, that field (valid) can be set to false so it will not
// be used.

import Foundation
import Parse

class Author {
    static var _currentAuthor : Author? = nil
    
    var authorID  : Int    = 0
    var firstName : String = ""
    var lastName  : String = ""
    var birthYear : Int    = 0
    var deathYear : Int    = 0
    var origin    : String = ""
    var objectID  : String = ""
    var valid     : Bool   = true
    
    var currentAuthor : Author? {
        get { return Author._currentAuthor }
        set { Author._currentAuthor = newValue }
    }
    
    
    init() {
        authorID  = 0
        firstName = ""
        lastName  = ""
        birthYear = 0
        deathYear = 0
        origin    = ""
        objectID  = ""
        valid     = true
    }
    convenience init( fname : String, lname : String ) {
        self.init()
        firstName = fname
        lastName  = lname
        authorID  = authorStore.shared.getNewAuthorID()
    }

}