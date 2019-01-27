//
//  RegisterViewController.h
//  Sales App
//
//  Created by Infinitum on 09/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPFloatingPlaceholderTextField.h"

@interface RegisterViewController : UIViewController
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) UIToolbar*numberToolbarzip;
@property(nonatomic,retain)  RPFloatingPlaceholderTextField *nametxt,*emailtxt,*passwordeTxt,*confrmpasstxt,*reratxt,*contacttxt,*companytxt,*areofoperationtxt,*pantxt,*yearofexperiancetxt,*noofemployetxt,*addrtxt,*countrytxt,*stattxt,*banknametxt,*bankholdertxt,*accountnotxt,*accounttxt,*IFSCtxt,*BranchAddress,*otptext;
@property(nonatomic,retain) UIImageView *panimageview,*cacelledcheckimage;
@property(nonatomic,readwrite) int type;
@property(nonatomic,retain) UILabel * bankdetailslbl;
@property(nonatomic,retain) UIButton *cancelchckbtn,*resendbtn,*submitbtn;
@end
