//
//  EvenrtDatailsViewController.h
//  Sales App
//
//  Created by Infinitum on 19/06/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ACFloatingTextField.h>
#import "DownPicker.h"
#import "AppDelegate.h"
@interface EvenrtDatailsViewController : UIViewController
@property(nonatomic,retain) IBOutlet NSMutableDictionary * dict;
@property(nonatomic,retain) IBOutlet UIScrollView * scrollview;
@property(nonatomic,retain) IBOutlet UIView * bgview,*demoView;
@property(nonatomic,retain) ACFloatingTextField *nametxt,*mobiletxt,*emailtxt,*unitnotxt,*projecttxt,*nopartxt,*alternatetxt;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain) UIToolbar*numberToolbarzip;
@property (strong, nonatomic) DownPicker *downPicker;
@property(nonatomic,retain)AppDelegate * appDelegate;
@property(nonatomic,retain) IBOutlet NSMutableArray *projectarr;
@property(nonatomic,retain) IBOutlet NSString * projectidstr;
@end
