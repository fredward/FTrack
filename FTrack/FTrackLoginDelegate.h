//
//  FTrackLoginDelegate.h
//  FTrack
//
//  Created by Carl Ward on 10/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FTrackLoginDelegate <NSObject> //this is what is used, just a protocol

    //NSString *theContent;
   // BOOL connectionComplete;

//@property (retain) NSString *theContent;
//@property BOOL connectionComplete;
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
-(void) connectionDidFinishLoading:(NSURLConnection *)connection;
//-(BOOL)successfulLogin;

@end

@interface FTrackLoginDelegate : NSObject {
    NSString *theContent;
     BOOL connectionComplete;
}
    @property (retain) NSString *theContent;
    @property BOOL connectionComplete;
    -(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
    -(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
    -(void) connectionDidFinishLoading:(NSURLConnection *)connection;
    -(BOOL)successfulLogin;
@end