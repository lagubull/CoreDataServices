//
//  NSManagedObjectContext+CDSRetrieval.m
//  CoreDataServices
//
//  Created by William Boles on 08/01/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import "NSManagedObjectContext+CDSRetrieval.h"

#import "CDSServiceManager.h"
#import "NSFetchRequest+CDSFetchRequest.h"

@implementation NSManagedObjectContext (CDSRetrieval)

#pragma mark - MultipleRetrieval

- (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                                 predicate:(NSPredicate *)predicate
                           sortDescriptors:(NSArray *)sortDescriptors
                            fetchBatchSize:(NSUInteger)fetchBatchSize
                                fetchLimit:(NSUInteger)fetchLimit
{
    NSArray *entries = nil;
    
    NSString *entityName = NSStringFromClass(entityClass);
    
    if (entityName.length > 0)
    {
        NSFetchRequest *request = [NSFetchRequest cds_fetchRequestWithEntityClass:entityClass];
        
        if (predicate)
        {
            request.predicate = predicate;
        }
        
        if (sortDescriptors.count > 0)
        {
            request.sortDescriptors = sortDescriptors;
        }
        
        if (fetchBatchSize > 0)
        {
            request.fetchBatchSize = fetchBatchSize;
        }
        
        if (fetchLimit > 0)
        {
            request.fetchLimit = fetchLimit;
        }
        
        NSError *error = nil;
        
        @try
        {
            entries =  [self executeFetchRequest:request
                                           error:&error];
        }
        @catch (NSException *exception)
        {
            //CoreData doesn't give us nice logs on exceptions so we have to log it out manually here.
            NSLog(@"** COREDATA EXCEPTION ** : %@", [exception description]);
            abort();
        }
        
        if (error)
        {
            NSLog(@"Error attempting to retrieve entries from table %@, pred %@, sortDescriptors %@, managedObjectContext %@, userinfo: %@", entityName, predicate, sortDescriptors, self, [error userInfo]);
        }
    }
    
    return entries;
}

- (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
{
    return [self retrieveEntriesForEntityClass:entityClass
                                     predicate:nil
                               sortDescriptors:nil
                                fetchBatchSize:0];
}

- (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                            fetchBatchSize:(NSUInteger)fetchBatchSize
{
    return [self retrieveEntriesForEntityClass:entityClass
                                     predicate:nil
                               sortDescriptors:nil
                                fetchBatchSize:fetchBatchSize
                                    fetchLimit:0];
}

- (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                                 predicate:(NSPredicate *)predicate
{
    return [self retrieveEntriesForEntityClass:entityClass
                                     predicate:predicate
                               sortDescriptors:nil
                                fetchBatchSize:0
                                    fetchLimit:0];
}

- (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                                 predicate:(NSPredicate *)predicate
                            fetchBatchSize:(NSUInteger)fetchBatchSize
{
    return [self retrieveEntriesForEntityClass:entityClass
                                     predicate:predicate
                               sortDescriptors:nil
                                fetchBatchSize:fetchBatchSize
                                    fetchLimit:0];
}

- (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                           sortDescriptors:(NSArray *)sortDescriptors
{
    return [self retrieveEntriesForEntityClass:entityClass
                                     predicate:nil
                               sortDescriptors:sortDescriptors
                                fetchBatchSize:0
                                    fetchLimit:0];
}

- (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                           sortDescriptors:(NSArray *)sortDescriptors
                            fetchBatchSize:(NSUInteger)fetchBatchSize
{
    return [self retrieveEntriesForEntityClass:entityClass
                                     predicate:nil
                               sortDescriptors:sortDescriptors
                                fetchBatchSize:fetchBatchSize
                                    fetchLimit:0];
}

- (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                                 predicate:(NSPredicate *)predicate
                           sortDescriptors:(NSArray *)sortDescriptors
{
    return [self retrieveEntriesForEntityClass:entityClass
                                     predicate:predicate
                               sortDescriptors:sortDescriptors
                                fetchBatchSize:0
                                    fetchLimit:0];
}

- (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                                 predicate:(NSPredicate *)predicate
                           sortDescriptors:(NSArray *)sortDescriptors
                            fetchBatchSize:(NSUInteger)fetchBatchSize
{
    return [self retrieveEntriesForEntityClass:entityClass
                                     predicate:predicate
                               sortDescriptors:sortDescriptors
                                fetchBatchSize:fetchBatchSize
                                    fetchLimit:0];
}

#pragma mark - SingleRetrieval

- (id)retrieveFirstEntryForEntityClass:(Class)entityClass
                             predicate:(NSPredicate *)predicate
                       sortDescriptors:(NSArray *)sortDescriptors
{
    NSManagedObject *entry = nil;
    
    NSArray *entries = [self retrieveEntriesForEntityClass:entityClass
                                                 predicate:predicate
                                           sortDescriptors:sortDescriptors
                                            fetchBatchSize:0
                                                fetchLimit:1];
    
    
    if (entries.count > 0)
    {
        entry = entries[0];
    }
    
    return entry;
}

- (id)retrieveFirstEntryForEntityClass:(Class)entityClass
{
    return [self retrieveFirstEntryForEntityClass:entityClass
                                        predicate:nil
                                  sortDescriptors:nil];
}

- (id)retrieveFirstEntryForEntityClass:(Class)entityClass
                             predicate:(NSPredicate *)predicate
{
    return [self retrieveFirstEntryForEntityClass:entityClass
                                        predicate:predicate
                                  sortDescriptors:nil];
}

@end
