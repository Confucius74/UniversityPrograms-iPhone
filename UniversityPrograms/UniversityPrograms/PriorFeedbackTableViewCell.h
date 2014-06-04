//
//  PriorFeedbackTableViewCell.h
//  UniversityPrograms
//
//  Created by Miles Crabbe on 6/3/14.
//  Copyright (c) 2014 CAPS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
@interface PriorFeedbackTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *descriptionBox;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
-(void)buildWithComment:(Comment *)c;
@end