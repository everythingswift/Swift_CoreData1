//
//  AppDelegate.swift
//  SwiftCD
//
//  Created by Sridhar Sanapala on 7/29/16.
//  Copyright © 2016 everythingswift. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var _managedObjectContext:NSManagedObjectContext?
//    var _managedObjectModel:NSManagedObjectModel?
//    var _persistentStoreCoordinator:NSPersistentStoreCoordinator?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        initializeCoreDataModel()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //MARK: Core Data Methods
    
    func initializeCoreDataModel(){
    // This resource is the same name as your xcdatamodeld contained in your project.
        guard let modelURL = NSBundle.mainBundle().URLForResource("SchoolModel", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
    
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        _managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        _managedObjectContext!.persistentStoreCoordinator = psc
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            let docURL = urls[urls.endIndex-1]
            /* The directory the application uses to store the Core Data store file.
             This code uses a file named "DataModel.sqlite" in the application's documents directory.
             */
            let storeURL = docURL.URLByAppendingPathComponent("SwiftCD.sqlite")
            do {
                try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
                } catch {
                        fatalError("Error migrating store: \(error)")
                }
        }
    }

//    func managedObjectContext() -> NSManagedObjectContext?{
//        if let mob = _managedObjectContext{
//            return mob
//        }
//        let coordinator = _persistentStoreCoordinator
//        
//        if coordinator != nil
//        {
//            _managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
//            _managedObjectContext?.persistentStoreCoordinator = coordinator
//            return _managedObjectContext
//        }
//        return nil
//    }
//    
//    // Returns the managed object model for the application.
//    // If the model doesn't already exist, it is created from the application's model.
//    func managedObjectModel() -> NSManagedObjectModel{
//        let modelURL = NSBundle.mainBundle().URLForResource("SchoolModel", withExtension: "momd")
//        return NSManagedObjectModel(contentsOfURL: modelURL!)!
//    }
//    
//    // Returns the persistent store coordinator for the application.
//    // If the coordinator doesn't already exist, it is created and the application's store added to it.
//    func persistentStoreCoordinator() -> NSPersistentStoreCoordinator{
//        
//        _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: _managedObjectModel!)
//        
//        let storeURL = self.applicationDocumentsDirectory().URLByAppendingPathComponent("SwiftCD.sqlite")
//        
//        do{
//            try _persistentStoreCoordinator?.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
//        }catch{
//            fatalError("Failed to initialize FetchedResultsController: \(error)")
//        }
//        
//        return _persistentStoreCoordinator!
//    }
//    
//    func saveContext() {
//        if let moc = self.managedObjectContext()
//        {
//            if moc.hasChanges == true{
//                do{
//                    try moc.save()
//                }catch{
//                    
//                }
//            }
//            
//        }
//    }
//    
//    //    MARK: Application's Documents directory
//    // Returns the URL to the application's Documents directory.
//    func applicationDocumentsDirectory() -> NSURL{
//        return NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains:NSSearchPathDomainMask.UserDomainMask).last! as NSURL
//    }

}

