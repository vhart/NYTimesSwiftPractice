//
//  Books.swift
//  PracticeApp
//
//  Created by Varindra Hart on 1/14/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import UIKit

class Books{

    let title : String
    let author : String
    var imageUrl : String? = nil
    var amazonUrl : String? = nil

    class func booksFromJSON(json: Dictionary<String,AnyObject>) -> [Books] {

        var books = [Books]()

        if let result = json["results"] as? Dictionary<String,AnyObject> {

            if let booksFromResults = result["books"] as? [AnyObject] {

                for i in 0..<booksFromResults.count {

                   if let dict = booksFromResults[i] as? Dictionary<String,AnyObject> {
                    let bookTitle = dict["title"] as! String

                    let bookAuthor = dict["author"] as! String

                    let url = dict["book_image"] as! String

                    let amzUrl = dict["amazon_product_url"] as! String

                    books.append(Books.init(title: bookTitle, author: bookAuthor, url: url, amazon: amzUrl))
                    }

                }

            }

        }
        return books
    }

    init(title: String, author: String, url: String?, amazon: String?) {

        self.title = title
        self.author = author

        if let imgURL = url {
            self.imageUrl = imgURL
        }

        if let amzURL = amazon {
            self.amazonUrl = amzURL
        }

    }

    func getImageForBook(completion :(image: UIImage?) -> Void) {

        guard imageUrl != nil else{
            completion(image: nil)
            return
        }

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)){

            let url = NSURL(string: self.imageUrl!)
            let data = NSData(contentsOfURL: url!)
            let bookImage = UIImage(data: data!)

            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                completion(image: bookImage)
            })

        }

    }
}
