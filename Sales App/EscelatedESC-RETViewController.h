//
//  EscelatedESC-RETViewController.h
//  Sales App
//
//  Created by Infinitum on 11/06/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"
#import <ACFloatingTextField.h>
#import "TodayBookingBACVC.h"
#import "SalesVC.h"

@interface EscelatedESC_RETViewController : UIViewController
{
    int index;
}
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property(nonatomic,retain)NSString *comestr;
@property (retain, nonatomic) IBOutlet UIScrollView * teamtableview;
@property(nonatomic,retain)NSMutableArray *teamarr,*bookingarr;
@property(nonatomic,retain) CustomIOS7AlertView *TakePhotoView;
@property(nonatomic,retain) IBOutlet UIView *demoView;
@property (weak, nonatomic) IBOutlet UIButton *btn2Dashboard;
@property (weak, nonatomic) IBOutlet UIButton *btn3Dashboard;
@property(nonatomic,retain) ACFloatingTextField *remarktxt;
@property (weak, nonatomic) IBOutlet UIButton *btn1Dashboard;
@property (weak, nonatomic) IBOutlet UIButton *btn4Dashboard;
@property (retain, nonatomic) IBOutlet UISegmentedControl * segmentedControl;
@end
