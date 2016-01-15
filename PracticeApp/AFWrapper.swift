//
//  AFWrapper.swift
//  PracticeApp
//
//  Created by Varindra Hart on 1/14/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import UIKit
import Alamofire

class AFWrapper: NSObject {
    override init() {
        super.init()
    }
    
    class func getJSONFromAPI(closure: (dict:AnyObject) -> Void){
        Alamofire.request(.GET, RequestString).responseJSON {
            response in
            closure(dict: response.result.value!)
        }
    }
    
}

let BooksKey = "d25345a707f551c6d74e24e9b96391da:8:74017814"

var RequestString = "http://api.nytimes.com/svc/books/v3/lists/2016-01-11/hardcover-fiction?api-key=\(BooksKey)"
//moved to bottom


