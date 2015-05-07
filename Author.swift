//
//  Author.swift
//  Prattle
//
//  Created by Rick Zemer on 4/30/15.
//  Copyright (c) 2015 blockpuppy. All rights reserved.
//

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
    
    var currentAuthor : Author? {
        get { return Author._currentAuthor }
        set { Author._currentAuthor = newValue }
    }
    
    

}