//
//  FTrackLoginDelegate.h
//  FTrack
//
//  Created by Carl Ward on 10/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTrackLoginDelegate : NSObject
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
-(void) connectionDidFinishLoading:(NSURLConnection *)connection;
@end
