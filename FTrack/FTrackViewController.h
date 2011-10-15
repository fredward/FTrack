//
//  FTrackViewController.h
//  FTrack
//
//  Created by Carl Ward on 9/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginSuccessDelegate.h"


@interface FTrackViewController : UIViewController <LoginSuccessDelegate>{
    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *passwordField;
}

@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;
-(IBAction)loginButtonPressed:(id)sender;

@end
