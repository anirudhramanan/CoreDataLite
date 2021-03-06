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


- (CoreDatabaseInterface *)setupCoreDataWithKey:(NSString *)mocIdentifier
                                       storeURL:(NSURL *)storeURL
                          objectModelIdentifier:(NSString *)objectModelIdentifier
{
    return [self setupCoreDataWithKey:mocIdentifier
                             storeURL:storeURL
                objectModelIdentifier:objectModelIdentifier
                              options:nil];
}


- (CoreDatabaseInterface*) setupCoreDataWithKey:(NSString*) mocIdentifier
                                       storeURL:(NSURL *)storeURL
                          objectModelIdentifier:(NSString *)objectModelIdentifier
                                        options:(NSDictionary *)options
{
    if (mocIdentifier == nil || [mocIdentifier length] <= 0)
    {
        return nil;
    }
    
    CoreDatabaseInterface* coreDatabaseInterface = nil;
    
    
    
    if ([_keyToCoreDatabaseMapper objectForKey:mocIdentifier] != nil)
    {
        coreDatabaseInterface = [_keyToCoreDatabaseMapper objectForKey:mocIdentifier];
    }
    else
    {
        @try
        {
            coreDatabaseInterface = [[CoreDatabaseInterface alloc] initWithStoreURL:storeURL
                                                              objectModelIdentifier:objectModelIdentifier
                                                                            options:options];
            
            [_keyToCoreDatabaseMapper setValue:coreDatabaseInterface forKey:mocIdentifier];
        }
        @catch (NSException *exception)
        {
            NSLog(@"%@", exception.description);
            //debugging statement here ()
        }
    }
    
    return coreDatabaseInterface;
}





- (CoreDatabaseInterface*) getCoreDataInterfaceForKey: (NSString*) key
{
    if ([_keyToCoreDatabaseMapper objectForKey:key] != nil)
    {
        return [_keyToCoreDatabaseMapper objectForKey:key];
    }
    
    return nil;
}

@end