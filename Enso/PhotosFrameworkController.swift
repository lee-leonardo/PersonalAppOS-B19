//
//  PhotoController.swift
//  Enso
//
//  Created by Leonardo Lee on 8/12/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit
import Photos

class PhotosFrameworkController {
	
	let ensoFormatIdentifier = "com.ensoApp.cf" //This'll need to change.
	let ensoFormatVersion = "0.1"
	
	var asset : PHAsset?
	var fetchResult : PHFetchResult!
	var photoManager = PHCachingImageManager()
	var requestedImage : CIImage?
	var context = CIContext(options: nil)
	
	let filterLabels = ["Sepia", "Vibrance", "Noir", "Neon", "Monet", "Seurat"]
	let filterLibrary = ["Sepia":"CISepiaTone", "Vibrance":"", "Noir":""]
	
	init (){
		self.fetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
	}

//MARK: PHAsset Fetch requests
	func requestPHAsset(frameWidth : CGFloat, frameHeight : CGFloat) {
		self.photoManager.requestImageForAsset(asset, targetSize: CGSize(width: frameWidth, height: frameHeight), contentMode: PHImageContentMode.AspectFill, options: nil) {
			(image: UIImage!, [NSObject : AnyObject]!) -> Void in
			NSOperationQueue.mainQueue().addOperationWithBlock({
				() -> Void in
				self.requestedImage = CIImage(image: image)

			})
		}
	}
	
	func modifyPHAsset(filter: String, withSize: CGSize) {
		var options = PHContentEditingInputRequestOptions()
		options.canHandleAdjustmentData = {
			(optionData: PHAdjustmentData!) -> Bool in
			
			return optionData.formatIdentifier == self.ensoFormatIdentifier && optionData.formatVersion == self.ensoFormatVersion
		}

		//Edit for filter!
		var filter = CIFilter(name: filterLibrary[filter])
		filter.setDefaults()

		
		self.asset!.requestContentEditingInputWithOptions(options, completionHandler: {
			(contentEditingInput: PHContentEditingInput!, info: [NSObject : AnyObject]!) -> Void in
			
			var imageURL = contentEditingInput.fullSizeImageURL
			var imageOrientation = contentEditingInput.fullSizeImageOrientation
			
			var inputImage = CIImage(contentsOfURL: imageURL)
			inputImage.imageByApplyingOrientation(imageOrientation)
			
			
			//Filter output stuff
			filter.setValue(inputImage, forKey: kCIInputImageKey)
			var outputImage = filter.outputImage
			
			//Finalizing
			let cgImage = self.context.createCGImage(outputImage, fromRect: outputImage.extent())
			let finishedImage = UIImage(CGImage: cgImage)
			var jpegData = UIImageJPEGRepresentation(finishedImage, 0.9)
			
			let filterInfo = NSDictionary(object: "CISepiaTone", forKey: "filter")
			let saveFilter = NSKeyedArchiver.archivedDataWithRootObject(filterInfo)
			let adjustmentData = PHAdjustmentData(formatIdentifier: self.ensoFormatIdentifier, formatVersion: self.ensoFormatVersion, data: saveFilter)
			
			var contentEditingOutput = PHContentEditingOutput(contentEditingInput: contentEditingInput)
			jpegData.writeToURL(contentEditingOutput.renderedContentURL, atomically: true)
			contentEditingOutput.adjustmentData = adjustmentData
			
			PHPhotoLibrary.sharedPhotoLibrary().performChanges({
				var request = PHAssetChangeRequest(forAsset: self.asset)
				request.contentEditingOutput = contentEditingOutput
				
			}, completionHandler: {
				(success: Bool, error: NSError!) -> Void in
				if !success {
					println("ImageFilterApp Error in PHPhotoLibrary.sharedPhotoLibrary().performChanges:\n\(error)")
				} else {
					var targetSize = CGSize(width: withSize.width, height: withSize.height)
					PHImageManager.defaultManager().requestImageForAsset(self.asset, targetSize: targetSize, contentMode: PHImageContentMode.AspectFill, options: nil, resultHandler: {
						(image: UIImage!, [NSObject : AnyObject]!) -> Void in
						//Send image to imageView
					})
					
				}
			})
		})
		
	}
	
//MARK: PHAuthorization
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
	
}