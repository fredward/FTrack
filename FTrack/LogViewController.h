//
//  LogViewController.h
//  FTrack
//
//  Created by Frederick Ward on 10/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
{
    IBOutlet UISegmentedControl *seg;
    IBOutlet UITextView *notesView;
    IBOutlet UITextField *miles, *time;
    NSDate *chosenDate;
}
@property (nonatomic, retain) UISegmentedControl *seg;
@property (nonatomic, retain) UITextView *notesView;
@property (nonatomic, retain) UITextField *miles, *time;
@property (retain) NSDate *chosenDate;
-(IBAction)clearLogin;
-(IBAction)submit;
-(void)postLogForDate:(NSDate *)date distance:(float)distance time:(NSString *)t feel:(int)feel notes:(NSString *)notes;
-(IBAction)setDate:(id)sender;
-(void)dateChosen:(NSDate *)selectedDate:(id)view;

//delegate methods
-(BOOL) textFieldShouldReturn:(UITextField *)textField;
-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
-(BOOL) textViewShouldEndEditing:(UITextField *)textView;
-(BOOL) textViewShouldBeginEditing:(UITextView *)textView;
@end
