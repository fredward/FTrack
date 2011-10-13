//
//  FTrackLogin.h
//  FTrack
//
//  Created by Carl Ward on 9/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTrackLogin : NSObject
{
    NSMutableData * myData;
    NSArray *cookies;
    NSURLConnection *c, *c2;
}
//test test
@property (retain) NSMutableData * myData;
@property (retain) NSURLConnection *c, *c2;
@property (retain) NSArray *cookies;
-(void)login:(NSString *) userName password:(NSString *)password;
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
-(void) connectionDidFinishLoading:(NSURLConnection *)connection;
@end
