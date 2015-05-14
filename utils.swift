//
//  utils.swift
//  Prattle
//
//  Created by Rick Zemer on 5/13/15.
//  Copyright (c) 2015 blockpuppy. All rights reserved.
//

import Foundation

/*==============================================================================
* Method: func parseAuthorName( name : String ) -> (String, String) {
*
* Description: converts the string 'name' into two strings (if possible) -- 
* a firstname and a lastname.  The last space delimited word is used as the
* last name, all preceeding words are used as the firstname.  So, for example,
* "Jean Luc Picard"   would have "Jean Luc" as the first name, and "Picard"
* as the last name.  If there are no spaces (a single word) it is returned as 
* the last name.
*
* Parameters:
* [I] name : String :- the string to be parsed
*
* Caveats:
*
* Returns: (String, String)
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
            fname = fname +  names![ii] + " "
        }
        lname = names!.last!
    }
    fname = fname.trimstr()!
    lname = lname.trimstr()!
    return( fname, lname )
}
    