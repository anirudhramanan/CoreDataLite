//
//  CoreDatabaseInterface.h
//  Pods
//
//  Created by Prabodh Prakash on 21/08/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/*!
 This class provides boilderplate code for operations on Core Data.
 This class holds all information related to a database initialised with a schema.
 It can be used to get managed object context, persistent store coordinator and managed object model. It 
 also provides serial and concurrent queue that can used to perform operations on database.
 */
@interface CoreDatabaseInterface : NSObject

/*!
 @param storeURL instance of NSURL at which store is present
 
 @param objectModel location of momd file against the store URL. This param does not expect "momd" as extension
 @param options     options to be used for setup. For more info refer 'Store Options' and 'Migration Options' at
                    https://developer.apple.com/library/ios/documentation/Cocoa/Reference/CoreDataFramework/Classes/NSPersistentStoreCoordinator_Class/index.html#//apple_ref/doc/constant_group/Migration_Options
 
 @retun the newly initialized CoreDatabaseInterface object
 */
- (instancetype) initWithStoreURL: (NSURL*) storeURL objectModelIdentifier: (NSString*) objectModelIdentifier options:(NSDictionary *)options;

/*!
 @return MOC working on private thread
 */
- (NSManagedObjectContext*) getPrivateQueueManagedObjectContext;

/*!
 @return Persistent Store Coordinator associated with main managedObjectContext
 */
- (NSPersistentStoreCoordinator*) getMainPersistentStoreCoordinator;

/*!
 @return Persistent Store Coordinator associated with private queue ManagedObjectContext
 */
- (NSPersistentStoreCoordinator*) getPrivateQueuePersistentStoreCoordinator;

/*!
 @return serial dispatch_queue_t
 */
- (dispatch_queue_t) getSerialQueue;

/*!
 @return concurrent dispatch_queue_t
 */
- (dispatch_queue_t) getConcurrentQueue;

@end
