//
//  FTrackViewController.h
//  FTrack
//
//  Created by Carl Ward on 9/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTrackViewController : UIViewController{
  IBOutlet UITextField *username;
    IBOutlet UITextField *password;   
}

@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextView *password;


@end
