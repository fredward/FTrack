//
//  FTrackViewController.m
//  FTrack
//
//  Created by Carl Ward on 9/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FTrackViewController.h"
#import "FTrackLogin.h"
@implementation FTrackViewController
@synthesize usernameField;
@synthesize passwordField;
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(IBAction)loginButtonPressed:(id)sender{
    FTrackLogin *l = [[FTrackLogin alloc] init];
    [l setDelegate:self];
    [l login:[usernameField text] password:[passwordField text]];
    /*if([l login:[usernameField text] password:[passwordField text]])
        [self dismissModalViewControllerAnimated:YES];
    else
        usernameField.placeholder = @"Incorrect US or PW";*/
    
    //Test Log --WORKS
    //[l postLogForDate:[NSDate date] distance:12 time:@"20:21" feel:5 notes:@"TEST TEST TEST"];

    [l release];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    //FTrackLogin *t = [[FTrackLogin alloc] init];
    //[t login:@"carlcward" password:@"BooRosie"];
    NSLog(@"Hello");
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

-(void)loginSuccess:(BOOL)wasSuccessful{
    NSLog(@"delegate called");
    if(wasSuccessful)
        [self dismissModalViewControllerAnimated:YES];
    else
          usernameField.text = @"Incorrect US or PW";
          
}

@end
