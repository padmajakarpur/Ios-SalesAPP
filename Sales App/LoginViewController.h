//
//  LoginViewController.h
//  Sales App
//
//  Created by Infinitum on 06/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "RPFloatingPlaceholderTextField.h"
#import "CustomIOS7AlertView.h"
#import "AppDelegate.h"

#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import "PaymentsSDK.h"

@interface LoginViewController : UIViewController<PGTransactionDelegate, UITextFieldDelegate, UIActionSheetDelegate>

@property(nonatomic,retain) IBOutlet RPFloatingPlaceholderTextField * emailTxt,*passwordeTxt,*usernametxt,*mobtxt;
@property(nonatomic,retain)AppDelegate * appDelegate;
@property(nonatomic,retain) UIToolbar*numberToolbarzip;
@property(nonatomic,retain) CustomIOS7AlertView *TakePhotoView;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain)IBOutlet UIButton *buyBtn;
@property(nonatomic,retain)NSString *reference_no;
@property (nonatomic, strong) IBOutlet UITextField *merchantIDTextField;
@property (nonatomic, strong) IBOutlet UITextField *customerIDTextField;
@property (nonatomic, strong) IBOutlet UITextField *transactionAmountTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *custMobileNoTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *custeMailTextField;
@property (nonatomic, strong) IBOutlet UITextField *channelIDTextField;
@property (nonatomic, strong) IBOutlet UITextField *industryTypeIDTextField;
@property (nonatomic, strong) IBOutlet UITextField *websiteTextField;
@property (nonatomic, strong) IBOutlet UITextField *themeTextField;
@property (nonatomic, strong) IBOutlet UITextField *orderIDField;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *checksumGenLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *checksumGenTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *checksumValidLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *checksumValidTextfield;

@end
