//
//  AppDelegate.swift
//  SwiftyValidator
//
//  Created by Андрей Козлов on 07.07.2020.
//  Copyright © 2020 Андрей Козлов. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = ViewController()
		window?.makeKeyAndVisible()
		
		return true
	}



}

