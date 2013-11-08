//
//  Store.h
//  CoreDataToDo
//
//  Created by James Valaitis on 10/09/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

@import CoreData;

@class Item;

#pragma mark - Store Public Interface

@interface Store : NSObject {}

#pragma mark - Public Properties

/**	The managed object context used throughout the app to manage objects.	*/
@property (nonatomic, strong)	NSManagedObjectContext	*managedObjectContext;

#pragma mark - Public Methods

@end