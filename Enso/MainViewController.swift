//
//  MainViewController.swift
//  Enso
//
//  Created by Leonardo Lee on 8/12/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, HaikuDelegate, PhotoDelegate {
	
	var scrollView  : UIScrollView!
	var haiku : Haiku?
	var image : UIImage?
	var helpTimer : NSTimer!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.scrollView = UIScrollView(frame: self.view.frame)
		makeMainScrollView()
		//self.resetTimer()
    }
	
//	func resetTimer() {
//		if self.helpTimer != nil {
//			self.helpTimer.invalidate()
//		}
//		
//		self.helpTimer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("showHelpMessageCallout"), userInfo: nil, repeats: true)
//	}
	
//	func showHelpMessageCallout() {
//		self.showCalloutWithMessage("Tap here to get started", inRect: CGRect(x: 50, y: 80, width: 120, height: 90))
//		self.helpTimer.invalidate()
//	}
	
	override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
		
		//self.resetTimer()
		super.touchesBegan(touches, withEvent: event)
	}
	
	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	func makeMainScrollView() {
		var totalWidth = self.view.frame.width * 3
		var totalHeight = self.view.frame.height
		self.scrollView.contentSize = CGSize(width: totalWidth, height: totalHeight)
		self.scrollView.pagingEnabled = true
		self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
		self.scrollView.bounces = true
		self.scrollView.alwaysBounceHorizontal = true
		self.view.addSubview(self.scrollView)
		
		var haikuController = self.storyboard.instantiateViewControllerWithIdentifier("Write") as HaikuViewController
		var photoController = self.storyboard.instantiateViewControllerWithIdentifier("Photo") as PhotoViewController
		var shareController = self.storyboard.instantiateViewControllerWithIdentifier("Share") as ShareViewController
		
		haikuController.delegate = self
		photoController.delegate = self
		
		var firstX = 0
		var secondX = Int(self.view.frame.width)
		var thirdX = Int(self.view.frame.width * 2)
		var standardWidth = Int(self.view.frame.width)
		var standardHeight = Int(self.view.frame.height)
		
		haikuController.view.frame = CGRect(x: firstX, y: 0, width: standardWidth, height: standardHeight)
		photoController.view.frame = CGRect(x: secondX, y: 0, width: standardWidth, height: standardHeight)
		shareController.view.frame = CGRect(x: thirdX, y: 0, width: standardWidth + 5, height: standardHeight)
		
		self.addChildViewController(haikuController)
		self.addChildViewController(photoController)
		self.addChildViewController(shareController)
		
		self.scrollView.addSubview(haikuController.view)
		self.scrollView.addSubview(photoController.view)
		self.scrollView.addSubview(shareController.view)
		
		haikuController.didMoveToParentViewController(self)
		photoController.didMoveToParentViewController(self)
		shareController.didMoveToParentViewController(self)
	}
	
//MARK: Delegates
	func haikuTextChanged(haikuText: String) {
		self.haiku = Haiku(haiku: haikuText)
		println("Haiku text")
		println("\(self.haiku?.lines)")
	}
	func photoSelected(selectedImage: UIImage) {
		println("Photo has been received by mainVC")
		self.image = selectedImage
	}
	
}
