//
//  DataQuery.m
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

#import "DataQuery.h"

static NSManagedObjectContext *defaultContext;

@implementation DataQuery

+ (NSManagedObjectContext*)GetContext {
	NSManagedObjectContext *context;
	
	if (![NSThread isMainThread])
		context = [NSManagedObjectContext MR_context];
	else {
		if (defaultContext == nil)
			context = [NSManagedObjectContext MR_defaultContext];
		else
			context = defaultContext;
	}
	
	return context;
}

#pragma mark - Get

+ (NSInteger)GetItemCountFromEntity:(NSString*)entity {
	return [[NSClassFromString(entity) MR_numberOfEntities] integerValue];
}

+ (NSArray*)GetItemsFromEntity:(NSString*)entity {
	NSInteger currentCount = [self GetItemCountFromEntity:entity];

	if (currentCount > 0)
		return [NSClassFromString(entity) MR_findAll];
	else
		return [NSArray array];
}

+ (NSArray*)GetSortedItemsFromEntity:(NSString*)entity sortBy:(NSString*)sort ascending:(Boolean)asc {
	NSInteger currentCount = [self GetItemCountFromEntity:entity];

	if (currentCount > 0)
		return [NSClassFromString(entity) MR_findAllSortedBy:sort ascending:asc];
	else
		return [NSArray array];
}

#pragma mark - Set

+ (void)SetItemsToEntity:(NSString*)entity items:(NSArray*)items {
	NSInteger currentCount = [[NSClassFromString(entity) MR_numberOfEntities] integerValue];
	if (currentCount > 0)
		[NSClassFromString(entity) MR_truncateAll];
	
	if (items.count > 0) {
		for (NSDictionary *itemdict in items) {
			@try {
				id newEntity = [NSClassFromString(entity) MR_createEntityInContext:[self GetContext]];
				[newEntity setValuesForKeysWithDictionary:itemdict];
			}
			@catch (NSException *exception) {
				NSLog(@"Exception in updating %@ with message: %@", entity, exception.description);
			}
			@finally {
				[[self GetContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError * _Nullable error) {
					if (error) NSLog(@"Error in saving %@ context because: %@", entity, error.localizedDescription);
				}];
			}
		}
	}
}

#pragma mark - Delete

+ (void)DeleteAllItemsFromEntity:(NSString*)entity {
	@try {
		[NSClassFromString(entity) MR_truncateAllInContext:[self GetContext]];
	}
	@catch (NSException *exception) {
		NSLog(@"Exception in deleting %@ with message: %@", entity, exception.description);
	}
	@finally {
		[[self GetContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError * _Nullable error) {
			if (error) NSLog(@"Error in saving %@ context because: %@", entity, error.localizedDescription);
		}];
	}
}

+ (void)DeleteItemFromEntity:(NSString*)entity predicate:(NSPredicate*)pred {
	@try {
		[NSClassFromString(entity) MR_deleteAllMatchingPredicate:pred inContext:[self GetContext]];
	}
	@catch (NSException *exception) {
		NSLog(@"Exception in deleting %@ with message: %@", entity, exception.description);
	}
	@finally {
		[[self GetContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError * _Nullable error) {
			if (error) NSLog(@"Error in deleting items from %@ context because: %@", entity, error.localizedDescription);
		}];
	}
}

#pragma mark - Search

+ (NSArray*)SearchItemsFromEntity:(NSString*)entity predicate:(NSPredicate*)pred {
	NSInteger currentCount = [self GetItemCountFromEntity:entity];
	
	if (currentCount > 0)
		return [NSClassFromString(entity) MR_findAllWithPredicate:pred];
	else
		return [NSArray array];
}

@end
