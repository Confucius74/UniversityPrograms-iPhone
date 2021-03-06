//
//  UPNavigationViewController.m
//  UniversityPrograms
//
//  Created by Miles Crabbe on 6/4/14.
//  Copyright (c) 2014 CAPS. All rights reserved.
//

#import "UPNavigationViewController.h"
#import "Colours.h"
#import "UIColor+UPColors.h"

@interface UPNavigationViewController ()

@end

@implementation UPNavigationViewController
-(id)initWithRootViewController:(UPViewController *)rootViewController{
    self=[super initWithRootViewController:rootViewController];
    
    self.rootViewController = rootViewController;
    
    
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor getThemeColor], NSFontAttributeName : [UIFont systemFontOfSize:20]};
}
-(void)viewDidAppear:(BOOL)animated{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [UIColor lightGrayColor];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"darkMode"]){
        self.navigationBar.barStyle = UIBarStyleBlackOpaque;
    }
    else{
        self.navigationBar.barStyle = UIBarStyleDefault;
    }
    //self.navigationBar.barTintColor = [UIColor UPDarkGreyColo\];
    //[[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    
    
    //Make light content status bar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//-(UIStatusBarStyle)preferredStatusBarStyle{
    //return UIStatusBarStyleDefault;
//}

@end
