//
//  Front_OfficeViewController.h
//  Sales App
//
//  Created by Infinitum on 06/04/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ACFloatingTextField.h>
#import "AppDelegate.h"
#import "CustomIOS7AlertView.h"
#import "DownPicker.h"
@interface Front_OfficeViewController : UIViewController
{
    NSInteger * index;
}
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet  ACFloatingTextField *mobiletxt,*projectstxt;
@property(nonatomic,retain) UIToolbar*numberToolbarzip;
@property(nonatomic,retain) UIToolbar *projectoolbar,*assigntoolbar;
@property(nonatomic,retain)NSMutableArray *projectarr,*assignsalesarr,*prosjectidarr,*visitarr,*leadarr,*assignarr,*assignidarr;
@property(nonatomic,retain)NSString *projectstr,*assignstr,*projectidstr;
@property(nonatomic,retain) IBOutlet UIPickerView *projectpicker,*assignpicker;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (retain, nonatomic) IBOutlet UIView *headerView,*demoView,*bgview;
@property(nonatomic,retain)AppDelegate * appDelegate;
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property(nonatomic,retain) IBOutlet UILabel *betwlbl;
@property(nonatomic,retain)IBOutlet UITextField * Assigntxt;
@property(nonatomic,retain)IBOutlet UIButton *assignbtn;
@property(nonatomic,retain)IBOutlet ACFloatingTextField * custmortypetxt,*purposetxt,*unitnotxt,*custprojectxt;
@property(nonatomic,retain) CustomIOS7AlertView *TakePhotoView;
@property (strong, nonatomic)IBOutlet DownPicker *projectdropdown,*Custypedropdown,*purposedropdown;
@end
