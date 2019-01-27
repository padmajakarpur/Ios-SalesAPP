//
//  ROXViewController.h
//  Sales App
//
//  Created by Infinitum on 10/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ACFloatingTextField.h>
#import "CustomIOS7AlertView.h"
#import <ACFloatingTextField.h>
#import "DownPicker.h"
@interface ROXViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    int index;
}
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome,*teamtableview;
@property(nonatomic,retain) IBOutlet UIView * bgview,*demoView;
@property(nonatomic,retain) ACFloatingTextField *projectstxt,*statustxt,*followupdattxt,*countxt;
@property(nonatomic,retain) UIToolbar *projectoolbar;
@property(nonatomic,retain)NSMutableArray *projectarr,*totalarr;
@property(nonatomic,retain)NSString *projectstr;
@property(nonatomic,retain) IBOutlet UIPickerView *projectpicker;
@property (retain, nonatomic) IBOutlet NSMutableArray *bookingarr;
@property(nonatomic,retain) CustomIOS7AlertView *TakePhotoView;
@property(nonatomic,retain) ACFloatingTextField *remarktxt;
@property (retain, nonatomic)  IBOutlet UITextField *searchtext;
@property (retain, nonatomic)  IBOutlet UIView * searchview;
@property(nonatomic,retain) UIToolbar*numberToolbarzip;
@property (strong, nonatomic) DownPicker *downPicker;
@property(nonatomic,retain) IBOutlet UIDatePicker *  datePicker;

@end
