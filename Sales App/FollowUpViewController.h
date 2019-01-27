//
//  FollowUpViewController.h
//  Sales App
//
//  Created by Infinitum on 09/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ACFloatingTextField.h>
@interface FollowUpViewController : UIViewController
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain) IBOutlet UIView * bgview,*demoView;
@property(nonatomic,retain) ACFloatingTextField *prostatustxt,*projectstxt,*flatsizetxt,*Fromdatetxt,*todatetxt;
@property(nonatomic,retain) UIToolbar *statustoolbar,*projectoolbar;
@property(nonatomic,retain)NSMutableArray *statusarr,*projectarr,*followuparr;
@property(nonatomic,retain)NSString * statusstr,*projectstr,*comestr;;
@property(nonatomic,retain) IBOutlet UIPickerView *statuwpicker,*projectpicker;
@property (retain, nonatomic)  IBOutlet UIView * searchview;
@property (retain, nonatomic)  IBOutlet UITextField *searchtext;
@property (retain, nonatomic)  IBOutlet NSMutableArray *totalarr;
@property NSString *followupType;
@end
