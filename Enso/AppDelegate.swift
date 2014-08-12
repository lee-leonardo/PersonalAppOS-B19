//
//  AppDelegate.swift
//  Enso
//
//  Created by Leonardo Lee on 8/11/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
	var window: UIWindow?
	var tabBarController = UITabBarController()


	func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
		
		var preferenceTab = PreferenceViewController()
		var haikuTab = HaikuViewController()
		var photoTab = PhotoViewController()
		
		var circle = UIImage(named: "Circle")
		var square = UIImage(named: "Square")
		var star = UIImage(named: "Star")
		
		var controllers = NSArray(objects: haikuTab, photoTab, preferenceTab)
		
		var tabBarButton1 = UITabBarItem(title: "Preferences", image: circle, tag: 0)
		var tabBarButton2 = UITabBarItem(title: "Haiku", image: square, tag: 1)
		var tabBarButton3 = UITabBarItem(title: "Photo", image: star, tag: 2)
		
		tabBarController.viewControllers = controllers
		
		
		
		window?.rootViewController = tabBarController
		
		return true
	}

	func applicationWillResignActive(application: UIApplication!) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(application: UIApplication!) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(application: UIApplication!) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(application: UIApplication!) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(application: UIApplication!) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

