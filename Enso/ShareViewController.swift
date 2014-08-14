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
	
	var haiku : Haiku?

	@IBAction func twitterButton(sender: AnyObject) {
		NSNotificationCenter.defaultCenter().postNotificationName("ShareRequest", object: nil)

		
		if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
			var tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
			tweetSheet.setInitialText("Test text")
//tweetSheet.addImage(<#image: UIImage!#>)
			self.presentViewController(tweetSheet, animated: true, completion: nil)
		}
		
	}
	
	@IBAction func facebookButton(sender: AnyObject) {
		NSNotificationCenter.defaultCenter().postNotificationName("ShareRequest", object: nil)

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
		//println("Preference Loaded!")
    }
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		println("View Should've appeared")
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveHaiku:", name: "ShareHaiku", object: nil)
	}
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		println("ViewDidAppear")
	}
	override func viewWillDisappear(animated: Bool) {
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "ShareHaiku", object: nil)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	
//MARK: NotificationCenter methods
	func receiveHaiku( sender: AnyObject! ) {
		if let gotHaiku = sender as? Dictionary<String,Haiku> {
			println("\(gotHaiku)")
			if let actualHaiku = gotHaiku["haiku"] {
				println("\(actualHaiku.lines)")
				self.haiku = Haiku(haiku: actualHaiku.lines)
				if actualHaiku.photo? != nil {
					println("\(actualHaiku.photo)")
					self.haiku?.photo = actualHaiku.photo
				}
			}
		}
	}
}




