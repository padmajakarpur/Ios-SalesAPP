//
//  MyLeadsViewController.h
//  Sales App
//
//  Created by Infinitum on 08/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ACFloatingTextField.h>
#import "AppDelegate.h"

@interface MyLeadsViewController : UIViewController
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property(nonatomic,retain) IBOutlet UIView * bgview,*demoView;
@property(nonatomic,retain) ACFloatingTextField *prostatustxt,*prostagetxt,*projectstxt,*flatsizetxt;
@property(nonatomic,retain) UIToolbar * stagestoolbar,*statustoolbar,*projectoolbar,*flatsizetoolbar;
@property(nonatomic,retain)NSMutableArray *stagearr,*statusarr,*projectarr,*flatarr;
@property(nonatomic,retain)NSString * statusstr,*stagestr,*flatstr,*projectstr;
@property(nonatomic,retain) IBOutlet UIPickerView *statuwpicker,*stegespickeer,*flatpicker,*projectpicker;
@property(nonatomic,retain)AppDelegate * appDelegate;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (retain, nonatomic)  IBOutlet UIView * searchview;
@property (retain, nonatomic)  IBOutlet UITextField *searchtext;
@property (retain, nonatomic)  IBOutlet NSMutableArray * leadsarr,*totalarr;

@end
