//
//  TodayBookingBACVC.h
//  Sales App
//
//  Created by Infinitum on 27/12/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodaysFollowupsBACCCell.h"
#import "ChangeStatusVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface TodayBookingBACVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UIPopoverControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnHomeVisit;
@property (weak, nonatomic) IBOutlet UITableView *myTableview;
@property (weak, nonatomic) IBOutlet UIButton *btnFollowup;
@property NSString *ocrStr;
@property NSString *str;
@property NSString *sdcStr;
@end

NS_ASSUME_NONNULL_END
