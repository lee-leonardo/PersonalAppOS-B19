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
	
	var networkController = NetworkController()
	var pinterest = Pinterest()
	var interactionController = UIDocumentInteractionController()
	var haiku : Haiku?

	
//MARK: - IBAction
	@IBAction func twitterButton(sender: AnyObject) {
		
		NSNotificationCenter.defaultCenter().postNotificationName("ShareRequest", object: nil)
		//println("Haiku text: \(haiku?.lines)")
		
		if self.haiku != nil {
			
			if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
				var tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
				
				tweetSheet.setInitialText(self.haiku?.lines)
				
				if self.haiku?.photo != nil {
					tweetSheet.addImage(self.haiku?.photo)

				}
				
				self.presentViewController(tweetSheet, animated: true, completion: nil)
			}
		} else {
			//Alert Action
			var cannotAlert = UIAlertController(title: "Not setup!", message: "Somethings wrong with your haiku!", preferredStyle: UIAlertControllerStyle.Alert)
			let okay = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Cancel, handler: nil)
			cannotAlert.addAction(okay)
			
			
			self.presentViewController(cannotAlert, animated: true, completion: nil)
		}
		
	}
	
	@IBAction func facebookButton(sender: AnyObject) {
		
		NSNotificationCenter.defaultCenter().postNotificationName("ShareRequest", object: nil)
		if self.haiku != nil {
			
			if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
				var shareSheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
				shareSheet.setInitialText(self.haiku?.lines)
				
				if self.haiku?.photo != nil {
					shareSheet.addImage(self.haiku?.photo)
				}
				
				
				self.presentViewController(shareSheet, animated: true, completion: nil)
			}
			
		} else {
			//Alert Action
			var cannotAlert = UIAlertController(title: "Not setup!", message: "Somethings wrong with your haiku!", preferredStyle: UIAlertControllerStyle.Alert)
			let okay = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Cancel, handler: nil)
			cannotAlert.addAction(okay)
			
			
			self.presentViewController(cannotAlert, animated: true, completion: nil)
		}
	}
	
	@IBAction func instagramButton(sender: AnyObject) {
		println("Need to implement")
		
		var instagramURL = NSURL(fileURLWithPath: "instagram://")
		
		if UIApplication.sharedApplication().canOpenURL(instagramURL) {
			UIApplication.sharedApplication().openURL(instagramURL)
		} else {
			var unInstagram = UIAlertController(title: "Cannot access Instagram", message: "Either you cannot access Instagram or do not have it installed", preferredStyle: UIAlertControllerStyle.Alert)
			var okay = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Cancel, handler: nil)
			unInstagram.addAction(okay)
			self.presentViewController(unInstagram, animated: true, completion: nil)
		}
		
		
	}
	
	
	@IBAction func pinterestButton(sender: AnyObject) {
		println("Need to implement")
//		if SLComposeViewController.isAvailableForServiceType()
	}
	
	func pinIt(sender: AnyObject! ) {
//		pinterest.createPinWithImageURL(<#imageURL: NSURL!#>, sourceURL: <#NSURL!#>, description: <#String!#>)
	}
	
//MARK: - View methods
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor(hue: 240 / 360, saturation: 0.5, brightness: 1, alpha: 0.2)
		//println("Preference Loaded!")
		
		//Initialize pinterest button.
		var pinterest = Pinterest.pinItButton()
		pinterest.addTarget(self, action: "pinIt:", forControlEvents: UIControlEvents.TouchUpInside)
		self.view.addSubview(pinterest)
		

    }
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		//println("View Should've appeared")
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveHaiku:", name: "ShareHaiku", object: nil)

	}
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		//println("ViewDidAppear")
	}
	override func viewWillDisappear(animated: Bool) {
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "ShareHaiku", object: nil)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
//MARK: - Target-Action
	func receiveHaiku(sender: AnyObject! ) {
		//println("receiveHaikuFired")
		//println("receiveHaiku object: \(sender)")
		
		if let notification = sender as? NSNotification {
			
			if let haikuDict = notification.userInfo as? Dictionary<String,Haiku> {
				//println("\(haikuDict)")
				
				if let actualHaiku = haikuDict["haiku"] {
					//println("\(actualHaiku.lines)")
					self.haiku = Haiku(haiku: actualHaiku.lines)
					
					if actualHaiku.photo? != nil {
						//println("\(actualHaiku.photo)")
						self.haiku?.photo = actualHaiku.photo
					}
				}
			}
		}
	}
	
}
