//
//  PhotoSelectionViewController.swift
//  Enso
//
//  Created by Leonardo Lee on 8/14/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit
import Photos

protocol PhotoSelectionDelegate {
	func photoSelected(asset: PHAsset)
}

class PhotoSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

	@IBOutlet weak var photoSelectionTableView: UICollectionView!
	
	var fetchResults : PHFetchResult!
	var photoManager : PHCachingImageManager!

	var delegate : PhotoSelectionDelegate?
	
	
//MARK: View methods
    override func viewDidLoad() {
        super.viewDidLoad()
		self.photoManager = PHCachingImageManager()
		
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
//MARK: UICollectionView
	func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
		var cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as UICollectionViewCell
		cell.backgroundColor = UIColor.blueColor()
		
		return cell
	}
	
	func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
	
	func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
//		NSNotificationCenter.defaultCenter().postNotificationName("selectedPhoto", object: self, userInfo: NSDictionary(object: fetchResults[indexPath.item], forKey: "selectedPhoto"))
		
		var sendingAsset = NSDictionary(object: fetchResults[indexPath.item], forKey: "asset")
		
//		NSNotificationCenter.defaultCenter().postNotificationName(<#aName: String!#>, object: self, userInfo: <#[NSObject : AnyObject]!#>)
		
		self.dismissViewControllerAnimated(true, completion: { () -> Void in
			
		})
	}
	
}
