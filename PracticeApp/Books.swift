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

    class func booksFromJSON(json: AnyObject) -> [Books] {

        var books = [Books]()

        let jsonBookResults = (json["results"]!)?["books"]!

        for dict in Array(arrayLiteral: jsonBookResults) {

            let bookTitle = dict?["title"] as! String
            let bookAuthor = dict?["author"] as! String

            let url = dict?["book_image"] as! String

            books.append(Books.init(title: bookTitle, author: bookAuthor, url: url))

        }

        return books

    }

    init(title: String, author: String, url: String?) {

        self.title = title
        self.author = author

        if let imgURL = url {
            self.imageUrl = imgURL
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
