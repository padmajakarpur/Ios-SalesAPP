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
@property (weak, nonatomic) IBOutlet UILabel *lblFollowupStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblUnitNo;
@property (weak, nonatomic) IBOutlet UILabel *lblMobNo;

@end

NS_ASSUME_NONNULL_END
