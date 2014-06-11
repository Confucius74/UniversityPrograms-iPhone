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

@import QuartzCore;

@interface CommentViewController ()
@property (weak, nonatomic) IBOutlet UITextField *subjectBox;
@property (weak, nonatomic) IBOutlet UITextView *commentBox;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) IBOutlet UIView *bigView;


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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.bigView setBackgroundColor:[UIColor getThemeColor]];
    [self.mainScrollView addSubview:self.bigView];
    self.mainScrollView.contentSize=self.bigView.frame.size;
    [self.mainScrollView setBackgroundColor:[UIColor getThemeColor]];
    self.commentBox.layer.cornerRadius=8;
    self.commentBox.layer.borderWidth=0;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleDone target:self action:@selector(didTapSubmit)];
    
    
    // Do any additional setup after loading the view from its nib.
}



-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleDone target:self action:@selector(didTapSubmit)];
    [textField resignFirstResponder];
    [self.commentBox becomeFirstResponder];
    return YES;
}
- (IBAction)didEndEditingSubject:(id)sender {
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleDone target:self action:@selector(didTapDone)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone                                 target:self action:@selector(doneButtonOps)];
}

- (IBAction)didStartEditingFirst:(id)sender {
    //self.navigationItem.rightBarButtonItem=Nil;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone                                 target:self action:@selector(doneButtonOps)];
}



-(void)addAlertView{
    UIAlertView *saveAlert = [[UIAlertView alloc]initWithTitle:@"Comment Sent!" message:@"Your Comment has been sent to our database and a Univeristy Programs representative will review it.\n Thank You." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [saveAlert show];
}



- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)didTapSubmit{
    Comment *comment= [[Comment alloc] init];
    comment.cwid=[[NSUserDefaults standardUserDefaults] valueForKey:@"cwid"];
    comment.commentTitle=self.subjectBox.text;
    comment.email=[[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    comment.CommentText=self.commentBox.text;
    [UPDataRetrieval submitComment:comment.cwid comment:comment completetionHandler:^(NSURLResponse *response, NSData *data, NSError *e) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addAlertView];
            
        });
        
        
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)doneButtonOps{
    [self.subjectBox resignFirstResponder];
    [self.commentBox resignFirstResponder];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleDone target:self action:@selector(didTapSubmit)];
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonOps)];
    
}


@end
