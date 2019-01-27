//
//  TodaysFollowupsBACCCell.h
//  Sales App
//
//  Created by Infinitum on 01/01/19.
//  Copyright © 2019 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeStatusVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface TodaysFollowupsBACCCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblProjectName;
@property (weak, nonatomic) IBOutlet UIView *viewCell;
@property (weak, nonatomic) IBOutlet UILabel *lblTotCollection;
@property (weak, nonatomic) IBOutlet UILabel *lblBACAmt;
@property (weak, nonatomic) IBOutlet UILabel *lblCustName;
@property (weak, nonatomic) IBOutlet UILabel *lblFollStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblFollDate;
@property (weak, nonatomic) IBOutlet UILabel *lblUnitNo;
@property (weak, nonatomic) IBOutlet UILabel *lblCollBalance;
@property (weak, nonatomic) IBOutlet UILabel *lblBACBal;
@property (weak, nonatomic) IBOutlet UILabel *lblMobNo;
@property (weak, nonatomic) IBOutlet UILabel *lblBookingStatus;
//Title label
@property (weak, nonatomic) IBOutlet UILabel *lblTitleAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleBalance;
@property (weak, nonatomic) IBOutlet UIButton *btnChangeStatus;
@property (weak, nonatomic) IBOutlet UIButton *btnCall;

@end

NS_ASSUME_NONNULL_END
