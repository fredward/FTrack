//
//  FTrackLogin.m
//  FTrack
//
//  Created by Carl Ward on 9/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FTrackLogin.h"
#import "FTrackLoginDelegate.h"
//test for github
@implementation FTrackLogin
@synthesize c, c2, myData, cookies;
/*
 <html>
 <body>
 <FORM ACTION="http://www.flotrack.org/site/login" METHOD=POST>
 <P>Please Fill the Registration Form</p><br>
 Enter Your Name<input type="text" name="LoginForm[username]" id="LoginForm_username"><br>
 password<input type=";password" name="LoginForm[password]" id="LoginForm_password"><br>
 <input type="submit" value="send">
 </FORM>
 </body>
 </html>
 */
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}
-(BOOL)login:(NSString *)userName password:(NSString *)password
{
    
    
    NSURL * url = [NSURL URLWithString:@"http://www.flotrack.org/site/login/"];
    NSString *requestString = [NSString stringWithFormat:@"LoginForm[username]=%@&LoginForm[password]=%@", userName, password];
    NSMutableURLRequest * r = [[NSMutableURLRequest alloc] initWithURL:url];	
    NSData *httpBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
    [r setHTTPMethod:@"POST"];
    [r setHTTPBody:httpBody];
    [r setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"]; 
    
    //Delete Previous cookies...
    NSHTTPCookieStorage *cs = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSLog(@"Cookies: %@", cs);
    NSArray *cookiess = [cs cookies];
    if([cookiess count] != 0)
    {
        //[cs deleteCookie:[cookiess objectAtIndex:0]];
    }
    
    
    myData = [[NSMutableData alloc]  init];
    FTrackLoginDelegate *myNewDelegate = [[FTrackLoginDelegate alloc] init]; 
    c = [[NSURLConnection alloc] initWithRequest:r delegate:myNewDelegate];
    if([myNewDelegate loginWasSuccessful])
        return YES;
    [myNewDelegate release];
    [r release];
    return NO;
    //SUMBIT LOG
    /*
    NSURL *url2 = [NSURL URLWithString:@"http://www.flotrack.org/running_logs/day/2011/10/19"];
    requestString = @"RunningLogResource[distance]=8&RunningLogResource[notes]=TESTPOST&RunningLogResource[log_type]=run&RunningLogResource[dist_unit]=miles";
    [r setURL:url2];
    httpBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
    [r setHTTPMethod:@"POST"];
    [r setHTTPBody:httpBody];
    [r setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    if (cookies) {
		NSEnumerator *enumerator = [cookies objectEnumerator];
		id cookie;
		while (cookie = [enumerator nextObject]) {
			[r addValue:[cookie value] forHTTPHeaderField:@"Cookies"];
		}
	}
    //myData = [[NSMutableData alloc] retain];
    [myData setData:nil];
    c2 = [[NSURLConnection alloc] initWithRequest:r delegate:self];
     */
    
    
}
-(void)postLogForDate:(NSDate *)date distance:(float)distance time:(NSString *)time feel:(int)feel notes:(NSString *)notes
{
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *stuff = [[NSCalendar currentCalendar] components:unitFlags fromDate:date];
    
    NSString *string = [NSString stringWithFormat:@"http://www.flotrack.org/running_logs/day/%i/%i/%i",[stuff year],[stuff month],[stuff day]];
    //NSLog(string);
    NSURL * url = [NSURL URLWithString:string];
    
    NSString *requestString = [NSString stringWithFormat:@"RunningLogResource[log_type]=run&RunningLogResource[distance]=%f&RunningLogResource[mins]=%@&RunningLogResource[secs]=%@&RunningLogResource[dist_unit]=miles&RunningLogResource[feel]=%i&RunningLogResource[notes]=%@",distance,[[time componentsSeparatedByString:@":"]objectAtIndex:0],[[time componentsSeparatedByString:@":"] objectAtIndex:1], feel, notes];
    //&RunningLogResource[notes]=\"%@\"
    //NSLog(requestString);
    NSMutableURLRequest * r = [[NSMutableURLRequest alloc] initWithURL:url];	
    NSData *httpBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
    [r setHTTPMethod:@"POST"];
    [r setHTTPBody:httpBody];
    [r setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"]; 
    FTrackLoginDelegate *myNewDelegate = [[FTrackLoginDelegate alloc] init];
    c2 = [[NSURLConnection alloc] initWithRequest:r delegate:myNewDelegate];
    [myNewDelegate release];
    [r release];
}

@end
