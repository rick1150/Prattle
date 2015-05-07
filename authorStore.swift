//
//  authorStore.swift
//  Prattle
//
//  Created by Rick Zemer on 5/6/15.
//  Copyright (c) 2015 blockpuppy. All rights reserved.
//

import Foundation
import Parse

class authorStore {
    static let shared = authorStore()
    
    func createAuthor(author : Author, completion:(success : Bool, error : NSError?) -> Void ){
        let pfobject = toPFObject(author)
        pfobject.saveInBackgroundWithBlock(completion)
        }

    private func toPFObject( author: Author ) -> PFObject
    {
        let pfobj = PFObject(className: "Author")
        pfobj["ID"       ] = author.authorID
        pfobj["BirthYear"] = author.birthYear
        pfobj["DeathYear"] = author.deathYear
        pfobj["FirstName"] = author.firstName
        pfobj["LastName"]  = author.lastName
        pfobj["Origin"]    = author.origin
        return( pfobj )
    }

   
    func getAuthorWithID(authorID : Int, completion:( (author : Author )->() ))
    {
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
    }


    func updateAuthor( author : Author ){
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
//        pfauthor["objectID" ] = author.objectID
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
//        rv.objectID  = pobj["objectID" ] as! String
        rv.objectID  = pobj.objectId!
        return( rv )
    }
    
//    func toPFObject( author: Author ) -> PFObject {
//        let rv = PFObject(className: "Author")
//        rv["FirstName"] = author.firstName
//        rv["LastName" ] = author.lastName
//        rv["BirthYear"] = author.birthYear
//        rv["DeathYear"] = author.deathYear
//        rv["Origin"   ] = author.origin
//        rv["objectID" ] = author.objectID
//        return( rv )
//    }
}