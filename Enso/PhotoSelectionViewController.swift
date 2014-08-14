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
	
	
//MARK: View methods
    override func viewDidLoad() {
        super.viewDidLoad()

		
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
//MARK: UICollectionView
	func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
		var cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as UICollectionViewCell
		
		return cell
	}
	
	func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
	
}
