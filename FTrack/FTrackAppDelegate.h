//
//  FTrackAppDelegate.h
//  FTrack
//
//  Created by Carl Ward on 9/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FTrackViewController;

@interface FTrackAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet FTrackViewController *viewController;

@end
