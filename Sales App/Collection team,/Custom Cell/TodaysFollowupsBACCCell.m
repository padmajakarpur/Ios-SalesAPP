//
//  TodaysFollowupsBACCCell.m
//  Sales App
//
//  Created by Infinitum on 01/01/19.
//  Copyright © 2019 Infinitumus.com. All rights reserved.
//

#import "TodaysFollowupsBACCCell.h"

@implementation TodaysFollowupsBACCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    
//    _viewCell.layer.masksToBounds = NO;
//    _viewCell.layer.cornerRadius = 8; // if you like rounded corners
//    _viewCell.layer.shadowOffset = CGSizeMake(-10, 15);
//    _viewCell.layer.shadowRadius = 5;
//    _viewCell.layer.shadowOpacity = 0.2;
    
    float shadowSize = 10.0f;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(self.viewCell.frame.origin.x - shadowSize / 2,
                                                                           self.viewCell.frame.origin.y - shadowSize / 2,
                                                                           self.viewCell.frame.size.width + shadowSize,
                                                                           self.viewCell.frame.size.height + shadowSize)];
    self.viewCell.layer.masksToBounds = NO;
    self.viewCell.layer.shadowColor = [UIColor blackColor].CGColor;
    self.viewCell.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.viewCell.layer.shadowOpacity = 0.2f;
    self.viewCell.layer.shadowPath = shadowPath.CGPath;

    
//    self.viewCell.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.viewCell.layer.shadowOpacity = 0.2f;
//    self.viewCell.layer.shadowRadius = 2.0;
//    self.viewCell.layer.shadowOpacity = 0.2f;
//    self.viewCell.layer.shadowOffset = CGSizeMake(1.0, 1.0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
