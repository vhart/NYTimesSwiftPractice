//
//  DetailViewController.swift
//  PracticeApp
//
//  Created by Varindra Hart on 1/15/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

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
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
