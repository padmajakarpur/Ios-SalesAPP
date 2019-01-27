//
//  SalesTableViewCell.h
//  Sales App
//
//  Created by Infinitum on 07/01/19.
//  Copyright © 2019 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SalesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UILabel *lblBookingNo;
@property (weak, nonatomic) IBOutlet UILabel *lblUnitNo;
@property (weak, nonatomic) IBOutlet UILabel *lblMgEmpName;
@property (weak, nonatomic) IBOutlet UILabel *lblAmt;
@property (weak, nonatomic) IBOutlet UILabel *lblChequeDate;
@property (weak, nonatomic) IBOutlet UILabel *lblProjName;
@property (weak, nonatomic) IBOutlet UILabel *lblCustName;
@property (weak, nonatomic) IBOutlet UILabel *lblSrEmpName;
@property (weak, nonatomic) IBOutlet UILabel *lblChangeNo;

@end

NS_ASSUME_NONNULL_END
