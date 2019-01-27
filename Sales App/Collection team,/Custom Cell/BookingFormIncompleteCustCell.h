//
//  BookingFormIncompleteCustCell.h
//  Sales App
//
//  Created by Infinitum on 12/01/19.
//  Copyright © 2019 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookingFormIncompleteCustCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblBookingNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblProjName;
@property (weak, nonatomic) IBOutlet UILabel *lblBookingDate;
@property (weak, nonatomic) IBOutlet UILabel *lblCustomerType;
@property (weak, nonatomic) IBOutlet UILabel *lblUnitNo;
@property (weak, nonatomic) IBOutlet UILabel *lblCustName;
@property (weak, nonatomic) IBOutlet UILabel *lblScheme;
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UIButton *btnChangeStatusBkng;
@property (weak, nonatomic) IBOutlet UIButton *btnCallBkng;

@end

NS_ASSUME_NONNULL_END
