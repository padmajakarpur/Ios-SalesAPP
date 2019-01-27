//
//  FollowUpEditViewController.h
//  Sales App
//
//  Created by Infinitum on 21/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ACFloatingTextField.h>
@interface FollowUpEditViewController : UIViewController
@property (strong, nonatomic)IBOutlet NSMutableDictionary *dict,*submitdict;
@property (strong, nonatomic)IBOutlet ACFloatingTextField *Statustxt,*datetxt,*reasontxt,*remarktxt;
@property(nonatomic,retain) UIToolbar*numberToolbarzip;
@property(nonatomic,retain) IBOutlet UIDatePicker *  datePicker;
@property(nonatomic,retain) UIToolbar *statustoolbar;
@property(nonatomic,retain)NSMutableArray *statusarr,*historyarr;
@property(nonatomic,retain)NSString *statustr,*formatdatestr,*comestr;
@property(nonatomic,retain) IBOutlet UIPickerView *statuspicker;
@property(nonatomic,retain) IBOutlet UIButton *Createvoucherbtn,*vieshistorybtn;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property(nonatomic,retain) IBOutlet NSMutableArray * listarr;

@end
