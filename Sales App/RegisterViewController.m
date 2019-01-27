//
//  RegisterViewController.m
//  Sales App
//
//  Created by Infinitum on 09/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIColor+Expanded.h"
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize scrollView,numberToolbarzip,nametxt,emailtxt,passwordeTxt,contacttxt,confrmpasstxt,reratxt,companytxt,areofoperationtxt,pantxt,yearofexperiancetxt,noofemployetxt,addrtxt,countrytxt,stattxt,bankdetailslbl,banknametxt,bankholdertxt,accounttxt,IFSCtxt,BranchAddress,cacelledcheckimage,panimageview,cancelchckbtn,otptext,submitbtn,resendbtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#ED2026"];
    
    UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*.03,screenRect.size.width*.64,screenRect.size.height*.07)];
    titlelable.textAlignment = NSTextAlignmentCenter;
    titlelable.text=@"Register";
    titlelable.textColor=[UIColor whiteColor];
    [titlelable setBackgroundColor:[UIColor clearColor]];
    titlelable.font=[UIFont fontWithName:@"Open Sans" size:22];
    [self.view addSubview:titlelable];
    
    UIButton*  backBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.03,screenRect.size.width*0.20,screenRect.size.height*.07)];
    //  [backBtn setTitle:@"\uE5C4" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backbtn) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"arrow_back_white.png"] forState:UIControlStateNormal];
    [navigationView addSubview:backBtn];
    
    UIButton *savebtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.8,screenRect.size.height*0.03,screenRect.size.width*0.20,screenRect.size.height*.07)];
    [savebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    savebtn.layer.cornerRadius=07;
    savebtn.layer.masksToBounds=YES;
    [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    savebtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [savebtn setTitle:@"\uE161" forState:UIControlStateNormal];
    [navigationView addSubview:savebtn];

    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, screenRect.size.height*0.10, screenRect.size.width, screenRect.size.height*0.90)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.scrollEnabled = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:scrollView];
    
    int hight=screenRect.size.height*0.04;
    
   nametxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    nametxt.textAlignment=NSTextAlignmentLeft;
    nametxt.delegate = self;
    nametxt.textColor=[UIColor blackColor];
    [nametxt setBackgroundColor:[UIColor clearColor]];
    nametxt.leftViewMode = UITextFieldViewModeAlways;
    [nametxt setKeyboardType:UIKeyboardTypeEmailAddress];
    nametxt.returnKeyType=UIReturnKeyDone;
    nametxt.floatingLabelActiveTextColor = [UIColor redColor];
    nametxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders3 = [CALayer layer];
    bottomBorders3.frame = CGRectMake(0.0f, nametxt.frame.size.height - 5, nametxt.frame.size.width, 1.5f);
    bottomBorders3.backgroundColor = [UIColor redColor].CGColor;
    [nametxt.layer addSublayer:bottomBorders3];
    nametxt.placeholder=@"Name*";
    nametxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:nametxt];
    
    hight=hight+ screenRect.size.height*0.12;
    
      emailtxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    emailtxt.textAlignment=NSTextAlignmentLeft;
    emailtxt.delegate = self;
    emailtxt.textColor=[UIColor blackColor];
    [emailtxt setBackgroundColor:[UIColor clearColor]];
    emailtxt.leftViewMode = UITextFieldViewModeAlways;
    [emailtxt setKeyboardType:UIKeyboardTypeEmailAddress];
    emailtxt.returnKeyType=UIReturnKeyDone;
    emailtxt.floatingLabelActiveTextColor = [UIColor redColor];
    emailtxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders1 = [CALayer layer];
    bottomBorders1.frame = CGRectMake(0.0f, nametxt.frame.size.height - 5, nametxt.frame.size.width, 1.5f);
    bottomBorders1.backgroundColor = [UIColor redColor].CGColor;
    [emailtxt.layer addSublayer:bottomBorders1];
    emailtxt.placeholder=@"Email*";
    emailtxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:emailtxt];
    
    hight=hight+ screenRect.size.height*0.12;

      passwordeTxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    passwordeTxt.textAlignment=NSTextAlignmentLeft;
    passwordeTxt.delegate = self;
    passwordeTxt.textColor=[UIColor blackColor];
    [passwordeTxt setBackgroundColor:[UIColor clearColor]];
    passwordeTxt.leftViewMode = UITextFieldViewModeAlways;
    [passwordeTxt setKeyboardType:UIKeyboardTypeEmailAddress];
    passwordeTxt.returnKeyType=UIReturnKeyDone;
    passwordeTxt.secureTextEntry=YES;
    passwordeTxt.font = [UIFont systemFontOfSize:14];
    passwordeTxt.floatingLabelActiveTextColor = [UIColor redColor];
    passwordeTxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders2 = [CALayer layer];
    bottomBorders2.frame = CGRectMake(0.0f, passwordeTxt.frame.size.height - 5, passwordeTxt.frame.size.width, 1.5f);
    bottomBorders2.backgroundColor = [UIColor redColor].CGColor;
    [passwordeTxt.layer addSublayer:bottomBorders2];
    passwordeTxt.placeholder=@"Password*";
    [scrollView addSubview:passwordeTxt];
    
    hight=hight+ screenRect.size.height*0.12;
    
     confrmpasstxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    confrmpasstxt.textAlignment=NSTextAlignmentLeft;
    confrmpasstxt.delegate = self;
    confrmpasstxt.textColor=[UIColor blackColor];
    [confrmpasstxt setBackgroundColor:[UIColor clearColor]];
    confrmpasstxt.leftViewMode = UITextFieldViewModeAlways;
    [confrmpasstxt setKeyboardType:UIKeyboardTypeEmailAddress];
    confrmpasstxt.returnKeyType=UIReturnKeyDone;
    confrmpasstxt.secureTextEntry=YES;
    confrmpasstxt.font = [UIFont systemFontOfSize:14];
    confrmpasstxt.floatingLabelActiveTextColor = [UIColor redColor];
    confrmpasstxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders4 = [CALayer layer];
    bottomBorders4.frame = CGRectMake(0.0f, confrmpasstxt.frame.size.height - 5, confrmpasstxt.frame.size.width, 1.5f);
    bottomBorders4.backgroundColor = [UIColor redColor].CGColor;
    [confrmpasstxt.layer addSublayer:bottomBorders4];
    confrmpasstxt.placeholder=@"Confirm Password*";
    [scrollView addSubview:confrmpasstxt];
    
    hight=hight+ screenRect.size.height*0.12;
    
      reratxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    reratxt.textAlignment=NSTextAlignmentLeft;
    reratxt.delegate = self;
    reratxt.textColor=[UIColor blackColor];
    [reratxt setBackgroundColor:[UIColor clearColor]];
    reratxt.leftViewMode = UITextFieldViewModeAlways;
    [reratxt setKeyboardType:UIKeyboardTypeEmailAddress];
    reratxt.returnKeyType=UIReturnKeyDone;
    reratxt.floatingLabelActiveTextColor = [UIColor redColor];
    reratxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders5 = [CALayer layer];
    bottomBorders5.frame = CGRectMake(0.0f, reratxt.frame.size.height - 5, reratxt.frame.size.width, 1.5f);
    bottomBorders5.backgroundColor = [UIColor redColor].CGColor;
    [reratxt.layer addSublayer:bottomBorders5];
    reratxt.placeholder=@"Rera Number";
    reratxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:reratxt];
    
    hight=hight+ screenRect.size.height*0.12;
    
   contacttxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    contacttxt.textAlignment=NSTextAlignmentLeft;
    contacttxt.delegate = self;
    contacttxt.textColor=[UIColor blackColor];
    [contacttxt setBackgroundColor:[UIColor clearColor]];
    contacttxt.leftViewMode = UITextFieldViewModeAlways;
    [contacttxt setKeyboardType:UIKeyboardTypeEmailAddress];
    contacttxt.returnKeyType=UIReturnKeyDone;
    contacttxt.floatingLabelActiveTextColor = [UIColor redColor];
    contacttxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders6 = [CALayer layer];
    bottomBorders6.frame = CGRectMake(0.0f, contacttxt.frame.size.height - 5, contacttxt.frame.size.width, 1.5f);
    bottomBorders6.backgroundColor = [UIColor redColor].CGColor;
    [contacttxt.layer addSublayer:bottomBorders6];
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.barStyle = UIBarStyleBlackOpaque;
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbarzip sizeToFit];
    numberToolbarzip.tintColor=[UIColor whiteColor];
    contacttxt.inputAccessoryView = numberToolbarzip;
    contacttxt.leftViewMode = UITextFieldViewModeAlways;
    contacttxt.keyboardType = UIKeyboardTypeDecimalPad;
    contacttxt.placeholder = @"Mobile Number*";
    [scrollView addSubview:contacttxt];
    hight=hight+ screenRect.size.height*0.12;
    
    companytxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    companytxt.textAlignment=NSTextAlignmentLeft;
    companytxt.delegate = self;
    companytxt.textColor=[UIColor blackColor];
    [companytxt setBackgroundColor:[UIColor clearColor]];
    companytxt.leftViewMode = UITextFieldViewModeAlways;
    [companytxt setKeyboardType:UIKeyboardTypeEmailAddress];
    companytxt.returnKeyType=UIReturnKeyDone;
    companytxt.floatingLabelActiveTextColor = [UIColor redColor];
    companytxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders7 = [CALayer layer];
    bottomBorders7.frame = CGRectMake(0.0f, companytxt.frame.size.height - 5, companytxt.frame.size.width, 1.5f);
    bottomBorders7.backgroundColor = [UIColor redColor].CGColor;
    [companytxt.layer addSublayer:bottomBorders7];
    companytxt.placeholder=@"Company*";
    companytxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:companytxt];
    
    hight=hight+ screenRect.size.height*0.12;
    areofoperationtxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    areofoperationtxt.textAlignment=NSTextAlignmentLeft;
    areofoperationtxt.delegate = self;
    areofoperationtxt.textColor=[UIColor blackColor];
    [areofoperationtxt setBackgroundColor:[UIColor clearColor]];
    areofoperationtxt.leftViewMode = UITextFieldViewModeAlways;
    [areofoperationtxt setKeyboardType:UIKeyboardTypeEmailAddress];
    areofoperationtxt.returnKeyType=UIReturnKeyDone;
    areofoperationtxt.floatingLabelActiveTextColor = [UIColor redColor];
    areofoperationtxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders8 = [CALayer layer];
    bottomBorders8.frame = CGRectMake(0.0f, areofoperationtxt.frame.size.height - 5, areofoperationtxt.frame.size.width, 1.5f);
    bottomBorders8.backgroundColor = [UIColor redColor].CGColor;
    [areofoperationtxt.layer addSublayer:bottomBorders8];
    areofoperationtxt.placeholder=@"Area of Operations*";
    areofoperationtxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:areofoperationtxt];
    
    hight=hight+ screenRect.size.height*0.12;
    
    pantxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    pantxt.textAlignment=NSTextAlignmentLeft;
    pantxt.delegate = self;
    pantxt.textColor=[UIColor blackColor];
    [pantxt setBackgroundColor:[UIColor clearColor]];
    pantxt.leftViewMode = UITextFieldViewModeAlways;
    [pantxt setKeyboardType:UIKeyboardTypeEmailAddress];
    pantxt.returnKeyType=UIReturnKeyDone;
    pantxt.floatingLabelActiveTextColor = [UIColor redColor];
    pantxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders9 = [CALayer layer];
    bottomBorders9.frame = CGRectMake(0.0f, areofoperationtxt.frame.size.height - 5, areofoperationtxt.frame.size.width, 1.5f);
    bottomBorders9.backgroundColor = [UIColor redColor].CGColor;
    [pantxt.layer addSublayer:bottomBorders9];
    pantxt.placeholder=@"PAN No*";
    pantxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:pantxt];
    
    hight=hight+ screenRect.size.height*0.12;
    
    UIButton *uplaadpanbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,hight+screenRect.size.height*0.01,screenRect.size.width*0.30,screenRect.size.height*0.12)];
    [uplaadpanbtn setClipsToBounds:YES];
    uplaadpanbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    uplaadpanbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [uplaadpanbtn setTitle:@"Upload\n PAN" forState:UIControlStateNormal];
    [uplaadpanbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [uplaadpanbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    uplaadpanbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    uplaadpanbtn.tag=0;
    [uplaadpanbtn addTarget:self action:@selector(showColorsActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    [uplaadpanbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.05]];
    [uplaadpanbtn setBackgroundColor:[UIColor colorWithHexString:@"#b3b3b3"]] ;
    [scrollView addSubview:uplaadpanbtn];

    panimageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.45,hight, screenRect.size.width*0.50,screenRect.size.height*0.15)];
    panimageview.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:panimageview];
    panimageview.backgroundColor=[UIColor clearColor];

    hight=hight+ screenRect.size.height*0.17;

    yearofexperiancetxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    yearofexperiancetxt.textAlignment=NSTextAlignmentLeft;
    yearofexperiancetxt.delegate = self;
    yearofexperiancetxt.textColor=[UIColor blackColor];
    [yearofexperiancetxt setBackgroundColor:[UIColor clearColor]];
    yearofexperiancetxt.leftViewMode = UITextFieldViewModeAlways;
    [yearofexperiancetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    yearofexperiancetxt.returnKeyType=UIReturnKeyDone;
    yearofexperiancetxt.floatingLabelActiveTextColor = [UIColor redColor];
    yearofexperiancetxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders10 = [CALayer layer];
    bottomBorders10.frame = CGRectMake(0.0f, yearofexperiancetxt.frame.size.height - 5, yearofexperiancetxt.frame.size.width, 1.5f);
    bottomBorders10.backgroundColor = [UIColor redColor].CGColor;
    [yearofexperiancetxt.layer addSublayer:bottomBorders10];
    yearofexperiancetxt.placeholder=@"Year of experiance";
    yearofexperiancetxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:yearofexperiancetxt];
    
    hight=hight+ screenRect.size.height*0.12;
    
    noofemployetxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    noofemployetxt.textAlignment=NSTextAlignmentLeft;
    noofemployetxt.delegate = self;
    noofemployetxt.textColor=[UIColor blackColor];
    [noofemployetxt setBackgroundColor:[UIColor clearColor]];
    noofemployetxt.leftViewMode = UITextFieldViewModeAlways;
    [noofemployetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    noofemployetxt.returnKeyType=UIReturnKeyDone;
    noofemployetxt.floatingLabelActiveTextColor = [UIColor redColor];
    noofemployetxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders11 = [CALayer layer];
    bottomBorders11.frame = CGRectMake(0.0f, yearofexperiancetxt.frame.size.height - 5, noofemployetxt.frame.size.width, 1.5f);
    bottomBorders11.backgroundColor = [UIColor redColor].CGColor;
    [noofemployetxt.layer addSublayer:bottomBorders11];
    noofemployetxt.placeholder=@"No of Employess";
    noofemployetxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:noofemployetxt];
    
    hight=hight+ screenRect.size.height*0.12;
    
    addrtxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    addrtxt.textAlignment=NSTextAlignmentLeft;
    addrtxt.delegate = self;
    addrtxt.textColor=[UIColor blackColor];
    [addrtxt setBackgroundColor:[UIColor clearColor]];
    addrtxt.leftViewMode = UITextFieldViewModeAlways;
    [addrtxt setKeyboardType:UIKeyboardTypeEmailAddress];
    addrtxt.returnKeyType=UIReturnKeyDone;
    addrtxt.floatingLabelActiveTextColor = [UIColor redColor];
    addrtxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders12 = [CALayer layer];
    bottomBorders12.frame = CGRectMake(0.0f, addrtxt.frame.size.height - 5, addrtxt.frame.size.width, 1.5f);
    bottomBorders12.backgroundColor = [UIColor redColor].CGColor;
    [addrtxt.layer addSublayer:bottomBorders12];
    addrtxt.placeholder=@"Address";
    addrtxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:addrtxt];
    
    hight=hight+ screenRect.size.height*0.12;
    
    countrytxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    countrytxt.textAlignment=NSTextAlignmentLeft;
    countrytxt.delegate = self;
    countrytxt.textColor=[UIColor blackColor];
    [countrytxt setBackgroundColor:[UIColor clearColor]];
    countrytxt.leftViewMode = UITextFieldViewModeAlways;
    [countrytxt setKeyboardType:UIKeyboardTypeEmailAddress];
    countrytxt.returnKeyType=UIReturnKeyDone;
    countrytxt.floatingLabelActiveTextColor = [UIColor redColor];
    countrytxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders13 = [CALayer layer];
    bottomBorders13.frame = CGRectMake(0.0f, countrytxt.frame.size.height - 5, countrytxt.frame.size.width, 1.5f);
    bottomBorders13.backgroundColor = [UIColor redColor].CGColor;
    [countrytxt.layer addSublayer:bottomBorders13];
    countrytxt.placeholder=@"Country";
    countrytxt.text=@"India";
    countrytxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:countrytxt];
    
    hight=hight+ screenRect.size.height*0.12;
    
    stattxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    stattxt.textAlignment=NSTextAlignmentLeft;
    stattxt.delegate = self;
    stattxt.textColor=[UIColor blackColor];
    [stattxt setBackgroundColor:[UIColor clearColor]];
    stattxt.leftViewMode = UITextFieldViewModeAlways;
    [stattxt setKeyboardType:UIKeyboardTypeEmailAddress];
    stattxt.returnKeyType=UIReturnKeyDone;
    stattxt.floatingLabelActiveTextColor = [UIColor redColor];
    stattxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders14 = [CALayer layer];
    bottomBorders14.frame = CGRectMake(0.0f, addrtxt.frame.size.height - 5, addrtxt.frame.size.width, 1.5f);
    bottomBorders14.backgroundColor = [UIColor redColor].CGColor;
    [stattxt.layer addSublayer:bottomBorders14];
    stattxt.placeholder=@"State";
    stattxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:stattxt];
    hight=hight+ screenRect.size.height*0.12;
    
    bankdetailslbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,hight,screenRect.size.width*.64,screenRect.size.height*.07)];
    bankdetailslbl.textAlignment = NSTextAlignmentLeft;
    bankdetailslbl.text=@"Bank Details";
    bankdetailslbl.textColor=[UIColor redColor];
    [bankdetailslbl setBackgroundColor:[UIColor clearColor]];
    bankdetailslbl.font=[UIFont fontWithName:@"Open Sans" size:22];
    [scrollView addSubview:bankdetailslbl];
    hight=hight+ screenRect.size.height*0.10;
    
    banknametxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    banknametxt.textAlignment=NSTextAlignmentLeft;
    banknametxt.delegate = self;
    banknametxt.textColor=[UIColor blackColor];
    [banknametxt setBackgroundColor:[UIColor clearColor]];
    banknametxt.leftViewMode = UITextFieldViewModeAlways;
    [banknametxt setKeyboardType:UIKeyboardTypeEmailAddress];
    banknametxt.returnKeyType=UIReturnKeyDone;
    banknametxt.floatingLabelActiveTextColor = [UIColor redColor];
    banknametxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders15 = [CALayer layer];
    bottomBorders15.frame = CGRectMake(0.0f, banknametxt.frame.size.height - 5, banknametxt.frame.size.width, 1.5f);
    bottomBorders15.backgroundColor = [UIColor redColor].CGColor;
    [banknametxt.layer addSublayer:bottomBorders15];
    banknametxt.placeholder=@"Bank Name*";
    banknametxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:banknametxt];
    hight=hight+ screenRect.size.height*0.12;
    
    bankholdertxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    bankholdertxt.textAlignment=NSTextAlignmentLeft;
    bankholdertxt.delegate = self;
    bankholdertxt.textColor=[UIColor blackColor];
    [bankholdertxt setBackgroundColor:[UIColor clearColor]];
    bankholdertxt.leftViewMode = UITextFieldViewModeAlways;
    [bankholdertxt setKeyboardType:UIKeyboardTypeEmailAddress];
    bankholdertxt.returnKeyType=UIReturnKeyDone;
    bankholdertxt.floatingLabelActiveTextColor = [UIColor redColor];
    bankholdertxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders16 = [CALayer layer];
    bottomBorders16.frame = CGRectMake(0.0f, bankholdertxt.frame.size.height - 5, bankholdertxt.frame.size.width, 1.5f);
    bottomBorders16.backgroundColor = [UIColor redColor].CGColor;
    [bankholdertxt.layer addSublayer:bottomBorders16];
    bankholdertxt.placeholder=@"Bank Holder-Name*";
    bankholdertxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:bankholdertxt];
    
    hight=hight+ screenRect.size.height*0.12;
    
    accounttxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    accounttxt.textAlignment=NSTextAlignmentLeft;
    accounttxt.delegate = self;
    accounttxt.textColor=[UIColor blackColor];
    [accounttxt setBackgroundColor:[UIColor clearColor]];
    accounttxt.leftViewMode = UITextFieldViewModeAlways;
    [accounttxt setKeyboardType:UIKeyboardTypeEmailAddress];
    accounttxt.returnKeyType=UIReturnKeyDone;
    accounttxt.floatingLabelActiveTextColor = [UIColor redColor];
    accounttxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders17 = [CALayer layer];
    bottomBorders17.frame = CGRectMake(0.0f, accounttxt.frame.size.height - 5, accounttxt.frame.size.width, 1.5f);
    bottomBorders17.backgroundColor = [UIColor redColor].CGColor;
    [accounttxt.layer addSublayer:bottomBorders17];
    accounttxt.placeholder=@"Account No*";
    accounttxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:accounttxt];
  
    hight=hight+ screenRect.size.height*0.12;
    
    IFSCtxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    IFSCtxt.textAlignment=NSTextAlignmentLeft;
    IFSCtxt.delegate = self;
    IFSCtxt.textColor=[UIColor blackColor];
    [IFSCtxt setBackgroundColor:[UIColor clearColor]];
    IFSCtxt.leftViewMode = UITextFieldViewModeAlways;
    [IFSCtxt setKeyboardType:UIKeyboardTypeEmailAddress];
    IFSCtxt.returnKeyType=UIReturnKeyDone;
    IFSCtxt.floatingLabelActiveTextColor = [UIColor redColor];
    IFSCtxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders18 = [CALayer layer];
    bottomBorders18.frame = CGRectMake(0.0f, accounttxt.frame.size.height - 5, accounttxt.frame.size.width, 1.5f);
    bottomBorders18.backgroundColor = [UIColor redColor].CGColor;
    [IFSCtxt.layer addSublayer:bottomBorders18];
    IFSCtxt.placeholder=@"IFSC Code*";
    IFSCtxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:IFSCtxt];
  
    hight=hight+ screenRect.size.height*0.12;
    
    BranchAddress = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    BranchAddress.textAlignment=NSTextAlignmentLeft;
    BranchAddress.delegate = self;
    BranchAddress.textColor=[UIColor blackColor];
    [BranchAddress setBackgroundColor:[UIColor clearColor]];
    BranchAddress.leftViewMode = UITextFieldViewModeAlways;
    [BranchAddress setKeyboardType:UIKeyboardTypeEmailAddress];
    BranchAddress.returnKeyType=UIReturnKeyDone;
    BranchAddress.floatingLabelActiveTextColor = [UIColor redColor];
    BranchAddress.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders19 = [CALayer layer];
    bottomBorders19.frame = CGRectMake(0.0f, BranchAddress.frame.size.height - 5, BranchAddress.frame.size.width, 1.5f);
    bottomBorders19.backgroundColor = [UIColor redColor].CGColor;
    [BranchAddress.layer addSublayer:bottomBorders19];
    BranchAddress.placeholder=@"IBranch Address*";
    BranchAddress.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:BranchAddress];
    
    hight=hight+ screenRect.size.height*0.12;
    
    UIButton *cancelchckbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    [cancelchckbtn setClipsToBounds:YES];
    [cancelchckbtn setTitle:@"Upload Cancelled Cheque" forState:UIControlStateNormal];
    [cancelchckbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelchckbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    cancelchckbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    cancelchckbtn.tag=1;
    [cancelchckbtn addTarget:self action:@selector(showColorsActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    [cancelchckbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.05]];
    [cancelchckbtn setBackgroundColor:[UIColor colorWithHexString:@"#b3b3b3"]] ;
    [scrollView addSubview:cancelchckbtn];
    
    hight=hight+ screenRect.size.height*0.10;
    
    cacelledcheckimage=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,hight, screenRect.size.width*0.90,screenRect.size.height*0.15)];
    cacelledcheckimage.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:cacelledcheckimage];
    cacelledcheckimage.backgroundColor=[UIColor clearColor];
    
    hight=hight+ screenRect.size.height*0.17;
    scrollView.contentSize = CGSizeMake(screenRect.size.width ,hight);
}
- (IBAction)showColorsActionSheet:(UIButton*)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Camera",@"Gallery", nil];
    actionSheet.tag=200;
    _type =sender.tag;
    [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag==200) {
        if (buttonIndex == 0) {
            [self cameraOption] ;
        }
        else if (buttonIndex == 1){
            [self galleryOption] ;
        }
    }
}

-(void)galleryOption{
    [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}
-(void)cameraOption{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *altView = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Sorry, you do not have a camera" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [altView show];
        return;
    }
    //if count
    [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}

-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        NSArray *mediaTypes = [UIImagePickerController
                               availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker =
        [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self presentViewController:picker animated:NO completion:nil];
        }];
    }
    else
    {
        NSArray *mediaTypes = [UIImagePickerController
                               availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker =
        [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        
        picker.delegate = (id)self;
        picker.allowsEditing = NO;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:NO completion:nil];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    [self dismissModalViewControllerAnimated:YES];
    
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
   
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        
        UIImage*  chosenImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (_type==0) {
            panimageview.image=chosenImage;
//            int hight=screenRect.size.height*1.40;
//
//            yearofexperiancetxt.frame=CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08);
//            hight=hight+screenRect.size.height*0.12;
//            noofemployetxt.frame = CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08);
//            hight=hight+screenRect.size.height*0.12;
// addrtxt.frame=CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08);
//
//            hight=hight+screenRect.size.height*0.12;
//
//
//            countrytxt.frame =CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08);
//
//
//            hight=hight+screenRect.size.height*0.12;
//
//            stattxt.frame =CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08);
//            hight=hight+screenRect.size.height*0.12;
//
//            bankdetailslbl.frame=CGRectMake(screenRect.size.width*.02,hight,screenRect.size.width*.64,screenRect.size.height*.07);
//
//            hight=hight+screenRect.size.height*0.10;
//
//            banknametxt.frame= CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08);
//            hight=hight+screenRect.size.height*0.12;
// bankholdertxt.frame=CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.08);
//
//            hight=hight+screenRect.size.height*0.12;
//    accounttxt.frame =CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.0);
//            hight=hight+screenRect.size.height*0.12;
//       IFSCtxt.frame = CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.0);
//            hight=hight+screenRect.size.height*0.12;
//        BranchAddress.frame = CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.0);;
//            hight=hight+screenRect.size.height*0.12;
//cancelchckbtn.frame=CGRectMake(screenRect.size.width*0.05,hight,screenRect.size.width*0.90,screenRect.size.height*0.07);
//            hight=hight+screenRect.size.height*0.10;
//       cacelledcheckimage.frame=CGRectMake(screenRect.size.width*0.05,hight, screenRect.size.width*0.90,screenRect.size.height*0.15);
//            hight=hight+screenRect.size.height*0.15;
//
//            hight=hight+screenRect.size.height*0.12;
//
// scrollView.contentSize = CGSizeMake(screenRect.size.width ,hight);

            
        }
        if (_type==1){
            cacelledcheckimage.image=chosenImage;
        }
       
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)submit
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)save
{
    scrollView.hidden=YES;
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    otptext = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.40,screenRect.size.width*0.90,screenRect.size.height*0.08)];
    otptext.textAlignment=NSTextAlignmentLeft;
    otptext.delegate = self;
    otptext.textColor=[UIColor blackColor];
    [otptext setBackgroundColor:[UIColor clearColor]];
    otptext.leftViewMode = UITextFieldViewModeAlways;
    [otptext setKeyboardType:UIKeyboardTypeEmailAddress];
    otptext.returnKeyType=UIReturnKeyDone;
    otptext.floatingLabelActiveTextColor = [UIColor redColor];
    otptext.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders6 = [CALayer layer];
    bottomBorders6.frame = CGRectMake(0.0f, contacttxt.frame.size.height - 5, contacttxt.frame.size.width, 1.5f);
    bottomBorders6.backgroundColor = [UIColor redColor].CGColor;
    [otptext.layer addSublayer:bottomBorders6];
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.barStyle = UIBarStyleBlackOpaque;
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbarzip sizeToFit];
    numberToolbarzip.tintColor=[UIColor whiteColor];
    otptext.inputAccessoryView = numberToolbarzip;
    otptext.leftViewMode = UITextFieldViewModeAlways;
    otptext.keyboardType = UIKeyboardTypeDecimalPad;
    otptext.placeholder = @"OTP*";
    [self.view addSubview:otptext];
    
  submitbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.50,screenRect.size.width*0.80,screenRect.size.height*0.07)];
    submitbtn.layer.cornerRadius = 4.0f;
    [submitbtn setClipsToBounds:YES];
    [submitbtn setTitle:@"Submit" forState:UIControlStateNormal];
    [submitbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    submitbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [submitbtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitbtn];
    [submitbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
    [submitbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]] ;
    [self.view addSubview:submitbtn];
    
    
    
    resendbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.62,screenRect.size.width*0.80,screenRect.size.height*0.05)];
    [resendbtn setTitle:@"Resend OTP" forState:UIControlStateNormal];
    [resendbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [resendbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    resendbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
   // [resendbtn addTarget:self action:@selector(Submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resendbtn];
    [resendbtn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.04]];
}
-(void)backbtn
{
    if (!scrollView.hidden) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        scrollView.hidden=NO;
        [otptext removeFromSuperview];
        [submitbtn removeFromSuperview];
        [resendbtn removeFromSuperview];
    }
}
-(void)doneWithNumberPad{
    [contacttxt resignFirstResponder];
    [otptext resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(RPFloatingPlaceholderTextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
