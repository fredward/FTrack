//
//  LogViewController.m
//  FTrack
//
//  Created by Frederick Ward on 10/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LogViewController.h"
#import "ActionSheetPicker.h"

@implementation LogViewController
@synthesize seg, notesView, miles, time, chosenDate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"initwithnib");
        self.chosenDate = [NSDate date];
        
    }
    return self;
}

-(IBAction)clearLogin
{
    NSHTTPCookieStorage *cs = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //NSLog(@"Cookies: %@", cs);
    
    NSArray *flocookies = [cs cookies ];//]ForURL:[NSURL URLWithString:@"flotrack.org"]];
    if([flocookies count] >0)
    {
        NSHTTPCookie *flocookie = [flocookies objectAtIndex:0];
        [cs deleteCookie:flocookie];
        NSLog(@"deleted");
    }
    
}

-(IBAction)setDate:(id)sender{
    [ActionSheetPicker displayActionPickerWithView:self.view datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date] target:self action:@selector(dateChosen::) title:@"Choose Date"];
}

-(void)dateChosen:(NSDate *)selectedDate:(id)view{
    self.chosenDate = selectedDate;
    NSLog(@"%@", selectedDate);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //The next block of code just makes the segmented control have colors
    NSMutableArray *colors = [NSMutableArray arrayWithCapacity:5];
    [colors addObject:[UIColor redColor]];
    [colors addObject:[UIColor orangeColor]];
    [colors addObject:[UIColor yellowColor]];
    [colors addObject:[UIColor blueColor]];
    [colors addObject:[UIColor greenColor]];
    for(int i =0 ;i<5; i++)
    {
        [seg setWidth:seg.bounds.size.width/5 forSegmentAtIndex:i];
        CGRect size = CGRectMake(0, 0, [seg widthForSegmentAtIndex:i]-10 , seg.bounds.size.height-10);
        UIGraphicsBeginImageContext(size.size);
        CGContextRef c = UIGraphicsGetCurrentContext();
        [(UIColor *)[colors objectAtIndex:i] setFill];
        CGContextFillRect(c, size);
        UIImage *theimg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [seg setImage:theimg forSegmentAtIndex:i];
    }
    
    //set updelegatres for text input fields
    [miles setDelegate:self];
    [time setDelegate:self];
    [notesView setDelegate:self];
    [notesView setEditable:YES];
}

-(void)postLogForDate:(NSDate *)date distance:(float)distance time:(NSString *)t feel:(int)feel notes:(NSString *)notes;
{
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *stuff = [[NSCalendar currentCalendar] components:unitFlags fromDate:date];
    
    NSString *string = [NSString stringWithFormat:@"http://www.flotrack.org/running_logs/day/%i/%i/%i",[stuff year],[stuff month],[stuff day]];
    //NSLog(string);
    NSURL * url = [NSURL URLWithString:string];
    
    NSString *requestString = [NSString stringWithFormat:@"RunningLogResource[log_type]=run&RunningLogResource[distance]=%f&RunningLogResource[mins]=%@&RunningLogResource[secs]=%@&RunningLogResource[dist_unit]=miles&RunningLogResource[feel]=%i&RunningLogResource[notes]=%@",distance,[[t componentsSeparatedByString:@":"]objectAtIndex:0],[[t componentsSeparatedByString:@":"] objectAtIndex:1], feel, notes];
    //&RunningLogResource[notes]=\"%@\"
    //NSLog(requestString);
    NSMutableURLRequest * r = [[NSMutableURLRequest alloc] initWithURL:url];	
    NSData *httpBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
    [r setHTTPMethod:@"POST"];
    [r setHTTPBody:httpBody];
    [r setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"]; 
    // FTrackLoginDelegate *myNewDelegate = [[FTrackLoginDelegate alloc] init];
    NSURLConnection *c = [[NSURLConnection alloc] initWithRequest:r delegate:self];
    //[myNewDelegate release];
    [r release];
    [c release];
    
    
}

-(IBAction)submit
{
    float dist = [[miles text] floatValue];
    NSString *t = [NSString stringWithString:[time text]];
    int feel = seg.selectedSegmentIndex+1; //Feel is from 1-5
    NSString *notes = [NSString stringWithString:[notesView text]];
    [self postLogForDate:self.chosenDate distance:dist time:t feel:feel notes:notes];
}


//TextFieldDelegateMethods
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


//TextView delegate methods
//looks at the most recent text being entered
-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) //if the DONE (enter) button is pressed
    {
        [textView resignFirstResponder];
        return YES;
    }
    else
        return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if([[textView text] isEqualToString:@"Notes"]) //clear the notes
        [textView setText:@""];
    
    return YES; //always it always be editable
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES; //always dismissable
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

@end
