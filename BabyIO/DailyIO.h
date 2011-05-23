//
//  DailyIO.h
//  BabyIO
//
//  Created by Andrew Hunzeker on 5/22/11.
//  Copyright (c) 2011 IPSOFACTO LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DailyIO : NSManagedObject {
@private
}
@property (nonatomic, retain) NSDate * Date;
@property (nonatomic, retain) NSNumber * weewee;
@property (nonatomic, retain) NSNumber * feeding;
@property (nonatomic, retain) NSString * feedingTime;
@property (nonatomic, retain) NSNumber * poopers;
@property (nonatomic, retain) NSNumber * Sleep;

@end
