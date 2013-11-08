//
//  PersistentStack.h
//  CoreDataToDo
//
//  Created by James Valaitis on 10/09/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#pragma mark - Persistent Stack Public Interface

@interface PersistentStack : NSObject {}

#pragma mark - Public Properties

/**	An object to be used throughout the app to manage a collection of objects.	*/
@property (nonatomic, strong, readonly)	NSManagedObjectContext	*managedObjectContext;

#pragma mark - Public Methods

/**
 *	Initialised an instance of this persitent stack with the given URLS for the appropriate files.
 *
 *	@param	storeURL					The file location of the persistent store.
 *	@param	modelURL					The URL of the file used for the managed object model.
 *
 *	@return	An initialized object.
 */
- (instancetype)initWithStoreURL:(NSURL *)storeURL
					 andModelURL:(NSURL *)modelURL;

@end