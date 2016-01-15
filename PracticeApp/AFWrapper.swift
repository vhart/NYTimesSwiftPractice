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

    class func getJSONFromAPI(closure: (dict : Dictionary<String, AnyObject>) -> Void){
        Alamofire.request(.GET, RequestString).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, AnyObject> {
                closure(dict: json)
            }
        }
    }
}

let BooksKey = "d25345a707f551c6d74e24e9b96391da:8:74017814"

var RequestString = "http://api.nytimes.com/svc/books/v3/lists/2016-01-11/hardcover-fiction?api-key=\(BooksKey)"
//moved to bottom


