//
//  BabyIOViewController.m
//  BabyIO
//
//  Created by Andrew Hunzeker on 2/12/11.
//  Copyright 2011 Andrew HunzekerHesed. All rights reserved.
//

#import "BabyIOViewController.h"
#import "DailyIO.h"

@implementation BabyIOViewController
@synthesize todaysDate, feedingnum, poopernum, wetnum, sleepnum,feedingTimeLabel, feedingTimeSet;
@synthesize managedObjectContext;
@synthesize dailyIO;
@synthesize feedingTimes;
@synthesize dataArray;

@synthesize strippedDate;


-(NSDate*)stripthetime{
    
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:flags fromDate:[NSDate date]];
    NSDate* dateOnly = [calendar dateFromComponents:components];
    
    return dateOnly;
    
}

-(NSString *)formatTime:(NSDate *)passedDate{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    NSString *today = [dateFormatter stringFromDate:passedDate];
    [dateFormatter release];
    return today;
    
    
}

-(void) updateUI{
    todaysDate.text = [self formatTime:[self stripthetime]];
    feedingnum.text = [dailyIO.feeding stringValue];
    poopernum.text = [dailyIO.poopers stringValue];
    wetnum.text = [dailyIO.weewee stringValue];
    sleepnum.text = [dailyIO.sleep stringValue];
    NSSet *feed = dailyIO.feedingTime;
    if (![feed count]){
    for (id hours in feed){
        int hour = [hours intValue];
        
        [(UILabel*)[self.view viewWithTag:hour] setTextColor:[UIColor redColor]];
    }
    }
}

-(void)newdayUI{

    todaysDate.text = [self formatTime:[self stripthetime]];
    feedingnum.text = @"0";
    poopernum.text = @"0";
    wetnum.text = @"0";
    sleepnum.text = @"0";
    int resethours = 0;
    while (resethours<=24) {
        [(UILabel*)[self.view viewWithTag:resethours] setTextColor:[UIColor blackColor]];
        resethours ++;
    }

        [feedingTimeSet removeAllObjects];
    
    
    
}

-(void)saveChangesToObjectsInMyMOC:(NSManagedObjectContext *)context{
    
    self.dailyIO.day = [self stripthetime];
    self.dailyIO.feeding = [NSNumber numberWithInt:[feedingTimeSet count]];
    //add hours from Set into feedingTimes Object
    
    //clear out the FeedingTime Set and add in the entire set
    NSLog(@"feedingTimeSet = %@", feedingTimeSet);

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FeedingTimes" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"whatDay == %@", dailyIO];
    [fetchRequest setPredicate:pred];
    // Execute the fetch.
	NSError *fetcherror = nil;
	NSArray *fetchArray = [managedObjectContext executeFetchRequest:fetchRequest error:&fetcherror];
    [fetchRequest release];
    
    for(id obj in fetchArray){
        [managedObjectContext deleteObject:obj];
    
    }
    
    
    if ([feedingTimeSet count]>0){
    for (id object in feedingTimeSet) {
        feedingTimes = (FeedingTimes *)[NSEntityDescription insertNewObjectForEntityForName:@"FeedingTimes" inManagedObjectContext:managedObjectContext];
            self.feedingTimes.hour = object;
            self.feedingTimes.whatDay = dailyIO;
    }
        
    [self.dailyIO addFeedingTimeObject:feedingTimes];
    }
    self.dailyIO.weewee = [NSNumber numberWithInt:[wetnum.text intValue]];
    self.dailyIO.poopers = [NSNumber numberWithInt:[poopernum.text intValue]];
    self.dailyIO.sleep = [NSNumber numberWithInt:[sleepnum.text intValue]];
    
    
    NSError *saveerror = nil;
    
	if ([context hasChanges] && ![context save:&saveerror]){
		NSLog(@"Error! %@, %@", saveerror, [saveerror userInfo]);
		abort();
        
	}
    NSLog(@"saved!");
}

- (void)getlastDBobj{
    /*
	 Fetch existing object.
	 Create a fetch request; find the Event entity and assign it to the request; add a sort descriptor; then execute the fetch.
	 */
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"DailyIO" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"day" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
    [request setFetchLimit:1];
    
    
    // Execute the fetch.
	NSError *fetcherror = nil;
	dataArray = [managedObjectContext executeFetchRequest:request error:&fetcherror];
    [request release];
    [fetcherror release];
  
    if ([dataArray lastObject] == nil) {
        NSLog(@"There was nothing returned");
            dailyIO = (DailyIO *)[NSEntityDescription insertNewObjectForEntityForName:@"DailyIO" inManagedObjectContext:managedObjectContext];
            feedingTimes = (FeedingTimes *)[NSEntityDescription insertNewObjectForEntityForName:@"FeedingTimes" inManagedObjectContext:managedObjectContext];
        [self newdayUI];
        [self saveChangesToObjectsInMyMOC:managedObjectContext];
        
            
	}else{
        
        DailyIO *lastobj = (DailyIO *)[dataArray lastObject];
        
        
        NSLog(@"self strinpthetime = %@", [self stripthetime]);
        NSLog(@"lastonh.day = %@", lastobj.day);

        if ([lastobj.day isEqualToDate:[self stripthetime]]){
            NSLog(@"This is the same day");
            dailyIO = lastobj;
        }else{
            NSLog(@"It is a brand new day");
           dailyIO = (DailyIO *)[NSEntityDescription insertNewObjectForEntityForName:@"DailyIO" inManagedObjectContext:managedObjectContext];
            feedingTimes = (FeedingTimes *)[NSEntityDescription insertNewObjectForEntityForName:@"FeedingTimes" inManagedObjectContext:managedObjectContext];
            [self newdayUI];
            [self saveChangesToObjectsInMyMOC:managedObjectContext];
           
            
        
        }
     
    
    }

	


}







-(IBAction) plusnum:(id)sender
{
    [self getlastDBobj];
    
        
    int identifier;
    identifier = [sender tag];
    switch (identifier) {
        case 30:
           NSLog(@"case0");
            //select the hour
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH"];
            NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
            int hour = [dateString intValue];
            [(UILabel*)[self.view viewWithTag:hour] setTextColor:[UIColor redColor]]; 
            
            //Add hour to Set
            if (![feedingTimeSet containsObject:[NSNumber numberWithInt:hour]]){
                [feedingTimeSet addObject:[NSNumber numberWithInt:hour]];
            }
            feedingnum.text = [[NSNumber numberWithInt:[feedingTimeSet count]] stringValue];
            
            
            break;
        case 31:
            NSLog(@"case1");
            //change the number of wet
            int wettochange = [wetnum.text intValue];
            wettochange = wettochange + 1;
            wetnum.text = [[NSNumber numberWithInt:wettochange] stringValue];
            
            
            break;
        case 32:
            NSLog(@"case2");
            int pooptochange = [poopernum.text intValue];
            pooptochange = pooptochange + 1;
            poopernum.text = [[NSNumber numberWithInt:pooptochange] stringValue];
            break;
        case 33:
            NSLog(@"case3");
            int sleeptochange = [sleepnum.text intValue];
            sleeptochange = sleeptochange + 1;
            sleepnum.text = [[NSNumber numberWithInt:sleeptochange] stringValue];
            
            
            break;
            
        default:
            break;
    }
    [self saveChangesToObjectsInMyMOC:managedObjectContext];
    [self updateUI];
    
    
}

-(IBAction) minusnum:(id)sender
{
    [self getlastDBobj];
    int identifier;
    identifier = [sender tag];
    switch (identifier) {
        case 30:
            NSLog(@"case1");
            if ([feedingTimeSet count] > 0){
                NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"HH"];
                NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
                int hour = [dateString intValue];
                [(UILabel*)[self.view viewWithTag:hour] setTextColor:[UIColor blackColor]];
                //remove time from array
                for(id object in feedingTimeSet){
                    if ([object isEqualToNumber:[NSNumber numberWithInt:hour]]){
                    [feedingTimeSet removeObject:object];
                    }
                    if(!feedingTimeSet){
                        feedingTimeSet = nil;
                    }
                }
            }           
            
            feedingnum.text = [[NSNumber numberWithInt:[feedingTimeSet count]] stringValue];
             break;
            
        case 31:
            NSLog(@"case2");
            int wettochange = [wetnum.text intValue];
            if (wettochange > 0){
                wettochange = wettochange - 1;}
            else{
                wettochange = 0;
            }
            wetnum.text = [[NSNumber numberWithInt:wettochange] stringValue];
            
            
            break;
        case 32:
            NSLog(@"case2");
            int pooptochange = [poopernum.text intValue];
            if (pooptochange > 0){
                pooptochange = pooptochange - 1;}
            else{
                pooptochange = 0;
            }
            poopernum.text = [[NSNumber numberWithInt:pooptochange] stringValue];
            break;
        case 33:
            NSLog(@"case3");
            int sleeptochange = [sleepnum.text intValue];
            if (sleeptochange > 0){
                sleeptochange = sleeptochange - 1;
            } else {
                sleeptochange = 0;
            }
            sleepnum.text = [[NSNumber numberWithInt:sleeptochange] stringValue];
            break;
            
        default:
            break;
    }
    
    [self saveChangesToObjectsInMyMOC:managedObjectContext]; 
    [self updateUI];
    
}




#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [managedObjectContext setRetainsRegisteredObjects:YES];
    feedingTimeSet = [[NSMutableSet alloc]init];
    
   
    
}

-(void)viewWillAppear:(BOOL)animated{
    //fetch the entity
    strippedDate = [self stripthetime];
    [self getlastDBobj];
    [self updateUI];

}

-(void)viewDidAppear:(BOOL)animated{
    

    
}



-(void)viewWillDisappear:(BOOL)animated{
    
    
    NSLog(@"viewgoingaway");
    
}

-(void) unloadIBOutlets{
    self.feedingnum = nil;
    self.wetnum = nil;
    self.poopernum = nil;
    self.sleepnum = nil;
    self.todaysDate = nil;
    self.feedingTimeLabel = nil;


}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    [self unloadIBOutlets];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
 //   [self unloadIBOutlets];
    [dailyIO release];
    [feedingTimes release];
    [managedObjectContext release];
    [feedingTimeSet release];
    [dataArray release];
    [super dealloc];
}

@end
