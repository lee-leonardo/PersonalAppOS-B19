//
//  MainViewController.swift
//  Enso
//
//  Created by Leonardo Lee on 8/12/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
	
	var scrollView  : UIScrollView!
	var haiku : Haiku?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.scrollView = UIScrollView(frame: self.view.frame)
		
		var totalWidth = self.view.frame.width * 3
		var totalHeight = self.view.frame.height
		self.scrollView.contentSize = CGSize(width: totalWidth, height: totalHeight)
		self.scrollView.pagingEnabled = true
		self.view.addSubview(self.scrollView)
		
		var haikuController = self.storyboard.instantiateViewControllerWithIdentifier("Write") as HaikuViewController
		var photoController = self.storyboard.instantiateViewControllerWithIdentifier("Photo") as PhotoViewController
		var shareController = self.storyboard.instantiateViewControllerWithIdentifier("Share") as ShareViewController
		
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
