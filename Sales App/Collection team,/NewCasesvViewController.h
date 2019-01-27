//
//  NewCasesvViewController.h
//  Sales App
//
//  Created by Infinitum on 25/06/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"
#import <ACFloatingTextField.h>
#import "DownPicker.h"
#import "AppDelegate.h"
@interface NewCasesvViewController : UIViewController
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property(nonatomic,retain) IBOutlet NSMutableArray *teamarr;
@property(nonatomic,retain) IBOutlet  NSString * str,*columnstr,*rowstr,*groupstr,*statusstr;
@property(nonatomic,retain) CustomIOS7AlertView *TakePhotoView;
@property(nonatomic,retain) IBOutlet ACFloatingTextField * statustxt;
@property (strong, nonatomic) DownPicker *downPicker;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain) AppDelegate *appDelegate;
@end
