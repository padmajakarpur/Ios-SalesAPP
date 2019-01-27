//
//  FilterInvinteryViewController.h
//  Sales App
//
//  Created by Infinitum on 17/04/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ACFloatingTextField.h>
#import "TTRangeSlider.h"
#import "AppDelegate.h"
@interface FilterInvinteryViewController : UIViewController<TTRangeSliderDelegate>
@property(nonatomic,retain) ACFloatingTextField *projectxt,*protypetxt,*sizetxt,*valuetx;
@property(nonatomic,retain) UIToolbar *projectoolbar,*typetoolbar,*sizetoolbar,*buildingtoolbar;
@property(nonatomic,retain)NSMutableArray *projectarr,*projectidarr,*typearr,*sizearr,*totalprojectarr,*buildingarr,*floorarr,*buildingidarr;
@property(nonatomic,retain)NSString *projectstr,*projectidstr,*typestr,*sizestr,*buildingstr,*buildingidstr,*minvaluestr,*maxvaluestr,*minsizestr,*maxsizestr,*switchstr;
@property(nonatomic,retain) IBOutlet UIPickerView *projectpicker,*typepicker,*sizepicker,*buildingpicker;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain) UIToolbar*numberToolbarzip;
@property (retain, nonatomic) IBOutlet TTRangeSlider *rangeSliderCurrency,*rangeSlider;
@property (retain, nonatomic) IBOutlet UIView *swirchview;
@property(nonatomic,retain)AppDelegate * appDelegate;
@property (retain, nonatomic) IBOutlet UISwitch * privateSwitch;
@property (retain, nonatomic) IBOutlet UIButton *checkboxbtn,*checkboxbtn2;

@end
