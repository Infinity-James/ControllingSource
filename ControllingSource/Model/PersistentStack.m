//
//  PersistentStack.m
//  CoreDataToDo
//
//  Created by James Valaitis on 10/09/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#import "PersistentStack.h"

@import CoreData;

#pragma mark - Persistent Stack Private Class Extension

@interface PersistentStack () {}

#pragma mark - Private Properties

/**	An object to be used throughout the app to manage a collection of objects.	*/
@property (nonatomic, strong, readwrite)	NSManagedObjectContext	*managedObjectContext;
/**	The URL of the file used for the managed object model.	*/
@property (nonatomic, strong)				NSURL					*modelURL;
/**	The file location of the persistent store.	*/
@property (nonatomic, strong)				NSURL					*storeURL;

@end

#pragma mark - Persistent Stack Implementation

@implementation PersistentStack {}

#pragma mark - Initialisation

/**
 *	Initialised an instance of this persitent stack with the given URLS for the appropriate files.
 *
 *	@param	storeURL					The file location of the persistent store.
 *	@param	modelURL					The URL of the file used for the managed object model.
 *
 *	@return	An initialized object.
 */
- (instancetype)initWithStoreURL:(NSURL *)storeURL
					 andModelURL:(NSURL *)modelURL
{
	if (self = [super init])
	{
		self.modelURL						= modelURL;
		self.storeURL						= storeURL;
		[self managedObjectContext];
	}
	
	return self;
}

#pragma mark - Property Accessor Methods - Getters

/**
 *	An object to be used throughout the app to manage a collection of objects.
 *
 *	@return	An initialised and set up NSManagedObjectContext.
 */
- (NSManagedObjectContext *)managedObjectContext
{
	if (!_managedObjectContext)
	{
		_managedObjectContext								= [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		_managedObjectContext.persistentStoreCoordinator	= [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
		
		//	add a persistent store for the coordinator
		NSError *error;
		[_managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
																	   configuration:nil
																				 URL:self.storeURL
																			 options:nil
																			   error:&error];
		if (error)						NSLog(@"Error setting up NSManagedObjectContext: %@", error.localizedDescription);
		
		_managedObjectContext.undoManager					= [[NSUndoManager alloc] init];
	}
	
	return _managedObjectContext;
}

/**
 *	A model describing the schema; collection of entities used in the application.
 *
 *	@return	An initialised NSManagedObjectModel.
 */
- (NSManagedObjectModel *)managedObjectModel
{
	return [[NSManagedObjectModel alloc] initWithContentsOfURL:self.modelURL];
}

@end