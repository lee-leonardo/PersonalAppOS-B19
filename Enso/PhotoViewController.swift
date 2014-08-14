//
//  PhotoViewController.swift
//  Enso
//
//  Created by Leonardo Lee on 8/11/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit
import Photos

protocol PhotoDelegate {
	func photoSelected(selectedImage: UIImage)
}

class PhotoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	
	
	/*
	
	Make a collectionView, there's not something out of the box yet.
	
	CI Funhouse play around with it
	
	Checkout the sample code CIFunhouse for iPhone (iOS).
	
	Notification by full screen width. -> Content offset.
	
		Do the content offset make it relative.
		Navigation controller without a bar is a good idea.
	
	Timeout interval:
		Make a class for a call out controller.
		Give it class methods to show callout with m
	
	
	*/
	
	@IBOutlet weak var selectedImageView: UIImageView!
	@IBOutlet weak var filterPickerView: UIPickerView!
	var photoPicker = UIImagePickerController()
	var photoActionController = UIAlertController()
	var selectedImage : UIImage?
	var delegate : PhotoDelegate?
	var filters = ["Sepia Tone", "Faded Photo"]
	
//MARK: 
	func selectPhoto(sender: AnyObject) {
		//println("Long pressed")
		
		if let longPress = sender as? UILongPressGestureRecognizer {
			switch longPress.state {
			case UIGestureRecognizerState.Began:
				//println("began")
				if self.photoActionController.popoverPresentationController != nil {
					self.photoActionController.popoverPresentationController.sourceRect = CGRect(x: 0, y: self.selectedImageView.frame.height, width: 0, height: 0)
					self.photoActionController.popoverPresentationController.sourceView = self.selectedImageView
				}
				self.presentViewController(self.photoActionController, animated: true, completion: nil)
			case UIGestureRecognizerState.Ended:
				println("ended")
			default:
				println("something else=")
			}
		}
	}
	func buildActionSheet() -> UIAlertController {
		var chooseActionSheet = UIAlertController(title: "Get photo from", message: "Please choose a place to get a photo from", preferredStyle: UIAlertControllerStyle.ActionSheet)
		var selectPhoto = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default, handler: {
			(action: UIAlertAction!) -> Void in
			self.presentViewController(self.photoPicker, animated: true, completion: nil)
		})
		var cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
		chooseActionSheet.addAction(selectPhoto)
		chooseActionSheet.addAction(cancel)
		
		return chooseActionSheet
		
		
	}
	
//MARK: View methods
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.view.backgroundColor = UIColor(hue: 120 / 360 , saturation: 0.5, brightness: 1, alpha: 0.2)

		
		//println("Photo controller loaded.")
		self.selectedImageView.layer.borderWidth = 4.0
		self.selectedImageView.layer.borderColor = UIColor(hue: 120 / 360, saturation: 0.4, brightness: 0.8, alpha: 0.4).CGColor
		self.selectedImageView.layer.cornerRadius = self.selectedImageView.frame.width * (3.0/10.0)
		self.selectedImageView.layer.masksToBounds = true
		
		self.photoPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
		self.photoPicker.allowsEditing = true
		self.photoPicker.delegate = self
		
		var longPress = UILongPressGestureRecognizer(target: self, action: "selectPhoto:")
		//longPress.minimumPressDuration = 1.5
		selectedImageView.addGestureRecognizer(longPress)
		
		self.photoActionController = buildActionSheet()
		
		
    }
	override func viewWillAppear(animated: Bool) {
		if selectedImage != nil {
//			println("Image exists!")
			self.selectedImageView.image = selectedImage
		}
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "imageViewChanged:", name: "ImageSelectedNotification", object: nil)
		//println("Should've added self as an observer")

	}
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
		//println("This is a photo view disappearing!")
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "ImageSelectedNotification", object: nil)
	}
	
//MARK: UIPickerViewDelegate
	func pickerView(pickerView: UIPickerView!, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString! {
		
		if row == 0 {
			if component == 0 {
				return NSAttributedString(string: "Filters")
			}
		}
		if row != 0 {
			
		}
		
		return NSAttributedString(string: "String")
	}
	func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
		return "test"
	}
	
	func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
		println("selected filter: \(self.filters[row])")
	}
	
//MARK: UIPickerViewDataSource
	func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
//		return 3
		return 1
	}
	func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
		return self.filters.count
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
				println("Should shoot notification to main")
				NSNotificationCenter.defaultCenter().postNotificationName("ImageSelectedNotification", object: self.selectedImage)
//				self.delegate!.photoSelected(self.selectedImage!)
			})
		})
	}
	
//MARK: NSNotificationCenter
	func imageViewChanged(sender: AnyObject!) {
		//println("This works!")
		self.delegate?.photoSelected(selectedImage!)
	}
}
