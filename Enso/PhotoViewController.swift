//
//  PhotoViewController.swift
//  Enso
//
//  Created by Leonardo Lee on 8/11/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
	
	
	@IBOutlet weak var selectedImageView: UIImageView!

	@IBOutlet weak var filterPickerView: UIPickerView!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		//println("Photo controller loaded.")
		
    }
	
//MARK: UIPickerViewDelegate
	func pickerView(pickerView: UIPickerView!, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString! {
		
		if row == 0 {
			if component == 0 {
				return NSAttributedString(string: "Filter")
			}
			if component == 1 {
				return NSAttributedString(string: "Intensity")
			}
			if component == 2 {
				return NSAttributedString(string: "Value")
			}
		}

		if component == 2 {
			return NSAttributedString(string: String(row))
		}
		
		if row % 5 == 0 {
			return NSAttributedString(string: "End")
		}

		if row % 2 == 0 {
			return NSAttributedString(string: "Awesome")
		}
		
		
		return NSAttributedString(string: "String")
	}
	
	func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
		return "test"
	}
	
	
//MARK: UIPickerViewDataSource
	func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
		return 3
	}
	func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
		return 11
	}

	
//MARK: View methods
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
		//println("This is a photo view disappearing!")
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
