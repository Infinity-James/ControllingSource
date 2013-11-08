//
//  AppDelegate.m
//  ControllingSource
//
//  Created by James Valaitis on 08/11/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "MasterViewController.h"
#import "PersistentStack.h"
#import "Store.h"

#pragma mark - App Delegate Private Class Extension

@interface AppDelegate () {}

#pragma mark - Private Properties

/**	A global version of the persistent stack.	*/
@property (nonatomic, strong)	PersistentStack		*persistentStack;
/**	Store for the data.	*/
@property (nonatomic, strong)	Store				*store;

@end

#pragma mark - App Delegate Implementation

@implementation AppDelegate

#pragma mark - Property Accessor Methods - Getters

/**
 *	The URL for the data model.
 *
 *	@return	A URL pointing to the data model.
 */
- (NSURL *)modelURL
{
	return [[NSBundle mainBundle] URLForResource:@"ControllingSource" withExtension:@"momd"];
}

/**
 *	The URL for the data model.
 *
 *	@return	A URL pointing to the data model.
 */
- (NSURL *)storeURL
{
	static NSURL *documentsDirectory;
	
	if (documentsDirectory)
		documentsDirectory				= [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
																	   inDomain:NSUserDomainMask
															  appropriateForURL:nil
																		 create:YES
																		  error:NULL];
	
	return [documentsDirectory URLByAppendingPathComponent:@"db.sqlite"];
}

#pragma mark - UIApplicationDelegate Methods

/**
 *	Tells the delegate that the launch process is almost done and the app is almost ready to run.
 *
 *	@param	application					The delegating application object.
 *	@param	launchOptions				A dictionary indicating the reason the application was launched (if any).
 *
 *	@return	NO if the application cannot handle the URL resource, otherwise return YES.
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window							= [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor			= [UIColor whiteColor];
	
	//	initialise and add the view controller
	DetailViewController *detailVC		= [[DetailViewController alloc] init];
	MasterViewController *masterVC		= [[MasterViewController alloc] init];
	UISplitViewController *splitVC		= [[UISplitViewController alloc] init];
	splitVC.viewControllers				= @[masterVC, detailVC];
	self.window.rootViewController		= splitVC;
	
	//	sort out core data
	self.persistentStack				= [[PersistentStack alloc] initWithStoreURL:self.storeURL andModelURL:self.modelURL];
	self.store							= [[Store alloc] init];
	self.store.managedObjectContext		= self.persistentStack.managedObjectContext;
	
	//	allow undo
	application.applicationSupportsShakeToEdit	= YES;
	
	[self.window makeKeyAndVisible];
	
    return YES;
}

/**
 *	Tells the delegate that the application is now in the background.
 *
 *	@param	application					The singleton application instance.
 */
- (void)applicationDidEnterBackground:(UIApplication*)application
{
	[self.store.managedObjectContext save:NULL];
}

@end