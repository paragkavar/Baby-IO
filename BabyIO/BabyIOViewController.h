//
//  BabyIOViewController.h
//  BabyIO
//
//  Created by Andrew Hunzeker on 2/12/11.
//  Copyright 2011 Andrew HunzekerHesed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyIO.h"
#import "FeedingTimes.h"

@interface BabyIOViewController : UIViewController {
    IBOutlet UILabel *feedingnum;
    IBOutlet UILabel *wetnum;
    IBOutlet UILabel *poopernum;
    IBOutlet UILabel *sleepnum;
    IBOutlet UILabel *todaysDate;
    IBOutlet UILabel *feedingTimeLabel;

//model
    DailyIO *dailyIO;
    FeedingTimes *feedingTimes;
    NSManagedObjectContext *managedObjectContext;
    NSArray *dataArray;
    NSMutableSet *feedingTimeSet;
    NSDate *strippedDate;
    
    
    
}
@property (nonatomic, retain) UILabel *todaysDate;
@property (nonatomic, retain) UILabel *feedingnum;
@property (nonatomic, retain) UILabel *wetnum;
@property (nonatomic, retain) UILabel *poopernum;
@property (nonatomic, retain) UILabel *sleepnum;

@property (nonatomic, retain) UILabel *feedingTimeLabel;

//model methods

@property (nonatomic, retain) DailyIO *dailyIO;
@property (nonatomic, retain) FeedingTimes *feedingTimes;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) NSMutableSet *feedingTimeSet;
@property (nonatomic, retain) NSDate *strippedDate;


-(IBAction) minusnum:(id)sender;
-(IBAction) plusnum:(id)sender;


@end
