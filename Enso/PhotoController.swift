//
//  PhotoController.swift
//  Enso
//
//  Created by Leonardo Lee on 8/12/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit
import Photos

class PhotoController {
	
	let ensoFormatIdentifier = "com.ensoApp.cf" //This'll need to change.
	let ensoFormatVersion = "0.1"
	
	var asset : PHAsset?
	var fetchResult : PHFetchResult?
	var photoManager = PHCachingImageManager()
	var requestedImage : CIImage?
	
	let filterLabels = ["Sepia", "Vibrance", "Noir"]
	let filterLibrary = ["Sepia":"CISepiaTone", "Vibrance":"", "Noir":""]
	
	init (){}
	
	func requestPHAsset(frameWidth : CGFloat, frameHeight : CGFloat) {
		
		self.photoManager.requestImageForAsset(asset, targetSize: CGSize(width: frameWidth, height: frameHeight), contentMode: PHImageContentMode.AspectFill, options: nil) {
			(image: UIImage!, [NSObject : AnyObject]!) -> Void in
			NSOperationQueue.mainQueue().addOperationWithBlock({
				() -> Void in
				self.requestedImage = CIImage(image: image)

			})
		}
	}
	
	func modifyPHAsset() {
		var options = PHContentEditingInputRequestOptions()
		options.canHandleAdjustmentData = {
			(optionData: PHAdjustmentData!) -> Bool in
			
			return optionData.formatIdentifier == self.ensoFormatIdentifier && optionData.formatVersion == self.ensoFormatVersion
		}

//Here! is where the filter needs to be!
		var filterExample = CIFilter(name: "CISepiaTone")
		
		self.asset!.requestContentEditingInputWithOptions(options, completionHandler: {
			(contentEditingInput: PHContentEditingInput!, info: [NSObject : AnyObject]!) -> Void in
			var imageURL = contentEditingInput.fullSizeImageURL
			var imageOrientation = contentEditingInput.fullSizeImageOrientation
			
			var inputImage = CIImage(contentsOfURL: imageURL)
			inputImage.imageByApplyingOrientation(imageOrientation)
			
			
		})
		
	}
	
}