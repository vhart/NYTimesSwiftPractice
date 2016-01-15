//
//  ViewController.swift
//  PracticeApp
//
//  Created by Varindra Hart on 1/14/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import UIKit


class ViewController: UIViewController, NYTTableViewDelegate {
    @IBOutlet weak var imageOfLastViewed: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "NYTBestSellerApp"

        AFWrapper.getJSONFromAPI {
            (dict : Dictionary<String, AnyObject>) in
                print(dict)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func viewBooks(sender: UIButton) {

        let tableView = self.storyboard?.instantiateViewControllerWithIdentifier("BooksTableView") as! NYTTableViewController

        tableView.delegate = self

        self.navigationController?.pushViewController(tableView, animated: true)

    }

    func didViewBookWithImage(img: UIImage) {
        self.imageOfLastViewed.image = img
    }

}

