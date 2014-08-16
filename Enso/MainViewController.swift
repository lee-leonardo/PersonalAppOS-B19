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
	
//MARK:
//MARK: View methods
    override func viewDidLoad() {
        super.viewDidLoad()

		self.scrollView = UIScrollView(frame: self.view.frame)
		makeMainScrollView()
    }
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "shareRequest:", name: "ShareRequest", object: nil)
		
		//println("\(self.haiku?.lines)")
	}
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "ShareRequest", object: nil)

	}
	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
//MARK: Methods
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
		shareController.view.frame = CGRect(x: thirdX, y: 0, width: standardWidth, height: standardHeight)
		
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
	
//MARK:
//MARK: Delegates
	func haikuTextChanged(haikuText: String) {
		if self.haiku != nil {
			self.haiku?.lines = haikuText
		} else {
			self.haiku = Haiku(haiku: haikuText)
		}
		//println("Main received Haiku Text")
		//println("\(self.haiku?.lines)")
	}
	func photoSelected(selectedImage: UIImage) {
		//println("Main received Photo")
		self.haiku?.photo = selectedImage
	}
//MARK:
//MARK: Target-Action
	func shareRequest(sender : AnyObject!) {
		if self.haiku != nil {
			//println("Share request received!")
			var sendHaiku = NSDictionary(object: self.haiku, forKey: "haiku")
			NSNotificationCenter.defaultCenter().postNotificationName("ShareHaiku", object: self, userInfo: sendHaiku)
		}

	}
	
}
