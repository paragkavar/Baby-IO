//
//  BabyIOViewController.h
//  BabyIO
//
//  Created by Andrew Hunzeker on 2/12/11.
//  Copyright 2011 Andrew HunzekerHesed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyIO.h"

@interface BabyIOViewController : UIViewController {
    IBOutlet UILabel *feedingnum;
    IBOutlet UILabel *wetnum;
    IBOutlet UILabel *poopernum;
    IBOutlet UILabel *sleepnum;
    IBOutlet UILabel *todaysDate;
    //feeding time labels
    IBOutlet UILabel *midnight;
    IBOutlet UILabel *oneam;
    IBOutlet UILabel *twoam;
    IBOutlet UILabel *threeam;
    IBOutlet UILabel *fouram;
    IBOutlet UILabel *fiveam;
    IBOutlet UILabel *sixam;
    IBOutlet UILabel *sevenam;
    IBOutlet UILabel *eightam;
    IBOutlet UILabel *nineam;
    IBOutlet UILabel *tenam;
    IBOutlet UILabel *elevenam;
    IBOutlet UILabel *noon;
    IBOutlet UILabel *onepm;
    IBOutlet UILabel *twopm;
    IBOutlet UILabel *threepm;
    IBOutlet UILabel *fourpm;
    IBOutlet UILabel *fivepm;
    IBOutlet UILabel *sixpm;
    IBOutlet UILabel *sevenpm;
    IBOutlet UILabel *eightpm;
    IBOutlet UILabel *ninepm;
    IBOutlet UILabel *tenpm;
    IBOutlet UILabel *elevenpm;
//model
    DailyIO *dailyIO;
    NSManagedObjectContext *managedObjectContext;
    
    
    
}
@property (nonatomic, retain) UILabel *todaysDate;
@property (nonatomic, retain) UILabel *feedingnum;
@property (nonatomic, retain) UILabel *wetnum;
@property (nonatomic, retain) UILabel *poopernum;
@property (nonatomic, retain) UILabel *sleepnum;

//feedinglabels
@property (nonatomic, retain) UILabel *midnight;
@property (nonatomic, retain) UILabel *oneam;
@property (nonatomic, retain) UILabel *twoam;
@property (nonatomic, retain) UILabel *threeam;
@property (nonatomic, retain) UILabel *fouram;
@property (nonatomic, retain) UILabel *fiveam;
@property (nonatomic, retain) UILabel *sixam;
@property (nonatomic, retain) UILabel *sevenam;
@property (nonatomic, retain) UILabel *eightam;
@property (nonatomic, retain) UILabel *nineam;
@property (nonatomic, retain) UILabel *tenam;
@property (nonatomic, retain) UILabel *elevenam;
@property (nonatomic, retain) UILabel *noon;
@property (nonatomic, retain) UILabel *onepm;
@property (nonatomic, retain) UILabel *twopm;
@property (nonatomic, retain) UILabel *threepm;
@property (nonatomic, retain) UILabel *fourpm;
@property (nonatomic, retain) UILabel *fivepm;
@property (nonatomic, retain) UILabel *sixpm;
@property (nonatomic, retain) UILabel *sevenpm;
@property (nonatomic, retain) UILabel *eightpm;
@property (nonatomic, retain) UILabel *ninepm;
@property (nonatomic, retain) UILabel *tenpm;
@property (nonatomic, retain) UILabel *elevenpm;

//model methods

@property (nonatomic, retain) DailyIO *dailyIO;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


-(IBAction) minusnum:(id)sender;
-(IBAction) plusnum:(id)sender;


@end
