//
//  stringExt.swift
//  extensions
//
//  Created by Rick Zemer on 4/16/15.
//  Copyright (c) 2015 blockpuppy. All rights reserved.
//

import Foundation

extension String {
    
    
    enum charSet :  String {
        
        case Numeric     = "0123456789"
        case UpperAlpha  = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        case LowerAlpha  = "abcdefghijklmnopqrstuvwxyz"
        case WhiteSpace  = "\u{0020}\u{00a0}\u{000d}\u{0009}\u{000b}\u{000c}\u{0000}"
        case Punctuation = "!()[];:'\",./?"
        case Symbol      = "~`@#$%^&*-_=+{}[]\\|"
        
    }

/*==============================================================================
 * Method: func strstr( tgt : String, pat : String ) -> Range
 *
 * Description: looks for 'pat' in 'tgt' and returns the string index to the
 * first occurence.  Returns nil if not found
 *
 * Parameters:
 * [I] tgt : String :- the string to be searched
 * [I] pat : String :- the pattern being sought
 *
 * Caveats: none known.
 *
 * Returns: String.Index?
 *============================================================================*/
func strstr( pat : String ) -> String.Index?
{
    var rv : String.Index? = nil
    var tststr = self
    for index in indices( tststr ) {
        tststr = dropFirst( tststr )
        if tststr.hasPrefix( pat ) {
            rv = index
            break
        }
    }
    return( rv )
}
    
/*==============================================================================
 * Method: func trimstr( ) -> String?
 *
 * Description: removes leading and trailing spaces from the caller and returns
 * the result
 *
 * Parameters: none
 *
 * Caveats: none known
 *
 * Returns: String?
 *============================================================================*/
func trimstr( ) -> String?
{
    var rv = ""
    let tststr = Array( self )
    rv = String(tststr.filter{$0 != " "})
    return( rv )
}
    
/*==============================================================================
 * Method: func purge( set : String ) -> String?
 * 
 * Description: removes all characters in the group 'set' from the caller and
 * returns the result.
 *
 * Parameters:
 * [I] group : charSet :- list of chars to remove from string
 *
 * Caveats: the groups are not necessarily cononical or exhaustive or complete
 *
 * Returns: String?
 *============================================================================*/
    func purge( group : charSet  ) -> String? {
        var rv = ""
        var flag = false
        for c in self {
            if !group.rawValue.contains(c) {
                rv += String(c)
            }
        }
        return( rv )
    }

/*==============================================================================
 * Method: func contains( ch : Character ) -> Bool {
 *
 * Description: looks for the character 'ch' in the caller and returns true
 * if the caller contains that character, or false if not
 *
 * Parameters:
 * [I] ch : Character
 *
 * Caveats: none known.
 *
 * Returns: Bool
 *============================================================================*/
    func contains( ch : Character ) -> Bool {
        let s  = Array(self)
        let str = s.filter{ $0 == ch }
        let rv = str.isEmpty
        return( !rv )
    }
    
    
/*==============================================================================
 * Method: func numContained( ch : Character ) -> Int {
 *
 * Description: returns the number of occurances of 'ch' in the caller.
 *
 * Parameters:
 * [I] ch : Character
 *
 * Caveats: none known.
 *
 * Returns: Int
 *============================================================================*/
    func numContained( ch : Character ) -> Int {
        let s = Array(self)
        let str = s.filter{ $0 == ch }
        return( str.count )
    }
    
    
/*==============================================================================
 * Method: func removeCharAtIndex( nth : Int ) -> String {
 *
 * Description: removes the specified character from the caller and returns
 * the result.
 *
 * Parameters:
 * [I] nth : Int
 *
 * Caveats: Probably not very fast, but works
 *
 * Returns: String?
 *============================================================================*/
    func removeCharAtIndex( nth : Int ) -> String? {
        var rv : String? = nil
        if nth < count(self) && nth >= 0 {
            var a1 = Array(self)
            a1.removeAtIndex(nth)
            rv = String( a1 )
        }
        return( rv )
    }
    
    
/*==============================================================================
 * Method: func replaceEachChar ( new : Character, old : Character ) -> String
 *
 * Description: replaces each occurance of 'old' with 'new' in the caller and
 * returns the result.
 *
 * Parameters:
 * [I] new : Character
 * [I] old : Character
 *
 * Caveats: none known.
 *
 * Returns: String
 *============================================================================*/

    
    
    func replaceEachChar ( new : Character, old : Character ) -> String {
        var rv : String = self
        var s  = Array( self )
        s = s.map{ ($0 == old) ? new : $0 }
        rv = String(s)
        return( rv )
    }

/*==============================================================================
 * Method: func splitAtChar( cc : Character ) -> [String]? {
 *
 * Description: splits the sender at each occurance of 'cc' into a new string.
 * An array of the resulting strings is returned.
 *
 * Parameters:
 * [I] cc : Character
 *
 * Caveats: none known.
 *
 * Returns: [String]?
 *============================================================================*/
    func splitAtChar( cc : Character ) -> [String]? {
        var rv  = [String]()
        var str = Array( self )
        var tstr = ""
        for ch in (str) {
            if (ch == cc) && !tstr.isEmpty {
                rv.append( tstr )
                tstr = ""
            }
            else
            {   tstr.append(ch) }
        }
        if !tstr.isEmpty {
            rv.append(tstr)
        }

        return( rv )
    }


}


