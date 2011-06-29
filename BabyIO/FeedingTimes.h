//
//  FeedingTimes.h
//  BabyIO
//
//  Created by Andrew Hunzeker on 6/12/11.
//  Copyright (c) 2011 IPSOFACTO LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DailyIO;

@interface FeedingTimes : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * hour;
@property (nonatomic, retain) DailyIO * whatDay;

@end
