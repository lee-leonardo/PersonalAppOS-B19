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
	
//MARK:
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
		randomStartHaiku()
		self.delegate?.haikuTextChanged(haikuTextView.text)
		
    }
	override func viewWillDisappear(animated: Bool) {
		self.delegate!.haikuTextChanged(haikuTextView.text)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidChangeNotification, object: nil)
	}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
//MARK: Touch methods
	override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
		for control in self.view.subviews {
			if let individualControl = control as? UITextView {
				individualControl.resignFirstResponder()
			}
		}
	}
	
//MARK:
//MARK: HaikuController methods
	func randomStartHaiku() {
		var random = arc4random_uniform(10)
		var randomHaiku : String
		
		switch random {
		case 0:
			randomHaiku = "The old pond:\na frog jumps in,\nthe sound of water"
		case 1:
			randomHaiku = "In nooks and corners\nCold remains:\nFlowers of the plum"
		case 2:
			randomHaiku = "Everything I touch\nwith tenderness, alas,\npricks like a bramble."
		case 3:
			randomHaiku = "O snail\nClimb Mount Fuji,\nBut slowly, slowly!"
		case 4:
			randomHaiku = "Not quite dark yet\nand the stars shining\nabove the withered fields."
		case 5:
			randomHaiku = "Listening to the moon,\ngazing at the croaking of frogs\nin a field of ripe rice."
		case 6:
			randomHaiku = "A kite floats\nAt the place in the sky\nWhere it floated yesterday."
		case 7:
			randomHaiku = "Morning haze:\nas in a painting of a dream,\nmen go their ways."
		case 8:
			randomHaiku = "A painting for sale -\nA swallow lets fall a dropping,\nAs it flies away."
		case 9:
			randomHaiku = "That snail --\nOne long horn, one short,\nWhat's on his mind?"
		default:
			randomHaiku = "The winter moon:\nA temple without a gate,-\nHow high the sky!"
		}
		
		self.haikuTextView.text = randomHaiku
		haikuTextView.resignFirstResponder()
	}
	
//MARK:
//MARK: UITextFieldDelegate
	func textFieldShouldReturn(textField: UITextField!) -> Bool {
		var haiku = Haiku(haiku: haikuTextView.text)
		//haiku function
		
		return true
	}

//MARK:
//MARK: Target-Action
	func textViewChanged(sender: AnyObject!) {
		self.delegate?.haikuTextChanged(haikuTextView.text)
	}
}
