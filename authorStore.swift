//
//  authorStore.swift
//  Prattle
//
//  Created by Rick Zemer on 5/6/15.
//  Copyright (c) 2015 blockpuppy. All rights reserved.
//

import Foundation
import Parse
import XCGLogger

class authorStore {
    static let shared = authorStore()
    
    func createAuthor(author : Author, completion:(success : Bool, error : NSError?) -> Void ){
        log.verbose("+")
        let pfobject = toPFObject(author)
        pfobject.saveInBackgroundWithBlock(completion)
        log.verbose("-")
        }

    private func toPFObject( author: Author ) -> PFObject
    {
        log.verbose("+")
        let pfobj = PFObject(className: "Author")
        pfobj["ID"       ] = author.authorID
        pfobj["BirthYear"] = author.birthYear
        pfobj["DeathYear"] = author.deathYear
        pfobj["FirstName"] = author.firstName
        pfobj["LastName"]  = author.lastName
        pfobj["Origin"]    = author.origin
        log.verbose("firstname = \(author.firstName) lastname = \(author.lastName)")
        log.verbose("-")
        return( pfobj )
    }

   
    func getAuthorWithID(authorID : Int, completion:( (author : Author )->() ))
    {
        log.verbose("+ authorID = \(authorID)")
        var auth : Author? = nil
        var num  : CGFloat = CGFloat(authorID)
        
        var query = PFQuery(className:"Author")
        query.whereKey("ID", equalTo: num )
        query.getFirstObjectInBackgroundWithBlock {
            (author: AnyObject?, error: NSError?) -> Void in
            if error == nil && author != nil {
                if let pobj = author! as? PFObject {
                    auth = self.toAuthor( pobj )
                    completion(author: auth!)
                }
            } else {
                println(error)
            }
        }
        log.verbose("-")
    }


    func updateAuthor( author : Author ){
        log.verbose("+ author = \(author.firstName) \(author.lastName)")
        let objectID = author.objectID
        var query = PFQuery(className:"Author")
        query.getObjectInBackgroundWithId(objectID){
            (pfauthor : PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            }
            else {
                if var pfauthor = pfauthor {
                    self.updatePFObject( &pfauthor, author: author )
                    pfauthor.saveInBackground()
                }
            }
        }
        log.verbose("-")
    }
    
    func deleteAuthor( author : Author ) {
       // not implemented
    }

    private func updatePFObject( inout pfauthor : PFObject, author : Author ) {
        pfauthor["FirstName"] = author.firstName
        pfauthor["LastName" ] = author.lastName
        pfauthor["BirthYear"] = author.birthYear
        pfauthor["DeathYear"] = author.deathYear
        pfauthor["Origin"   ] = author.origin
        pfauthor.objectId     = author.objectID
    }
        
        
    private func toAuthor(pobj : PFObject) -> Author? {
        var rv : Author = Author()
        rv.authorID  = pobj["ID"       ] as! Int
        rv.birthYear = pobj["BirthYear"] as! Int
        rv.deathYear = pobj["DeathYear"] as! Int
        rv.firstName = pobj["FirstName"] as! String
        rv.lastName  = pobj["LastName" ] as! String
        rv.origin    = pobj["Origin"   ] as! String
        rv.objectID  = pobj.objectId!
        return( rv )
    }
    

    // MARK: - findAuthorByName
    // looks for matches for both first (if defined) and lastname.  This may result in more than
    // one (depending on what is entered) so an array of matches is used the parameter to the closure.
    func findAuthorByName(fname : String, lname : String, completion:( (authors : [Author]? )->() )) {
        log.verbose("+ fname = \(fname) lname = \(lname)")
        var auth : Author? = nil
        
        var query = PFQuery(className:"Author")
        
        if !fname.isEmpty {
            query.whereKey("FirstName", equalTo: fname )
        }
        if !lname.isEmpty {
            query.whereKey("LastName", equalTo: lname )
            query.findObjectsInBackgroundWithBlock {
                (authors: [AnyObject]?, error: NSError?) -> Void in
                
                var rv : [Author]? = nil
                if authors != nil && authors!.count > 0 {
                    rv = [Author]()
                    let alist = authors as! [PFObject]?
                    for pfobj in alist! {
                        let auth = self.toAuthor(pfobj)
                        rv!.append( auth! )
                    }
                }
                
                if error == nil {
                    completion( authors: rv )
                }
                else
                {   completion( authors: nil ); println(error) }
            }
        }
        else
        {   println("no last name supplied -- no match")
            completion( authors: nil )
        }
        log.verbose("-")
    }
}
