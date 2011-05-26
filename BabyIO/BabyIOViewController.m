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
@synthesize todaysDate, feedingnum, poopernum, wetnum, sleepnum, midnight, oneam, twoam, threeam, fouram,fiveam, sixam, sevenam, eightam, nineam, tenam, elevenam, noon, onepm, twopm, threepm,fourpm, fivepm, sixpm, sevenpm, eightpm, ninepm, tenpm, elevenpm;
@synthesize managedObjectContext;
@synthesize dailyIO;


-(NSDate*)stripthetime{
    
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* components = [calendar components:flags fromDate:[NSDate date]];
    
    NSDate* dateOnly = [calendar dateFromComponents:components];
    
    return dateOnly;
    
}


- (DailyIO *)getlastDbobj{
    /*
	 Fetch existing events.
	 Create a fetch request; find the Event entity and assign it to the request; add a sort descriptor; then execute the fetch.
	 */
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"DailyIO" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	
	// Order the events by creation date, most recent first.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Date" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
    //limit the request to one
    [request setFetchLimit:1];
	[sortDescriptor release];
	[sortDescriptors release];
    
    
    // Execute the fetch.
	NSError *error = nil;
	NSArray *fetchResults = [managedObjectContext executeFetchRequest:request error:&error];
    //NSLog(@"%@",fetchResults);
	if ([fetchResults count] == 0) {
        dailyIO = (DailyIO *)[NSEntityDescription insertNewObjectForEntityForName:@"DailyIO" inManagedObjectContext:managedObjectContext];
        [dailyIO setDate:[self stripthetime]];
        return dailyIO;
	}else{
    return [fetchResults objectAtIndex:0];
    }
    [fetchResults release];
	[request release];


}


#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    NSString *today = [dateFormatter stringFromDate:[self stripthetime]];
    todaysDate.text = today;
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    DailyIO *lastrec = [self getlastDbobj];
    
    NSLog(@"lastrec date : %@", lastrec.Date);
    NSLog(@"stripthetime ; %@", [self stripthetime]);
    if ([lastrec.Date isEqualToDate:[self stripthetime]]) {
        NSLog(@"sameday!");
        dailyIO = lastrec;
    }else{
    dailyIO = (DailyIO *)[NSEntityDescription insertNewObjectForEntityForName:@"DailyIO" inManagedObjectContext:managedObjectContext];
    [dailyIO setDate:[self stripthetime]];  
    }

    NSLog(@"we are appearing again");
    /*dailyIO = [fetchResults objectAtIndex:0];
    NSString *datetocheck = [dateFormatter stringFromDate:dailyIO.Date];
    if (datetocheck != today){
        dailyIO = nil;

    }
    */
    

}


-(void)savetodb{
    
    
    
   NSError *error = nil;

  
   if (![managedObjectContext save:&error]) {
       NSLog(@"There was an error saving to the db");
   }
    NSLog(@"saved!");
}


-(IBAction) minusnum:(id)sender
{
    int identifier;
    identifier = [sender tag];
    switch (identifier) {
        case 0:
            NSLog(@"case1");
            int feedtochange = [feedingnum.text intValue];
            if (feedtochange > 0){
                feedtochange = feedtochange - 1;}
            else{
                feedtochange = 0;
                NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"HH"];
                NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
                int hour = [dateString intValue];
                [(UILabel*)[self.view viewWithTag:hour] setTextColor:[UIColor blackColor]];
                //[dateString release];
               // [dateFormatter release];
                
                break;
            }
          
            feedingnum.text = [[NSNumber numberWithInt:feedtochange] stringValue];
            

        case 1:
            NSLog(@"case2");
            int wettochange = [wetnum.text intValue];
            if (wettochange > 0){
                wettochange = wettochange - 1;}
            else{
                wettochange = 0;
            }
            dailyIO = (DailyIO *)[NSEntityDescription insertNewObjectForEntityForName:@"DailyIO" inManagedObjectContext:managedObjectContext];
            wetnum.text = [[NSNumber numberWithInt:wettochange] stringValue];
            [dailyIO setWeewee:[NSNumber numberWithInt:wettochange]];
            
            break;
        case 2:
            NSLog(@"case2");
            int pooptochange = [poopernum.text intValue];
            if (pooptochange > 0){
                pooptochange = pooptochange - 1;}
            else{
                pooptochange = 0;
            }
            poopernum.text = [[NSNumber numberWithInt:pooptochange] stringValue];
            break;
        case 3:
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



}

-(IBAction) plusnum:(id)sender
{
    int identifier;
    identifier = [sender tag];
    switch (identifier) {
        case 0:
            NSLog(@"case0");
            //change the number of feedings
            int feedtochange = [feedingnum.text intValue];
            feedtochange = feedtochange + 1;
            feedingnum.text = [[NSNumber numberWithInt:feedtochange] stringValue];
            //set number of feedings in context
            [dailyIO setFeeding:[NSNumber numberWithInt:feedtochange]];
            
            //select the hour
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH"];
            NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
            int hour = [dateString intValue];
            [(UILabel*)[self.view viewWithTag:hour] setTextColor:[UIColor redColor]]; 
            
            //add hour to db
            
            
            break;
        case 1:
            NSLog(@"case1");
            //change the number of wet
            int wettochange = [wetnum.text intValue];
            wettochange = wettochange + 1;
            wetnum.text = [[NSNumber numberWithInt:wettochange] stringValue];
            //set number in context
            [dailyIO setWeewee:[NSNumber numberWithInt:wettochange]];
            

            break;
        case 2:
            NSLog(@"case2");
            int pooptochange = [poopernum.text intValue];
            pooptochange = pooptochange + 1;
            poopernum.text = [[NSNumber numberWithInt:pooptochange] stringValue];
            //set number in context
            [dailyIO setPoopers:[NSNumber numberWithInt:pooptochange]];

            break;
        case 3:
            NSLog(@"case3");
            int sleeptochange = [sleepnum.text intValue];
            sleeptochange = sleeptochange + 1;
            sleepnum.text = [[NSNumber numberWithInt:sleeptochange] stringValue];
            //set sleep in context
            [dailyIO setSleep:[NSNumber numberWithInt:sleeptochange]];
            
    
            break;

        default:
            break;
    }
    
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    NSLog(@"viewgoingaway");
    [self savetodb];
}


- (void)viewDidUnload
{
    
    [super viewDidUnload];
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
    [super dealloc];
}

@end
