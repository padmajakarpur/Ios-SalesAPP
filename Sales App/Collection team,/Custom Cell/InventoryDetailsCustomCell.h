//
//  InventoryDetailsCustomCell.h
//  Sales App
//
//  Created by Infinitum on 13/04/19.
//  Copyright © 2019 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InventoryDetailsCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UILabel *lblProjName;
@property (weak, nonatomic) IBOutlet UILabel *lblUnit_No;
@property (weak, nonatomic) IBOutlet UILabel *lblUnit_Status;
@property (weak, nonatomic) IBOutlet UILabel *lblSaleable_Area;
@property (weak, nonatomic) IBOutlet UILabel *lblAgreementValue;
@property (weak, nonatomic) IBOutlet UILabel *lblTotAmtCost;
@property (weak, nonatomic) IBOutlet UILabel *lblCarpet_Area;
@property (weak, nonatomic) IBOutlet UILabel *lblUnit_Type;
@property (weak, nonatomic) IBOutlet UILabel *lblFlatCat;

@end

NS_ASSUME_NONNULL_END
