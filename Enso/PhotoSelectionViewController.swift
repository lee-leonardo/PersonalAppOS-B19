//
//  PhotoSelectionViewController.swift
//  Enso
//
//  Created by Leonardo Lee on 8/14/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit
import Photos

class PhotoSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

	@IBOutlet weak var photoSelectionTableView: UICollectionView!
	
	var fetchResults : PHFetchResult!
	var photoManager : PHCachingImageManager!

//MARK:
//MARK: View methods
    override func viewDidLoad() {
        super.viewDidLoad()
		self.photoManager = PHCachingImageManager()
		
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
//MARK:
//MARK: UICollectionView
	func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
		var cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as PhotoLibraryCell
//		cell.photoLibraryImage.image
		cell.backgroundColor = UIColor.blueColor()
		
		return cell
	}
	
	func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
		return self.fetchResults.count
	}
	
	func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
		
		var sendingAsset = NSDictionary(object: fetchResults[indexPath.item], forKey: "asset")
		
		self.dismissViewControllerAnimated(true, completion: { () -> Void in
			//NSNotificationCenter.defaultCenter().postNotificationName("PHAssetRequest", object: self, userInfo: sendingAsset)

		})
	}
	
}
