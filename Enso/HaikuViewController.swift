//
//  HaikuViewController.swift
//  Enso
//
//  Created by Leonardo Lee on 8/11/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit

protocol HaikuDelegate {
	func haikuTextChanged(haikuText : String)
}

class HaikuViewController: UIViewController, UITextViewDelegate {

	@IBOutlet weak var haikuTextView: UITextView!
	@IBOutlet weak var syllableCount: UILabel!
	var delegate : HaikuDelegate?
	
	
	
	func randomStartHaiku() -> String {
		var random = arc4random_uniform(10)
		return "The old pond:\na frog jumps in,\nthe sound of water"
	}
	
//MARK: View methods
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.view.backgroundColor = UIColor(hue: 0, saturation: 0.5, brightness: 1, alpha: 0.1)
		self.haikuTextView.backgroundColor = UIColor(hue: 0, saturation: 0.15, brightness: 0.7, alpha: 0.2)

		NSNotificationCenter.defaultCenter().addObserver(self, selector: "textViewChanged:", name: UITextViewTextDidChangeNotification, object: nil)
		
		
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		//println("Haiku View loaded")
		
		haikuTextView.text = randomStartHaiku()
		haikuTextView.resignFirstResponder()
    }
	override func viewWillDisappear(animated: Bool) {
		self.delegate!.haikuTextChanged(haikuTextView.text)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidChangeNotification, object: nil)
	}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
//MARK: UITextFieldDelegate
	func textFieldShouldReturn(textField: UITextField!) -> Bool {
		var haiku = Haiku(haiku: haikuTextView.text)
		//haiku function
		
		return true
	}

//MARK: Touch methods
	override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
		for control in self.view.subviews {
			if let individualControl = control as? UITextView {
				individualControl.resignFirstResponder()
			}
		}
	}
//MARK: TextViewDelegate	
	func textViewChanged(sender: AnyObject!) {
		self.delegate?.haikuTextChanged(haikuTextView.text)
	}
	
	
	
//MARK: Delay method
	//This'll provide functionality that will count the haiku's string values.
}
