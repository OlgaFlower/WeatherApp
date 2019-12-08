//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Admin on 05.11.2019.
//  Copyright © 2019 Flower. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
 
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
    
        let container = NSPersistentContainer(name: "WeatherData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
       
                fatalError("\(Errors.unresolvedError) \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)) //SQL DB path

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {

                let nserror = error as NSError
                fatalError("\(Errors.unresolvedError) \(nserror), \(nserror.userInfo)")
            }
        }
    }


}

