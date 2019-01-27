//
//  DocumentsViewController.h
//  Sales App
//
//  Created by Infinitum on 25/06/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ACFloatingTextField.h>
#import "DownPicker.h"
@interface DocumentsViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIScrollView * teamtableview;
@property(nonatomic,retain) IBOutlet UITextField * bankloantxt,*loginnumbertxt,*executivedraftxt,*remark1txt,*remark2txt,*statustxt,*fudatetxt,*sactionamtxt,*sactiondatetxt,*expiraydatext,*loanamttxt;
@property(nonatomic,retain) IBOutlet UIImageView *dashbgimageview;
@property(nonatomic,retain) IBOutlet UITextView * historytextvie;
@property(nonatomic,retain) IBOutlet NSMutableArray *teamarr,*statusarr;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (retain, nonatomic) IBOutlet NSString * comstr,*sanctiondatestr,*fudatestr,*expdatestr,*groupstr;
@property (retain, nonatomic) IBOutlet NSMutableDictionary * userinfodict,*infodict;
@property (strong, nonatomic) DownPicker *downPicker;
@property(nonatomic,retain) IBOutlet UIDatePicker *  datePicker;
@property(nonatomic,retain) UIToolbar*numberToolbarzip;

@end
