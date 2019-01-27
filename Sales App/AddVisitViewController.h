//
//  AddVisitViewController.h
//  Sales App
//
//  Created by Infinitum on 16/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <ACFloatingTextField.h>
#include "AppDelegate.h"
@interface AddVisitViewController : UIViewController
@property(nonatomic,retain) ACFloatingTextField *prospextTxt,*mobiletxt,*projecttxt,*attendtxt,*assignedtxt,*prospestagetxt,*remarktxt,*unitnotxt,*scheduledatetxt;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIDatePicker *  datePicker;
@property(nonatomic,retain) UIToolbar*numberToolbarzip;
@property(nonatomic,retain) UIToolbar *projectoolbar,*leadstoolbar,*stagetoolbar;
@property(nonatomic,retain)NSMutableArray *projectarr,*prosjectidarr,*leadsarr;
@property(nonatomic,retain)NSString *projectstr,*leadstr;
@property(nonatomic,retain)AppDelegate * appDelegate;
@property(nonatomic,retain) IBOutlet UIPickerView *projectpicker,*leadspicker;
@property(nonatomic,retain) IBOutlet NSMutableDictionary *leadsdict;

@end
