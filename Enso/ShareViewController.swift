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
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		//println("Preference Loaded!")
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
