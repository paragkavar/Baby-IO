//
//  DailyIO.h
//  BabyIO
//
//  Created by Andrew Hunzeker on 6/12/11.
//  Copyright (c) 2011 IPSOFACTO LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DailyIO : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * feeding;
@property (nonatomic, retain) NSNumber * weewee;
@property (nonatomic, retain) NSDate * day;
@property (nonatomic, retain) NSNumber * sleep;
@property (nonatomic, retain) NSNumber * poopers;
@property (nonatomic, retain) NSSet* feedingTime;

- (void)addFeedingTimeObject:(NSManagedObject *)value;
- (void)removeFeedingTimeObject:(NSManagedObject *)value;
- (void)addFeedingTime:(NSSet *)value;
- (void)removeFeedingTime:(NSSet *)value;
@end
