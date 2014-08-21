//
//  DocumentPickerViewController.swift
//  EnsoDocumentProvider
//
//  Created by Leonardo Lee on 8/19/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit

class DocumentPickerViewController: UIDocumentPickerExtensionViewController {
	
	var ensoDPExtensionContext : NSExtensionContext?
	var inputItems : NSArray?
	
	override func loadView() {
		self.ensoDPExtensionContext = self.extensionContext
		self.inputItems = ensoDPExtensionContext?.inputItems
		
	}
	
    @IBAction func openDocument(sender: AnyObject?) {
        let documentURL = self.documentStorageURL.URLByAppendingPathComponent("Untitled.txt")
      
        // TODO: if you do not have a corresponding file provider, you must ensure that the URL returned here is backed by a file
		
        self.dismissGrantingAccessToURL(documentURL)
    }

    override func prepareForPresentationInMode(mode: UIDocumentPickerMode) {
        // TODO: present a view controller appropriate for picker mode here
    }

}
