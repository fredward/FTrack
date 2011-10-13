//
//  FTrackLogin.m
//  FTrack
//
//  Created by Carl Ward on 9/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FTrackLogin.h"
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
-(void)login:(NSString *)userName password:(NSString *)password
{
    
    
    NSURL * url = [NSURL URLWithString:@"http://www.flotrack.org/site/login/"];
    NSString *requestString = @"LoginForm[username]=fredward&LoginForm[password]=BooRosie1";
    NSMutableURLRequest * r = [[NSMutableURLRequest alloc] initWithURL:url];	
    NSData *httpBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
    [r setHTTPMethod:@"POST"];
    [r setHTTPBody:httpBody];
    [r setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"]; 
    
    //Delete Previous cookies...
    NSHTTPCookieStorage *cs = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSLog(@"Cookies: %@", cs);
    NSArray *cookiess = [cs cookies];
    [cs deleteCookie:[cookiess objectAtIndex:0]];
    
    //NSHTTPURLResponse * response = nil; //Cookie Handleing.... Not necessary apparently
    //NSError * error = nil;
    /*
    if (cookies) {
		NSEnumerator *enumerator = [cookies objectEnumerator];
		id cookie;
		while (cookie = [enumerator nextObject]) {
			[r addValue:[cookie value] forHTTPHeaderField:@"Cookies"];
		}
	}
    
    myData = [[NSMutableData alloc]  init];
    c = [[NSURLConnection alloc] initWithRequest:r delegate:self];
    [r release];
    */
    myData = [[NSMutableData alloc]  init];
    c = [[NSURLConnection alloc] initWithRequest:r delegate:self];
    
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
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    /* Dont need cookie handling? Done automaitcally?
    NSHTTPURLResponse *httpResponse = [(NSHTTPURLResponse*)response retain]; //Its going to be an HTTP response
    if([httpResponse statusCode] == 200)
    {
         
        NSDictionary *theHeaders = [httpResponse allHeaderFields];
        NSArray      *theCookies = [NSHTTPCookie cookiesWithResponseHeaderFields:theHeaders forURL:[response URL]];
        
       

        if ([theCookies count] > 0) {
                        self.cookies = theCookies;
            NSLog(@"Cookies:%@",[theCookies objectAtIndex:1]);
        }
    }
     */
    [myData setLength:0];
}
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [myData appendData:data];
}
-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *content = [[NSString alloc]  initWithData:myData encoding: NSASCIIStringEncoding];
    NSLog(@"Data: %@",content);
    [c release];
    //[myData release];
}
/*
- (void) requestFinished:(ASIHTTPRequest *)request {
    //Hide your loading view here.
    NSString *responseString = [request responseString];
    NSLog(@"%@", responseString);
    //Request succeeded
}

- (void) requestFailed:(ASIHTTPRequest *)request {
    //Hide your loading view here.
    NSError *error = [request error];
    NSLog(@"%@", [error localizedDescription]);
    //Request failed
}
*/

@end
