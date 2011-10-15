//
//  LoginSuccessDelegate.h
//  FTrack
//
//  Created by Frederick Ward on 10/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginSuccessDelegate <NSObject>
-(void)loginSuccess:(BOOL)wasSuccessful;
@end
