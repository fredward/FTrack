//
//  LogViewController.h
//  FTrack
//
//  Created by Frederick Ward on 10/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogViewController : UIViewController
{
    IBOutlet UISegmentedControl *seg;
}
@property (nonatomic, retain) UISegmentedControl *seg;
-(IBAction)clearLogin;
@end
