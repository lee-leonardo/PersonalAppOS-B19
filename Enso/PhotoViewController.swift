//
//  PhotoViewController.swift
//  Enso
//
//  Created by Leonardo Lee on 8/11/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit
import Photos

class PhotoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	
	
	@IBOutlet weak var selectedImageView: UIImageView!
	@IBOutlet weak var filterPickerView: UIPickerView!
	var photoPicker = UIImagePickerController()
	var selectedImage : UIImage?
	
	
	@IBAction func selectPhoto(sender: AnyObject) {
		println("Long pressed")
		
		self.checkAuthentication({ (status) -> Void in
			if status == PHAuthorizationStatus.Authorized {
				NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
					self.presentViewController(self.photoPicker, animated: true, completion: nil)
				})
			}
		})
	}
	
//MARK: View methods
    override func viewDidLoad() {
        super.viewDidLoad()
		//println("Photo controller loaded.")
		self.selectedImageView.layer.borderWidth = 1.0
		self.selectedImageView.layer.borderColor = UIColor.lightGrayColor().CGColor
		self.selectedImageView.layer.cornerRadius = self.selectedImageView.frame.width * 0.25
		self.selectedImageView.layer.masksToBounds = true
		
		self.photoPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
		self.photoPicker.allowsEditing = true
		self.photoPicker.delegate = self
		
    }
	override func viewWillAppear(animated: Bool) {
		if selectedImage != nil {
			println("Image exists!")
			self.selectedImageView.image = selectedImage
		}
	}
	
//MARK: UIPickerViewDelegate
	func pickerView(pickerView: UIPickerView!, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString! {
		
		if row == 0 {
			if component == 0 {
				return NSAttributedString(string: "Filters")
			}
//			if component == 1 {
//				return NSAttributedString(string: "Intensity")
//			}
//			if component == 2 {
//				return NSAttributedString(string: "Value")
//			}
		}

//		if component == 2 {
//			return NSAttributedString(string: String(row))
//		}
//		
//		if row % 5 == 0 {
//			return NSAttributedString(string: "End")
//		}
//
//		if row % 2 == 0 {
//			return NSAttributedString(string: "Awesome")
//		}
		
		
		return NSAttributedString(string: "String")
	}
	func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
		return "test"
	}
	
//MARK: UIPickerViewDataSource
	func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
//		return 3
		return 1
	}
	func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
		return 11
	}
	
//MARK: PHPhotoLibrary
	func checkAuthentication(completionHandler: (PHAuthorizationStatus) -> Void) -> Void {
		switch PHPhotoLibrary.authorizationStatus() {
		case .NotDetermined:
			PHPhotoLibrary.requestAuthorization({
				(status: PHAuthorizationStatus) -> Void in
				completionHandler(status)
			})
		default:
			completionHandler(PHPhotoLibrary.authorizationStatus())
		}
	}
	
//MARK: UIImagePickerController
	func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
		var returnedImage = info[UIImagePickerControllerEditedImage] as UIImage
		self.selectedImage = returnedImage
		self.dismissViewControllerAnimated(true, completion: {
			() -> Void in
			
			//Add PhotoController awesomeness in here.
			NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
				self.selectedImageView.image = self.selectedImage
			})
		})
	}
	
//MARK: View methods
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
		//println("This is a photo view disappearing!")
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
//MARK: Touch methods
	override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
		super.touchesBegan(touches, withEvent: event)
		
		if touches.count >= 1 {
			println("At least 1 touch!")
		}
	}
	
//MARK: UIGestureRecognizer
//	func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer!) -> Bool {
//		super.touchesBegan(<#touches: NSSet!#>, withEvent: <#UIEvent!#>)
//		gestureRecognizer.numberOfTouches()
//	}
}
