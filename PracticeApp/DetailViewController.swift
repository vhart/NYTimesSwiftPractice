//
//  DetailViewController.swift
//  PracticeApp
//
//  Created by Varindra Hart on 1/15/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import UIKit
import SafariServices
import AVFoundation

class DetailViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pullBar: UIView!
    @IBOutlet weak var audioView: UIView!

    let synthesizer = AVSpeechSynthesizer()
    var amazonLink: String? = nil
    var book : Books? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Cover Image!"

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateImageView:", name: "ImageLoadedNotification", object: nil)
        addPanGesture()
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

    func addPanGesture() {

        let panGest = UIPanGestureRecognizer.init(target: self, action: "handlePanning:")
        self.pullBar.addGestureRecognizer(panGest)

    }

    func handlePanning(pan: UIPanGestureRecognizer) {
        print(pan.translationInView(self.view).y)

        let offset = pan.translationInView(self.view).y
        if offset < 0 {
            let newY = max(self.audioView.frame.origin.y + offset, self.view.bounds.height - 80)
            self.audioView.frame.origin = CGPointMake(self.audioView.frame.origin.x, newY)
        } else if offset > 0{
            let newY = min(self.audioView.frame.origin.y + offset, self.view.bounds.height - 40)
            self.audioView.frame.origin = CGPointMake(self.audioView.frame.origin.x, newY)
        }
        pan.setTranslation(CGPointZero, inView: self.view)
    }

    @IBAction func playDescription(sender: AnyObject) {
        if synthesizer.speaking{
            synthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        }
        else{
            let utterance = AVSpeechUtterance(string: stringForBook())
            utterance.rate = 0.38
            synthesizer.speakUtterance(utterance)
        }
    }

    func stringForBook() -> String{
        var str = ""

        if let book = self.book {
            str.appendContentsOf(book.title)
            str.appendContentsOf(" by ")
            str.appendContentsOf("\(book.author). ")
            if let desc = book.description{
                str.appendContentsOf(desc)
            }
        }

        return str
    }

}
