//
//  CallOutController.swift
//  Enso
//
//  Created by Leonardo Lee on 8/13/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit


//var helpTimer : NSTimer!
//
//override func viewDidLoad() {
//	super.viewDidLoad()
//	
//	self.scrollView = UIScrollView(frame: self.view.frame)
//	makeMainScrollView()
//	//self.resetTimer()
//}
//
////	func resetTimer() {
////		if self.helpTimer != nil {
////			self.helpTimer.invalidate()
////		}
////
////		self.helpTimer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("showHelpMessageCallout"), userInfo: nil, repeats: true)
////	}
//
////	func showHelpMessageCallout() {
////		self.showCalloutWithMessage("Tap here to get started", inRect: CGRect(x: 50, y: 80, width: 120, height: 90))
////		self.helpTimer.invalidate()
////	}
//
//override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
//	
//	//self.resetTimer()
//	super.touchesBegan(touches, withEvent: event)
//}

//extension UIViewController {
//	
//	func showCalloutWithMessage(message: String, inRect frame: CGRect) {
//		let alertView = UIButton(frame: frame)
//		alertView.titleLabel.text = message
//		alertView.backgroundColor = UIColor.blackColor()
//		alertView.titleLabel.textColor = UIColor.whiteColor()
//		alertView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 350.0)
//		alertView.addTarget(self, action: Selector("removeButton:"), forControlEvents: UIControlEvents.TouchUpInside)
//		self.view.addSubview(alertView)
//		
//
//		UIView.animateWithDuration(0.4, animations: { () -> Void in
//			alertView.center = self.view.center
//		}) { (finished) -> Void in
//			println("finished")
//		}
//	}
//	
//	func removeButton(sender: UIButton) {
//		UIView.animateWithDuration(0.4, animations: { () -> Void in
//			sender.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 350.0)
//			}) { (finished) -> Void in
//				sender.removeFromSuperview()
//		}
//	}
//
//}

class CallOutController: NSObject {
	
}
