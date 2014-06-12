//
//  DirectoryTableViewCell.m
//  UniversityPrograms
//
//  Created by Miles Crabbe on 6/6/14.
//  Copyright (c) 2014 CAPS. All rights reserved.
//

#import "DirectoryTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Colours.h"
#import "UIColor+UPColors.h"
@import QuartzCore;

@interface DirectoryTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIImageView *telephoneImage;
@property (weak, nonatomic) IBOutlet UIImageView *mailImage;
@property Employee *selectedEmployee;
@end

@implementation DirectoryTableViewCell
-(instancetype)init{
    self=[super init];
    //init is such a way that the xib file actually works
    self=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DirectoryTableViewCell class]) owner:nil options:nil][0];
    
    return self;
}
-(void)buildWtihEmployee:(Employee *)emp{
    
    self.selectedEmployee = emp;
    self.employeeEmail.text=emp.email;
    //self.employeeImage.layer.cornerRadius=2;
    [self.employeeImage setImageWithURL:[[NSURL alloc] initWithString:emp.imageURL]];
    self.employeeName.text=emp.name;
    self.employeePhone.text=[NSString stringWithFormat:@"Phone: %@", emp.phone];
    self.employeeTitle.text=emp.title;
    self.employeeImage.layer.cornerRadius=self.employeeImage.frame.size.width/2;
    //NSLog([NSString stringWithFormat:@"%@", emp.phone]);
    self.employeeName.textColor = [UIColor getThemeColor];
    self.employeeTitle.textColor = [UIColor getThemeColor];
    self.employeeEmail.backgroundColor = [UIColor getStyleColor];
    self.employeeTitle.backgroundColor = [UIColor getStyleColor];
    self.employeePhone.textColor = [UIColor getTextColor];
    self.employeeEmail.textColor = [UIColor getTextColor];
    self.employeePhone.backgroundColor = [UIColor getStyleColor];
    self.employeeName.backgroundColor = [UIColor getStyleColor];
    self.backgroundColor = [UIColor getStyleColor];
    
    if([emp.phone isEqualToString:@"Graduate"]||[emp.phone isEqualToString:@"Senior"]||[emp.phone isEqualToString:@"Junior"]||[emp.phone isEqualToString:@"2nd Year Law"]){
        self.phoneButton.alpha=0.0f;
        self.employeePhone.text=[NSString stringWithFormat:@"Year: %@", emp.phone];
        self.telephoneImage.alpha = 0.0f;
        self.mailImage.alpha = 0.0f;
    }
    else {
        self.phoneButton.alpha=1.0f;
        self.telephoneImage.alpha = 1.0f;
        self.mailImage.alpha = 1.0f;
    }
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didSelectPhoneNumber:(id)sender {
    
    //NSLog(@"phone tap");
    //self.employeePhone.backgroundColor=[UIColor grassColor];
    NSString *telephoneURLString = [NSString stringWithFormat:@"tel://%@", self.selectedEmployee.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telephoneURLString]];
    NSLog(@"%@", telephoneURLString);
    //self.employeePhone.backgroundColor=[UIColor whiteColor];
}

@end
