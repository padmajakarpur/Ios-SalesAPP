//
//  DocFollowupCell.h
//  Sales App
//
//  Created by Infinitum on 27/02/19.
//  Copyright © 2019 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DocFollowupCell : UITableViewCell{
    
}
@property (weak, nonatomic) IBOutlet UILabel *lblProjName;
@property (weak, nonatomic) IBOutlet UILabel *lblCustName;

@property (weak, nonatomic) IBOutlet UILabel *lblUnitNo;
@property (weak, nonatomic) IBOutlet UILabel *lblMobNo;

@property (weak, nonatomic) IBOutlet UIButton *btnUploadDoc;

@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UILabel *lblBookingNo;
@property (weak, nonatomic) IBOutlet UILabel *lblBookingDate;

@end

NS_ASSUME_NONNULL_END
