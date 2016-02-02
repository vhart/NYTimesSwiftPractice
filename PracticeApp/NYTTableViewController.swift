//
//  NYTTableViewController.swift
//  PracticeApp
//
//  Created by Varindra Hart on 1/14/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import UIKit

protocol NYTTableViewDelegate {

    func didViewBookWithImage(img: UIImage)
}

class NYTTableViewController: UITableViewController {

    var delegate : NYTTableViewDelegate?

    var bestSeller = [Books]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "NYT Best Sellers: Fiction"

        AFWrapper.getJSONFromAPI { (dict: Dictionary<String, AnyObject>) in
            self.bestSeller = Books.booksFromJSON(dict)
            self.tableView.reloadData()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bestSeller.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookCell", forIndexPath: indexPath)

        let book = self.bestSeller[indexPath.row]

        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.author

        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let book = self.bestSeller[indexPath.row]
        book.getImageForBook { (image :UIImage?) in
            if image != nil {
                NSNotificationCenter.defaultCenter().postNotificationName("ImageLoadedNotification", object: image)
                self.delegate?.didViewBookWithImage(image!)
            }
        }

        let detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailVC.amazonLink = book.amazonUrl
        detailVC.book = book
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }

}
