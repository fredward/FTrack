//
//  FTrackLogin.h
//  FTrack
//
//  Created by Carl Ward on 9/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTrackLoginDelegate.h"
#import "LoginSuccessDelegate.h"

@interface FTrackLogin : NSObject <FTrackLoginDelegate>
{
    NSMutableData * myData;
    NSArray *cookies;
    NSURLConnection *c, *c2;
    NSObject <LoginSuccessDelegate> *delegate;
}
//test test
@property (retain) NSMutableData * myData;
@property (retain) NSURLConnection *c, *c2;
@property (retain) NSArray *cookies;
@property (retain) NSObject <LoginSuccessDelegate> *delegate;
-(void)login:(NSString *) userName password:(NSString *)password;

@end
