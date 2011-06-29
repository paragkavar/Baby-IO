//
//  DailyIO.m
//  BabyIO
//
//  Created by Andrew Hunzeker on 6/12/11.
//  Copyright (c) 2011 IPSOFACTO LLC. All rights reserved.
//

#import "DailyIO.h"


@implementation DailyIO
@dynamic feeding;
@dynamic weewee;
@dynamic day;
@dynamic sleep;
@dynamic poopers;
@dynamic feedingTime;

- (void)addFeedingTimeObject:(NSManagedObject *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"feedingTime" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"feedingTime"] addObject:value];
    [self didChangeValueForKey:@"feedingTime" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeFeedingTimeObject:(NSManagedObject *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"feedingTime" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"feedingTime"] removeObject:value];
    [self didChangeValueForKey:@"feedingTime" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addFeedingTime:(NSSet *)value {    
    [self willChangeValueForKey:@"feedingTime" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"feedingTime"] unionSet:value];
    [self didChangeValueForKey:@"feedingTime" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeFeedingTime:(NSSet *)value {
    [self willChangeValueForKey:@"feedingTime" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"feedingTime"] minusSet:value];
    [self didChangeValueForKey:@"feedingTime" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
