//
//  quoteStore.swift
//  Prattle
//
//  Created by Rick Zemer on 5/7/15.
//  Copyright (c) 2015 blockpuppy. All rights reserved.
//

import Foundation
import Parse

class quoteStore {
    static let shared = quoteStore()
    
    var count = 0
    
    func createQuote( quote : Quote, completion:(success:Bool, error: NSError?) -> Void ){
        let pfobject = toPFObject(quote)
        pfobject.saveInBackgroundWithBlock(completion)
        }
    
    
    private func toPFObject(quote : Quote ) -> PFObject {
        var pfobj = PFObject(className: "Quotes")
        updatePFObject( &pfobj, quote: quote )
       return(pfobj)
        }
    
    private func updatePFObject( inout pfobj : PFObject, quote : Quote ){
        // pfobj["ObjectID"] = quote.objectID
        pfobj.objectId    = quote.objectID
        pfobj["AuthorID"] = quote.authorID
        pfobj["Text"    ] = quote.text
        pfobj["Year"    ] = quote.year
        pfobj["Source"  ] = quote.source
        pfobj["Favorite"] = quote.fave
        pfobj["Topic"   ] = quote.topic.rawValue
    }
    
    func updateQuote( quote : Quote ){
        var query = PFQuery(className:"Quotes")
        query.getObjectInBackgroundWithId(quote.objectID) {
            (pfquote : PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            }
            else if var pfobj = pfquote {
                self.updatePFObject( &pfobj, quote: quote )
                pfquote!.saveInBackground()
            }
        }
    }
    
    func quoteAlreadyExists( qstr : String, completion:(exists : Bool) -> Void  ) {
        let md5 = qstr.computeFlatMD5()
        var query = PFQuery(className: "Quotes")
        query.whereKey("MD5", equalTo: md5 )
        query.getFirstObjectInBackgroundWithBlock {
            (quote: AnyObject?, error : NSError?) in
            let rv = (quote == nil) ? false : true
            completion( exists: rv )
        }
    }
    
        
    func getNthQuote( nth : Int, completion:(quote: Quote) -> () ) -> Void {
        var query = PFQuery(className:"Quotes")
            query.whereKey("QuoteID", greaterThanOrEqualTo: nth )
            query.getFirstObjectInBackgroundWithBlock {
                (quote: AnyObject?, error: NSError?) -> Void in
                if error == nil && quote != nil {
                    println(quote)
                    if let pobj = quote! as? PFObject {
                        let qobj = self.toQuote( pobj )
                        notificationCenter.postNotificationName(kQuoteRefreshed, object: qobj)
                        let aID = qobj.authorID
                        authorStore.shared.getAuthorWithID(aID) { (author ) in
                            if error != nil {
                                println(error)
                            }
                            else {
                                notificationCenter.postNotificationName(kAuthorRefreshed, object: author)
                            }
                        }
                    }
                } else {
                    println(error)
                }
            }
        }

private func toQuote( pfobj : PFObject ) -> Quote {
    
    let rv = Quote()
    rv.objectID = pfobj.objectId!
    rv.authorID = pfobj["AuthorID"] as! Int
    rv.text     = pfobj["Text"    ] as! String
    rv.source   = pfobj["Source"  ] as! String
    if let fave = pfobj["Favorite"] as? Bool {
        rv.fave = fave
    }
    else
    {   rv.fave = false }
    if let tstr = pfobj["Topic"   ] as? String
    {
        rv.topic = Topic(rawValue: tstr )!
    }
    else
    {   rv.topic = Topic(rawValue: "undef")! }
    return( rv )
}

}


