//
//  BackOffCustomerListViewController.h
//  Sales App
//
//  Created by Infinitum on 19/10/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ACFloatingTextField.h>

NS_ASSUME_NONNULL_BEGIN

@interface BackOffCustomerListViewController : UIViewController
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property(nonatomic,retain) NSMutableString *processstr;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (retain, nonatomic) IBOutlet UIView *demoView,*bgview;
@property(nonatomic,retain)IBOutlet  ACFloatingTextField *remarktxt,*statustxt,*datetxt;
@property(nonatomic,retain) IBOutlet UIDatePicker *  datePicker;
@property(nonatomic,retain) UIToolbar *numberToolbarzip;
@end

NS_ASSUME_NONNULL_END
