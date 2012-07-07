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
@synthesize seg, notesView, miles, time, chosenDate, checkForLogConnection, checkForLogData;
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

-(void)postLogForDate:(NSDate *)date distance:(float)distance time:(NSString *)t feel:(int)feel notes:(NSString *)notes
{
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *stuff = [[NSCalendar currentCalendar] components:unitFlags fromDate:date];
    // %02d formats the string to have a leading 0 if need be
    NSString *string = [NSString stringWithFormat:@"http://www.flotrack.org/running_logs/day/%i/%@/%@",[stuff year],[NSString stringWithFormat:@"%02d", [stuff month]],[NSString stringWithFormat:@"%02d", [stuff day]]];
    //NSLog(string);
    NSURL * url = [NSURL URLWithString:string];
    
    NSString *requestString = [NSString stringWithFormat:@"RunningLogResource[log_type]=run&RunningLogResource[distance]=%f&RunningLogResource[mins]=%@&RunningLogResource[secs]=%@&RunningLogResource[dist_unit]=miles&RunningLogResource[feel]=%i&RunningLogResource[notes]=%@",distance,[[t componentsSeparatedByString:@":"]objectAtIndex:0],[[t componentsSeparatedByString:@":"] objectAtIndex:1], feel, notes];
    //&RunningLogResource[notes]=\"%@\"
    //NSLog(requestString);
    NSMutableURLRequest * r = [[NSMutableURLRequest alloc] initWithURL:url];
	[r setTimeoutInterval:10];
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

-(void)logsDoExistAtDate:(NSDate *)date{ //pull up the webpage and see if there is already a log at the date
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *stuff = [[NSCalendar currentCalendar] components:unitFlags fromDate:date];
    NSString *string = [NSString stringWithFormat:@"http://www.flotrack.org/running_logs/day/%i/%@/%@",[stuff year],[NSString stringWithFormat:@"%02d", [stuff month]],[NSString stringWithFormat:@"%02d", [stuff day]]];    NSURL *url = [NSURL URLWithString:string];
    NSMutableURLRequest *r = [[NSMutableURLRequest alloc] initWithURL:url];
    [r setHTTPMethod:@"GET"];
    checkForLogConnection = [[NSURLConnection alloc]  initWithRequest:r delegate:self];
    [r release];
}

-(void)checkForLogNumbers:(NSString*)data{
    //check for the number of logs here
    NSRange range = [data rangeOfString:@"delete-log"];
    int count = 0;
    while(range.location != NSNotFound){
        range = [data rangeOfString:@"delete-log" options:0 range:range];
        if(range.location != NSNotFound){
            range = NSMakeRange(range.location+range.length, [data length] - (range.location+range.length));
            count++;
        }
    }
    
    
    
    if(count > 0){ //if there are already extant logs
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Logs Exist" message:[NSString stringWithFormat:@"%i logs already exist", count] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alertview show];
        [alertview release];
    }
    else{ // if this is the first log, post it
        float dist = [[miles text] floatValue];
        NSString *t = [NSString stringWithString:[time text]];
        int feel = seg.selectedSegmentIndex+1; //Feel is from 1-5
        NSString *notes = [NSString stringWithString:[notesView text]];
        [self postLogForDate:self.chosenDate distance:dist time:t feel:feel notes:notes];
    }
    
    
}

-(IBAction)submit
{
    
    [self logsDoExistAtDate:self.chosenDate];
    NSLog(@"submitting");
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
-(BOOL)textViewShouldEndEditing:(UITextField *)textField
{
    return YES; //always dismissable
}


//NSURLConnection delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    if(connection == checkForLogConnection){
        if(checkForLogData == nil){
            checkForLogData = [[NSMutableData alloc] initWithData:data];
        }
        else{
            [checkForLogData appendData:data];
        }
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if (connection == checkForLogConnection) {
        
        
        NSString *checkForLogString = [[[NSString alloc] initWithData:checkForLogData encoding:NSUTF8StringEncoding] autorelease];
        [self checkForLogNumbers:checkForLogString];
        [checkForLogData release];
    }
    
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    if(connection == checkForLogConnection){
        //timeout
    }
}

//UIAlertviewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if ([alertView title] == @"Logs Exist") {
        
        //if they are ok with there being extra logs, submit the new log!
        if(buttonIndex == 0){
            float dist = [[miles text] floatValue];
            NSString *t = [NSString stringWithString:[time text]];
            int feel = seg.selectedSegmentIndex+1; //Feel is from 1-5
            NSString *notes = [NSString stringWithString:[notesView text]];
            [self postLogForDate:self.chosenDate distance:dist time:t feel:feel notes:notes];
        }
    }
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
