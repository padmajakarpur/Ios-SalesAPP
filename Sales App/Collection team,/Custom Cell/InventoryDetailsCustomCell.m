//
//  InventoryDetailsCustomCell.m
//  Sales App
//
//  Created by Infinitum on 13/04/19.
//  Copyright © 2019 Infinitumus.com. All rights reserved.
//

#import "InventoryDetailsCustomCell.h"

@implementation InventoryDetailsCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _myView.layer.borderColor = [UIColor grayColor].CGColor;
    _myView.layer.borderWidth = 1.0f;
    _myView.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
