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
	var imageFetchResult : PHFetchResult!
	var photoManager = PHCachingImageManager()
	var requestedImage : CIImage?
	var context = CIContext(options: nil)
	
	let filterLabels = ["Sepia Tone", "Vibrance", "Photo Effect Noir"]//, "Monet", "Seurat"]
	let defaultFilters = ["Sepia Tone":"CISepiaTone", "Vibrance":"CIVibrance", "Photo Effect Noir":"CIPhotoEffectNoir"]
	let filterLibrary: Dictionary<String, CIFilter>?

//	var photoFilter : CIFilter?

	
//MARK:
//MARK: Init
	init(){
		self.imageFetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
		self.cacheFilters()
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "assetSelected:", name: "PHAssetRequest", object: nil)
	}
	deinit {
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "PHAssetRequest", object: nil)
	}
	
//MARK:
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
	
	func modifyPHAsset(filter name: String, withSize: CGSize) {
		var options = PHContentEditingInputRequestOptions()
		options.canHandleAdjustmentData = {
			(optionData: PHAdjustmentData!) -> Bool in
			
			return optionData.formatIdentifier == self.ensoFormatIdentifier && optionData.formatVersion == self.ensoFormatVersion
		}

		
		self.asset!.requestContentEditingInputWithOptions(options, completionHandler: {
			(contentEditingInput: PHContentEditingInput!, info: [NSObject : AnyObject]!) -> Void in
			
			var imageURL = contentEditingInput.fullSizeImageURL
			var imageOrientation = contentEditingInput.fullSizeImageOrientation
			var inputImage = CIImage(contentsOfURL: imageURL)
			inputImage.imageByApplyingOrientation(imageOrientation)
			
			
			
			
			
			//Edit for filter!
			var filter = self.applyFilter(filter: name, image: inputImage)
			
			
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
	
//MARK:
//MARK: Apply Filter
	func cacheFilters() {
		
	}
	func temporaryFilter(name: String, image: CIImage) -> CIFilter {
		println("This should fire")
		
		var filterName = defaultFilters[name]
		
		var filter = CIFilter(name: filterName, withInputParameters: [ kCIInputImageKey : image ])
		filter.setDefaults()
		
		return filter			

	}
	func applyFilter(filter name: String, image: CIImage ) -> CIFilter {
		
		println("This should fire")
		
		
		
		if name == "Sepia Tone" || name == "Vibrance" || name == "Photo Effect Noir" {
			var filterName = defaultFilters[name]
			
			var filter = CIFilter(name: filterName)
			filter.setDefaults()
			
			
		} else {
			if name == "Monet" {
				
				// set input image and parameters
				var blurFilter = CIFilter(name: "CIGaussianBlur", withInputParameters: [kCIInputImageKey : image, kCIInputRadiusKey : 3.0 ])
				var glassDistortionFilter = CIFilter(name: "CIGlassDistortion", withInputParameters: [ kCIInputImageKey : blurFilter.outputImage, kCIInputScaleKey : 40.0 ])
				var sharpenLuminance = CIFilter(name: "CISharpenLuminance", withInputParameters: [ kCIInputImageKey : glassDistortionFilter.outputImage ])
				var median = CIFilter(name: "CIMedianFilter", withInputParameters: [ kCIInputImageKey : sharpenLuminance.outputImage ])
				var colorMatrix = CIFilter(name: "CIColorMatrix", withInputParameters: [ kCIInputImageKey : median.outputImage ])
				//Lacks colomatrix info
				//inputRVector = [1, 0.2, 0, 0]
				//inputGVectore = [0, 1, 0.1, 0]
				//inputBVector = [0.05, 0, 1, 0] 
				//inputAVector = [0, 0, 0, 1]
				//inputBiasVector = [0 0 0 0]
				
				
				return colorMatrix
				
			} else if name == "Seurat" {
				
				var colorMatrix = CIFilter(name: "CIColorMatrix", withInputParameters: [ kCIInputImageKey : image])
				//Lacks colomatrix info
				//inputRVector = [1.2, 0.2, 0, 0]
				//inputGVector = [0.3, 0.8, 0.4, 0]
				//inputBVector = [0, 0.09, 1.2, 0]
				//inputAVector = [0, 0, 0, 1]
				//inputBiasVector = [0.22, 0, 0.05, 0]
				var pointillize = CIFilter(name: "CIPointillize", withInputParameters: [ kCIInputImageKey : colorMatrix.outputImage, kCIInputRadiusKey : 2.0 ])
				var motionBlur = CIFilter(name: "CIMotionBlur", withInputParameters: [ kCIInputImageKey : pointillize.outputImage, kCIInputRadiusKey : 1.0, kCIInputAngleKey : -81.6])
				var median1 = CIFilter(name: "CIMedianFilter", withInputParameters: [ kCIInputImageKey : motionBlur.outputImage])
				var median2 = CIFilter(name: "CIMedianFilter", withInputParameters: [ kCIInputImageKey : median1.outputImage ])

				
				return median2
				
				
			}
			
		}
		return CIFilter()
	}
	
//MARK:
//MARK: Target-Action
	func assetSelected(sender: AnyObject!) {
		println("Observer received!")
		if let notification = sender as? NSNotification {
			println("Notification succeeded!")

			if let assetDict = notification.userInfo as? Dictionary<String, PHAsset> {
				println("User Info success!")
				
				if let assetReceived = assetDict["asset"] {
					println("Asset has successfully been retrieved!")
					
					self.asset = assetReceived
					NSNotificationCenter.defaultCenter().postNotificationName("AssetRequestFinished", object: self)
				}
			}
		}
	}
}
