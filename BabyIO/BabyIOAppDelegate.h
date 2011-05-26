//
//  BabyIOAppDelegate.h
//  BabyIO
//
//  Created by Andrew Hunzeker on 5/22/11.
//  Copyright 2011 Andrew HunzekerHesed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BabyIOViewController.h"

@interface BabyIOAppDelegate : NSObject <UIApplicationDelegate> {
   UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
