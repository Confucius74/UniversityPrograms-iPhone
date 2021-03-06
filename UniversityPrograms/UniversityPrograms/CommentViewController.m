//
//  commentViewController.m
//  UniversityPrograms
//
//  Created by Miles Crabbe on 5/30/14.
//  Copyright (c) 2014 CAPS. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "CommentViewController.h"
#import "UPDataRetrieval.h"
#import "Colours.h"
#import "Comment.h"
#import "NSObject+ObjectMap.h"
#import "UIColor+UPColors.h"
#import "UserInfoViewController.h"
#import "DateTools.h"
@import QuartzCore;

@interface CommentViewController ()
@property (weak, nonatomic) IBOutlet UITextField *subjectBox;
@property (weak, nonatomic) IBOutlet UITextView *commentBox;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (weak, nonatomic) IBOutlet UIView *dividerView;
@property (weak, nonatomic) IBOutlet UIView *verticalDividerView;
@property BOOL commentFlag;

@end

@implementation CommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"Leave a Comment";
    }
    
    
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.bigView setBackgroundColor:[UIColor getStyleColor]];
    [self.mainScrollView addSubview:self.bigView];
    self.mainScrollView.contentSize=self.bigView.frame.size;
    [self.mainScrollView setBackgroundColor:[UIColor getStyleColor]];
    //self.commentBox.layer.cornerRadius=8;
    //self.commentBox.layer.borderWidth=0.5f;
    //self.commentBox.layer.borderColor = [[UIColor getTextColor] CGColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleDone target:self action:@selector(didTapSubmit)];
    self.subjectBox.textColor = [UIColor getTextColor];
    self.subjectBox.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Subject" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    self.commentBox.backgroundColor = [UIColor getStyleColor];
    self.commentBox.textColor = [UIColor lightGrayColor];
    self.dividerView.backgroundColor = [UIColor getThemeColor];
    self.verticalDividerView.backgroundColor = [UIColor getThemeColor];
    self.commentBox.text=@"Comment";
    self.commentFlag = YES;
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"darkMode"]){
        self.subjectBox.keyboardAppearance = UIKeyboardAppearanceDark;
        self.commentBox.keyboardAppearance = UIKeyboardAppearanceDark;
    }
    else{
        self.subjectBox.keyboardAppearance = UIKeyboardAppearanceLight;
        self.commentBox.keyboardAppearance = UIKeyboardAppearanceLight;
    }
    
}
-(void)updateViews{
    [self.bigView setBackgroundColor:[UIColor getStyleColor]];
    [self.mainScrollView addSubview:self.bigView];
    self.mainScrollView.contentSize=self.bigView.frame.size;
    [self.mainScrollView setBackgroundColor:[UIColor getStyleColor]];
    //self.commentBox.layer.cornerRadius=8;
    //self.commentBox.layer.borderWidth=0.5f;
    //self.commentBox.layer.borderColor = [[UIColor getTextColor] CGColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleDone target:self action:@selector(didTapSubmit)];
    self.subjectBox.textColor = [UIColor getTextColor];
    self.subjectBox.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Subject" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    self.commentBox.backgroundColor = [UIColor getStyleColor];
    self.commentBox.textColor = [UIColor lightGrayColor];
    self.dividerView.backgroundColor = [UIColor getThemeColor];
    self.verticalDividerView.backgroundColor = [UIColor getThemeColor];
    self.commentBox.text=@"Comment";
    self.commentFlag = YES;
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"darkMode"]){
        self.subjectBox.keyboardAppearance = UIKeyboardAppearanceDark;
        self.commentBox.keyboardAppearance = UIKeyboardAppearanceDark;
    }
    else{
        self.subjectBox.keyboardAppearance = UIKeyboardAppearanceLight;
        self.commentBox.keyboardAppearance = UIKeyboardAppearanceLight;
    }
    if(self.child){
        [self.child updateViews];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    if([[NSUserDefaults standardUserDefaults] stringForKey:@"cwid"]==nil||[[NSUserDefaults standardUserDefaults] stringForKey:@"email"]==nil||[[NSUserDefaults standardUserDefaults] stringForKey:@"userLastName"]==nil||[[NSUserDefaults standardUserDefaults] stringForKey:@"userFirstName"]==nil){
        [self addLoadErrorView];
    }
    else{
        [self.subjectBox becomeFirstResponder];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor getStyleColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI interaction

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleDone target:self action:@selector(didTapSubmit)];
    [textField resignFirstResponder];
    [self.commentBox becomeFirstResponder];
    return NO;
}
- (IBAction)didEndEditingSubject:(id)sender {
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleDone target:self action:@selector(didTapDone)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone                                 target:self action:@selector(doneButtonOps)];
}

- (IBAction)didStartEditingFirst:(id)sender {
    //self.navigationItem.rightBarButtonItem=Nil;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone                                 target:self action:@selector(doneButtonOps)];
    
}
-(void)didTapSubmit{
    if(self.subjectBox.text==nil||[self.subjectBox.text isEqualToString:@""]||self.commentBox.text==nil||[self.commentBox.text isEqualToString:@""]||[self.commentBox.text isEqualToString:@"Comment"]){
        [self addContentErrorView];
    }else{
    Comment *comment= [[Comment alloc] init];
    comment.cwid=[[NSUserDefaults standardUserDefaults] valueForKey:@"cwid"];
    comment.commentTitle=self.subjectBox.text;
    comment.email=[[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    comment.CommentText=self.commentBox.text;
    //comment.dateAdded=[[NSDate date] formattedDateWithFormat:@"MM-dd-yyyy HH:mm:ss"];
    //NSLog(@"%@", comment.dateAdded);
    [UPDataRetrieval submitComment:comment.cwid comment:comment completetionHandler:^(NSURLResponse *response, NSData *data, NSError *e) {
        if([[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]isEqualToString:@"true"]){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addSuccessView];
                
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addErrorView];
                
            });
        }
        
        
    }];
    }
}
-(void)doneButtonOps{
    [self.subjectBox resignFirstResponder];
    [self.commentBox resignFirstResponder];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleDone target:self action:@selector(didTapSubmit)];
    self.commentBox.frame = CGRectMake(self.commentBox.frame.origin.x, self.commentBox.frame.origin.y, self.commentBox.frame.size.width, self.bigView.frame.size.height-76);
}
- (void)textViewDidBeginEditing:(UITextView *)textView{

    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonOps)];
    if(self.commentFlag){
        textView.text=@"";
        self.commentFlag = NO;
        textView.textColor = [UIColor getTextColor];
    }
    else if ([self.commentBox.text isEqualToString:@"Comment"]){
        textView.text=@"";
        textView.textColor = [UIColor getTextColor];
    }
    self.commentBox.frame = CGRectMake(self.commentBox.frame.origin.x, self.commentBox.frame.origin.y, self.commentBox.frame.size.width, self.bigView.frame.size.height-76-270);
    
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if([self.commentBox.text isEqualToString:@""]){
        self.commentBox.text= @"Comment";
        self.commentBox.textColor = [UIColor lightGrayColor];
    }
}
#pragma mark - alert view methods

-(void)addSuccessView{
    UIAlertView *saveAlert = [[UIAlertView alloc]initWithTitle:@"Comment Sent!" message:@"Your Comment has been sent to our database and a Univeristy Programs representative will review it.\n Thank You." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    saveAlert.tag = 3;
    [saveAlert show];
}
-(void)addErrorView{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"There was an error sending your comment, please ensure that all user info is entered and you have a connection to the network.\n Thank You." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    errorAlert.tag=1;
    [errorAlert show];
}
-(void)addLoadErrorView{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"User info is not configured, please enter your user info before submitting a comment.\n Thank You." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: @"OK", nil];
    errorAlert.tag=0;
    [errorAlert show];
}
-(void)addContentErrorView{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"Please provide both a subject and a comment.\n Thank You." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    errorAlert.tag=2;
    [errorAlert show];
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==0){
        if(buttonIndex == 0){
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            UserInfoViewController *tempInfoViewController = [[UserInfoViewController alloc] init];
            self.child = tempInfoViewController;
            [self.navigationController pushViewController:tempInfoViewController animated:YES];
        }
    }
   
    else if(alertView.tag==2){
        
    }
    else if(alertView.tag==3){
        [self.navigationController popViewControllerAnimated:YES];
    }
}






@end
