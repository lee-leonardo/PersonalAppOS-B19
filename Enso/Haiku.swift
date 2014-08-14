//
//  Haiku.swift
//  Enso
//
//  Created by Leonardo Lee on 8/11/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit

class Haiku : NSObject {
	var lines : String
	var photo : UIImage?
	
	init(haiku text: String) {
		self.lines = text
	}
	
	//Algorithm used here is attributed to Franklin Mark Liang of Stanford University
	func countSyllables() -> Int {
		return 0
	}
}