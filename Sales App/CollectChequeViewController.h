//
//  CollectChequeViewController.h
//  Sales App
//
//  Created by Infinitum on 03/08/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ACFloatingTextField.h>
#import "DownPicker.h"
@interface CollectChequeViewController : UIViewController
@property(nonatomic,retain) ACFloatingTextField * typetxt,*amounttxt,*chequetxt,*banktxt,*branchtxt,*datetxt;
@property(nonatomic,retain) UIImageView * chequeimag;
@property(nonatomic,retain) NSMutableDictionary * dict;
@property (strong, nonatomic)IBOutlet DownPicker *typedownpicker;
@property(nonatomic,retain) IBOutlet UIDatePicker *  datePicker;
@property(nonatomic,retain) UIToolbar*numberToolbarzip;
@property(nonatomic,retain) UIActivityIndicatorView * indicator;
@end
