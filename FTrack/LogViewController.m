//
//  LogViewController.m
//  FTrack
//
//  Created by Frederick Ward on 10/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LogViewController.h"

@implementation LogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)clearLogin
{
    NSHTTPCookieStorage *cs = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //NSLog(@"Cookies: %@", cs);
   
    NSArray *flocookies = [cs cookies ];//]ForURL:[NSURL URLWithString:@"flotrack.org"]];
        if([flocookies count] >0)
        {
            NSHTTPCookie *flocookie = [flocookies objectAtIndex:0];
           [cs deleteCookie:flocookie];
            NSLog(@"deleted");
        }
    
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
