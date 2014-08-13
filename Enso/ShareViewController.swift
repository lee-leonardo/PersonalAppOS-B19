//
//  PreferenceViewController.swift
//  Enso
//
//  Created by Leonardo Lee on 8/11/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit
import Social

class ShareViewController: UIViewController {

	@IBAction func twitterButton(sender: AnyObject) {
		if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
			var tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
			tweetSheet.setInitialText("Test text")
//			tweetSheet.addImage(<#image: UIImage!#>)
			self.presentViewController(tweetSheet, animated: true, completion: nil)
		}
		
	}
	
	@IBAction func facebookButton(sender: AnyObject) {
		if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
			var shareSheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
			shareSheet.setInitialText("Test text")
//			shareSheet.addImage(<#image: UIImage!#>)
			self.presentViewController(shareSheet, animated: true, completion: nil)
		}
	}
	
	@IBAction func instagramButton(sender: AnyObject) {
		println("Need to implement")
	}
	
	@IBAction func pinterestButton(sender: AnyObject) {
		println("Need to implement")
//		if SLComposeViewController.isAvailableForServiceType()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor(hue: 240 / 360, saturation: 0.5, brightness: 1, alpha: 0.2)

		
		println("Preference Loaded!")
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
