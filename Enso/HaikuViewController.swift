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
    override func viewDidLoad() {
        super.viewDidLoad()
		//println("Haiku View loaded")
		
		haikuTextView.text = randomStartHaiku()
		haikuTextView.resignFirstResponder()
    }
	override func viewWillDisappear(animated: Bool) {
		self.parentViewController

		
//		haikuTextView.text
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
//MARK: TextFieldDelegate
	func textViewDidBeginEditing(textView: UITextView!) {
		println("Did begin editing")
	}
	func textViewDidEndEditing(textView: UITextView!) {
		println("Text View did End editing")
		self.delegate!.haikuTextChanged(haikuTextView.text)
	}
	
//MARK: Delay method
	//This'll provide functionality that will count the haiku's string values.
}
