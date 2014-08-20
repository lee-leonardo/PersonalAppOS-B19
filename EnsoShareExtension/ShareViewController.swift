//
//  ShareViewController.swift
//  EnsoShareExtension
//
//  Created by Leonardo Lee on 8/19/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
	
	var imageData = NSData()
	var haikuText : NSString = "Wow!"

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
		
		
		var message = self.contentText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) as NSString
		var messageLength = message.length
		
		var remainingCharacters = 100 - messageLength
		self.charactersRemaining = remainingCharacters
		
		if charactersRemaining >= 0 {
			return true
		}
		//return false
		
		
		
		
		
		
		
		
		self.charactersRemaining = haikuText.length
		
		if self.charactersRemaining > 140 || imageData == nil {
			return false
		}
		
        return true
    }
	
    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.

//		var inputItem = self.extensionContext.inputItems.first as NSExtensionItem
//		var outputItem = inputItem.copy() as NSExtensionItem
//		outputItem.attributedContentText = NSAttributedString(string: self.contentText)
//		var outputItems = [outputItem]
//		self.extensionContext.completeRequestReturningItems(outputItems, completionHandler: nil)
		
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
		
        self.extensionContext.completeRequestReturningItems(nil, completionHandler: nil)
    }

    override func configurationItems() -> [AnyObject]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return NSArray()
    }
	
	
	//Upload
	func performUpload() {
		
//		var configurationName = "com.shareSheet.enso.background-configuration"
//		var configuration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(configurationName)
//		var session = NSURLSession.sessionWithConfiguration(configuration, delegate: self, delegateQueue: <#NSOperationQueue!#>)
	}
	
}
