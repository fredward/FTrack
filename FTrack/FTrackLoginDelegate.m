//
//  FTrackLoginDelegate.m
//  FTrack
//
//  Created by Carl Ward on 10/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FTrackLoginDelegate.h"
@implementation FTrackLoginDelegate
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSString *content = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    if([content rangeOfString:@"RunningLogResource"].location == NSNotFound)
    {
        //NSLog(@"%@", content);
    }
        [content release];
    /*
    if ([theData length] !=0) {
        [theData appendData:data];
    }
    else
    {
        theData = [NSMutableData dataWithData:data];
    }
     */
}
-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    /*
    NSString *content = [[NSString alloc] initWithData:theData encoding:NSASCIIStringEncoding];
    NSLog(@"%@", content);
    [content release];
     */
}
@end
