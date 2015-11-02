//
//  CoreDataManager.m
//  Pods
//
//  Created by Prabodh Prakash on 21/08/15.
//
//

#import "CoreDataManager.h"
#import "CoreDataException.h"


@interface CoreDataManager()

@property (nonatomic, strong) NSMutableDictionary* keyToCoreDatabaseMapper;

@end

@implementation CoreDataManager

+ (id)sharedManager
{
    static CoreDataManager *sharedCoreDataManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCoreDataManager = [[self alloc] init];
        [sharedCoreDataManager keyToCoreDatabaseMapper];
    });
    
    return sharedCoreDataManager;
}

- (id) init
{
    self = [super init];
    
    return self;
}

- (NSMutableDictionary *)keyToCoreDatabaseMapper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _keyToCoreDatabaseMapper = [NSMutableDictionary new];
    });
    
    return _keyToCoreDatabaseMapper;
}

- (void) setupCoreDataWithKey:(NSString*) key storeURL:(NSURL *)storeURL objectModelIdentifier:(NSString *)objectModelIdentifier
{
    if ([_keyToCoreDatabaseMapper objectForKey:key] != nil)
    {
        NSString* exceptionReason = [NSString stringWithFormat:@"Database for key : %@ already exist", key];
        @throw [[CoreDataException alloc] initWithReason:exceptionReason];
    }
    
    CoreDatabaseInterface* coreDatabaseInterface = [[CoreDatabaseInterface alloc] initWithStoreURL:storeURL objectModelIdentifier:objectModelIdentifier];
    
    [_keyToCoreDatabaseMapper setValue:coreDatabaseInterface forKey:key];
}

- (CoreDatabaseInterface*) getCoreDataInterfaceForKey: (NSString*) key
{
    if ([_keyToCoreDatabaseMapper objectForKey:key] != nil)
    {
        return [_keyToCoreDatabaseMapper objectForKey:key];
    }
    
    NSString* exceptionReason = [NSString stringWithFormat:@"Database for key : %@ not initialized", key];
    @throw [[CoreDataException alloc] initWithReason:exceptionReason];
}

@end