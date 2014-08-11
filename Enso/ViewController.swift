//
//  ViewController.swift
//  Enso
//
//  Created by Leonardo Lee on 8/11/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {
	
//Variables?
	//PHAsset
	//

	
//MARK: UIPageViewController - Variables
	var pageViewController = UIPageViewController()
	var preferenceController = PreferenceViewController()
	var haikuController = HaikuViewController()
	var photoController = PhotoViewController()
	
	var pages: [UIViewController] {
		return [preferenceController, haikuController, photoController]
	}
	
//	enum PageControllerIndex {
//		case preference = 0, haiku, photo
//	}
	
	func viewControllerAtIndex(index: Int) -> UIViewController! {
		if self.pages.count == 0 || index >= self.pages.count {
			return nil
		}
		
		var pageViewController = self.storyboard.instantiateInitialViewController().pages[index]
		
		return pageViewController
	}
	
	
//MARK: UIPageViewController - DataSource
	func pageViewController(pageViewController: UIPageViewController!, viewControllerBeforeViewController viewController: UIViewController!) -> UIViewController! {
		
		var presentedController = viewController as BasePageViewController
		var index = presentedController.pageIndex
		
		if index == 0 || index == nil {
			return nil
		}
		
		index = index! - 1
		return viewControllerAtIndex(index!)
		
	}
	func pageViewController(pageViewController: UIPageViewController!, viewControllerAfterViewController viewController: UIViewController!) -> UIViewController! {
		
		var presentedController = viewController as BasePageViewController
		var index = presentedController.pageIndex
		
		if index == nil {
			return nil
		}
		index = index! + 1
		
		if index == self.pages.count {
			return nil
		}
		
		return viewControllerAtIndex(index!)
		
	}
	func presentationCountForPageViewController(pageViewController: UIPageViewController!) -> Int {
		return self.pages.count
	}
	func presentationIndexForPageViewController(pageViewController: UIPageViewController!) -> Int {
		return 1
	}
	
//MARK: View methods
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.pageViewController = self.storyboard.instantiateViewControllerWithIdentifier("PageViewController") as UIPageViewController
		self.pageViewController.dataSource = self
		
		var startingViewController = self.viewControllerAtIndex(1) as HaikuViewController
		var viewControllers = [startingViewController] as NSArray
		self.pageViewController.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
		
		self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30)
		self.addChildViewController(pageViewController)
		self.view.addSubview(pageViewController.view)
		self.pageViewController.didMoveToParentViewController(self)
		
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}


}

