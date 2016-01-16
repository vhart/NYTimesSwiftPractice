//
//  DetailViewController.swift
//  PracticeApp
//
//  Created by Varindra Hart on 1/15/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!

    var amazonLink: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Cover Image!"

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateImageView:", name: "ImageLoadedNotification", object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateImageView(note : NSNotification) {
        let image = note.object as! UIImage
        self.imageView.image = image

        let tapGesture = UITapGestureRecognizer(target: self, action: "launchSafari")

        self.imageView.addGestureRecognizer(tapGesture)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func launchSafari() {

        let safariVC = SFSafariViewController(URL: NSURL(string: self.amazonLink!)!)

        safariVC.delegate = self

        self.presentViewController(safariVC, animated: true, completion: nil)
    }

    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

}
