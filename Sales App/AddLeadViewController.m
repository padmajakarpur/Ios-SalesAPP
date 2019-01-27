//
//  AddLeadViewController.m
//  Sales App
//
//  Created by Infinitum on 27/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "AddLeadViewController.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
#import <MXParallaxHeader.h>
#import <AFNetworking.h>
#import <UITextField_AutoSuggestion/UITextField+AutoSuggestion.h>
#import "Front_OfficeViewController.h"
@interface AddLeadViewController ()<UITextFieldAutoSuggestionDataSource, UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *weeks;

@end
@implementation AddLeadViewController
@synthesize  scrollView,fnametxt,lnametxt,dapartmentxt,mobiletxt,projectstxt,prospectstagestxt,prospectstatustxt,scheduletxt,emailtxt,alternamtetxt,companynametxt,indicator,appDelegate,projectarr,projectstr,projectpicker,projectttlbar,stagestr,stagearr,stagestoolbar,stegespickeer,statustoolbar,statuwpicker,statusstr,statusarr,numberToolbarzip,datePicker,prsspectsourcetxt,prospectalloctxt,streetxt,citytxt,statetxt,postaltxt,countytxt,locationpreftxt,projectofinterest,indstr,prosjectidarr,workphone,homephone,otherphone,phoneview,addrsview,addphondeclbl,downbtn1,downbtn2,primaryaddrs,printtxt,refbycustnotxt,referedbycustprotxt,chanelpartnertxt,printarr,printstr,printtoolbar,sourcearr,printpicker,sourcestr,sourcepicker,sourcetoolbar,sourcedict,_submitdict,assignarr,assignstr,assignpicker,assigntotoolbar,assignidarr,assignidstr,salesname,mobilestr,countrcodetxt,countrstr,countryarr,countrpicker,countrytoolbar,cpdict;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    appDelegate=[[UIApplication sharedApplication] delegate];
    _formatteddatestr=[[NSString alloc]init];
    projectarr=[[NSMutableArray alloc]init];
    prosjectidarr=[[NSMutableArray alloc]init];
    projectoremove=[[NSMutableArray alloc]init];
    statusstr=@"Hot";
    
    if (_custypoestr ==nil) {
        _custypoestr=@"New";
        _custprojstr =@"";
        _purposestr=@"";
        _unitnostr=@"";
    }
    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];

    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UIButton*  backBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.03,screenRect.size.width*0.20,screenRect.size.height*.07)];
    //  [backBtn setTitle:@"\uE5C4" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backbtn) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"arrow_back_white.png"] forState:UIControlStateNormal];
    [navigationView addSubview:backBtn];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:30];
    UIButton* addbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.85,screenRect.size.height*0.03,screenRect.size.width*.10,screenRect.size.height*.07)];
    [addbtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [addbtn setTitle:@"\uE161" forState:UIControlStateNormal];
    [addbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addbtn.titleLabel setFont:customFontdregs];
    [addbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:addbtn];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Add Prospects";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:horizontallbl];
    
    //    UIImageView *dashbgimageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.10, screenRect.size.width*0.94,screenRect.size.height*0.20)];
    //    dashbgimageview.contentMode = UIViewContentModeScaleAspectFit;
    //    dashbgimageview.image=[UIImage imageNamed:@"account_circle.png"];
    //    dashbgimageview.backgroundColor=[UIColor lightGrayColor];
    //    dashbgimageview.clipsToBounds=YES;
    //    [self.view addSubview:dashbgimageview];
    
    CGRect scrollViewFrame1 = CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.10,screenRect.size.width,screenRect.size.height*0.90);
    scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame1];
    scrollView.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    //      scrollView.tintColor=[UIColor redColor];
    //        scrollView.parallaxHeader.view = dashbgimageview;
    //        scrollView.parallaxHeader.height = screenRect.size.height*0.20;
    //        scrollView.parallaxHeader.mode = MXParallaxHeaderModeFill;
    //        scrollView.parallaxHeader.minimumHeight = screenRect.size.height*0.0;
    
    [self.view addSubview:scrollView];
    
    //    UIButton* camarabtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.60,screenRect.size.height*0.0-20,screenRect.size.width*.10,screenRect.size.width*.10)];
    //    // [addbtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    //    [camarabtn setTitle:@"\uE3B0" forState:UIControlStateNormal];
    //    [camarabtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [camarabtn.titleLabel setFont:customFontdregs];
    //    camarabtn.layer.cornerRadius=screenRect.size.width*0.05;
    //    [camarabtn setBackgroundColor:[UIColor colorWithHexString:@"# 00A5F7"]];
    //    [scrollView addSubview:camarabtn];
    
    int hig=screenRect.size.height*0.02;
    
    fnametxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.40,screenRect.size.height*0.07)];
    fnametxt.textAlignment=NSTextAlignmentLeft;
    fnametxt.delegate = self;
    fnametxt.textColor=[UIColor blackColor];
    [fnametxt setBackgroundColor:[UIColor clearColor]];
    fnametxt.leftViewMode = UITextFieldViewModeAlways;
    [fnametxt setKeyboardType:UIKeyboardTypeEmailAddress];
    fnametxt.returnKeyType=UIReturnKeyDone;
    fnametxt.selectedLineColor = [UIColor redColor];
    fnametxt.selectedPlaceHolderColor = [UIColor redColor];
    fnametxt.placeHolderColor = [UIColor grayColor];
    fnametxt.placeholder=@"First Name";
    fnametxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:fnametxt];
    
    lnametxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.55,hig,screenRect.size.width*0.40,screenRect.size.height*0.07)];
    lnametxt.textAlignment=NSTextAlignmentLeft;
    lnametxt.delegate = self;
    lnametxt.textColor=[UIColor blackColor];
    [lnametxt setBackgroundColor:[UIColor clearColor]];
    lnametxt.leftViewMode = UITextFieldViewModeAlways;
    [lnametxt setKeyboardType:UIKeyboardTypeEmailAddress];
    lnametxt.returnKeyType=UIReturnKeyDone;
    lnametxt.selectedLineColor = [UIColor redColor];
    lnametxt.selectedPlaceHolderColor = [UIColor redColor];
    lnametxt.placeHolderColor = [UIColor grayColor];
    lnametxt.placeholder=@"Last Name*";
    lnametxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:lnametxt];
    
    hig=hig+ screenRect.size.height*0.10;
    
    countrcodetxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.15,screenRect.size.height*0.07)];
    countrcodetxt.textAlignment=NSTextAlignmentLeft;
    countrcodetxt.delegate = self;
    countrcodetxt.textColor=[UIColor blackColor];
    [countrcodetxt setBackgroundColor:[UIColor clearColor]];
    countrcodetxt.leftViewMode = UITextFieldViewModeAlways;
    [countrcodetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    countrcodetxt.returnKeyType=UIReturnKeyDone;
    countrcodetxt.placeholder=@"Code*";
    countrcodetxt.text=@"+91";
    countrcodetxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:countrcodetxt];
    CALayer *bottomBorders01 = [CALayer layer];
    bottomBorders01.frame = CGRectMake(0.0f, countrcodetxt.frame.size.height - 5, countrcodetxt.frame.size.width, 1.0f);
    bottomBorders01.backgroundColor = [UIColor whiteColor].CGColor;
    [countrcodetxt.layer addSublayer:bottomBorders01];
    
    mobiletxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.25,hig,screenRect.size.width*0.70,screenRect.size.height*0.07)];
    mobiletxt.textAlignment=NSTextAlignmentLeft;
    mobiletxt.delegate = self;
    mobiletxt.textColor=[UIColor blackColor];
    [mobiletxt setBackgroundColor:[UIColor clearColor]];
    mobiletxt.leftViewMode = UITextFieldViewModeAlways;
    mobiletxt.returnKeyType=UIReturnKeyDone;
    mobiletxt.selectedLineColor = [UIColor redColor];
    mobiletxt.selectedPlaceHolderColor = [UIColor redColor];
    mobiletxt.placeHolderColor = [UIColor grayColor];
    mobiletxt.placeholder=@"Mobile*";
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbarzip sizeToFit];
    mobiletxt.inputAccessoryView = numberToolbarzip;
    mobiletxt.leftViewMode = UITextFieldViewModeAlways;
    mobiletxt.keyboardType = UIKeyboardTypeNumberPad;
    mobiletxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:mobiletxt];
    
    hig=hig+ screenRect.size.height*0.10;
    
    projectstxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    projectstxt.textAlignment=NSTextAlignmentLeft;
    projectstxt.delegate = self;
    projectstxt.textColor=[UIColor blackColor];
    [projectstxt setBackgroundColor:[UIColor clearColor]];
    projectstxt.leftViewMode = UITextFieldViewModeAlways;
    [projectstxt setKeyboardType:UIKeyboardTypeEmailAddress];
    projectstxt.returnKeyType=UIReturnKeyDone;
    projectstxt.selectedLineColor = [UIColor redColor];
    projectstxt.selectedPlaceHolderColor = [UIColor redColor];
    projectstxt.placeHolderColor = [UIColor grayColor];
    projectstxt.placeholder=@"Projects*";
    projectstxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:projectstxt];
    
    hig=hig+ screenRect.size.height*0.10;
    if (![_comefrom isEqualToString:@"frontoffice"]) {
        prospectstatustxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        prospectstatustxt.textAlignment=NSTextAlignmentLeft;
        prospectstatustxt.delegate = self;
        prospectstatustxt.textColor=[UIColor blackColor];
        [prospectstatustxt setBackgroundColor:[UIColor clearColor]];
        prospectstatustxt.leftViewMode = UITextFieldViewModeAlways;
        [prospectstatustxt setKeyboardType:UIKeyboardTypeEmailAddress];
        prospectstatustxt.returnKeyType=UIReturnKeyDone;
        prospectstatustxt.selectedLineColor = [UIColor redColor];
        prospectstatustxt.selectedPlaceHolderColor = [UIColor redColor];
        prospectstatustxt.placeHolderColor = [UIColor grayColor];
        prospectstatustxt.placeholder=@"Prospect Status*";
        prospectstatustxt.font = [UIFont systemFontOfSize:14];
        [scrollView addSubview:prospectstatustxt];
        
        hig=hig+ screenRect.size.height*0.10;
        //
        scheduletxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        scheduletxt.textAlignment=NSTextAlignmentLeft;
        scheduletxt.delegate = self;
        scheduletxt.textColor=[UIColor blackColor];
        [scheduletxt setBackgroundColor:[UIColor clearColor]];
        scheduletxt.leftViewMode = UITextFieldViewModeAlways;
        [scheduletxt setKeyboardType:UIKeyboardTypeEmailAddress];
        scheduletxt.returnKeyType=UIReturnKeyDone;
        scheduletxt.selectedLineColor = [UIColor redColor];
        scheduletxt.selectedPlaceHolderColor = [UIColor redColor];
        scheduletxt.placeHolderColor = [UIColor grayColor];
        scheduletxt.placeholder=@"Schedule on*";
        scheduletxt.font = [UIFont systemFontOfSize:14];
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
        [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
        numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbarzip.barStyle = UIBarStyleBlackOpaque;
        numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad11:)]];
        [numberToolbarzip sizeToFit];
        scheduletxt.inputView =datePicker;
        numberToolbarzip.tintColor=[UIColor whiteColor];
        scheduletxt.inputAccessoryView = numberToolbarzip;
        [scrollView addSubview:scheduletxt];
        hig=hig+ screenRect.size.height*0.10;
        
        
    }
    
    emailtxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    emailtxt.textAlignment=NSTextAlignmentLeft;
    emailtxt.delegate = self;
    emailtxt.textColor=[UIColor blackColor];
    [emailtxt setBackgroundColor:[UIColor clearColor]];
    emailtxt.leftViewMode = UITextFieldViewModeAlways;
    [emailtxt setKeyboardType:UIKeyboardTypeEmailAddress];
    emailtxt.returnKeyType=UIReturnKeyDone;
    emailtxt.selectedLineColor = [UIColor redColor];
    emailtxt.selectedPlaceHolderColor = [UIColor redColor];
    emailtxt.placeHolderColor = [UIColor grayColor];
    emailtxt.placeholder=@"Email Address";
    emailtxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:emailtxt];
    
    if ([_comefrom isEqualToString:@"frontoffice"]) {
        hig=hig+ screenRect.size.height*0.10;
        
        salesname = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        salesname.textAlignment=NSTextAlignmentLeft;
        salesname.delegate = self;
        salesname.autoSuggestionDataSource = self;
        salesname.showImmediately = true;
        [salesname observeTextFieldChanges];
        salesname.textColor=[UIColor blackColor];
        [salesname setBackgroundColor:[UIColor clearColor]];
        salesname.leftViewMode = UITextFieldViewModeAlways;
        [salesname setKeyboardType:UIKeyboardTypeEmailAddress];
        salesname.returnKeyType=UIReturnKeyDone;
        salesname.fieldIdentifier=@"salesID";
        salesname.font = [UIFont systemFontOfSize:14];
        [scrollView addSubview:salesname];
        CALayer *bottomBorders3 = [CALayer layer];
        bottomBorders3.frame = CGRectMake(0.0f, salesname.frame.size.height - 5, salesname.frame.size.width, 1.0f);
        bottomBorders3.backgroundColor = [UIColor grayColor].CGColor;
        [salesname.layer addSublayer:bottomBorders3];
        salesname.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Assign To*" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
        
    }
    hig=hig+ screenRect.size.height*0.10;
    
    prsspectsourcetxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    prsspectsourcetxt.textAlignment=NSTextAlignmentLeft;
    prsspectsourcetxt.delegate = self;
    prsspectsourcetxt.textColor=[UIColor blackColor];
    [prsspectsourcetxt setBackgroundColor:[UIColor clearColor]];
    prsspectsourcetxt.leftViewMode = UITextFieldViewModeAlways;
    [prsspectsourcetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    prsspectsourcetxt.returnKeyType=UIReturnKeyDone;
    prsspectsourcetxt.selectedLineColor = [UIColor redColor];
    prsspectsourcetxt.selectedPlaceHolderColor = [UIColor redColor];
    prsspectsourcetxt.placeHolderColor = [UIColor grayColor];
    prsspectsourcetxt.placeholder=@"Prospect Source*";
    prsspectsourcetxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:prsspectsourcetxt];
    
    hig=hig+ screenRect.size.height*0.10;
    
    printtxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    printtxt.textAlignment=NSTextAlignmentLeft;
    printtxt.delegate = self;
    printtxt.textColor=[UIColor blackColor];
    [printtxt setBackgroundColor:[UIColor clearColor]];
    printtxt.leftViewMode = UITextFieldViewModeAlways;
    [printtxt setKeyboardType:UIKeyboardTypeEmailAddress];
    printtxt.returnKeyType=UIReturnKeyDone;
    printtxt.selectedLineColor = [UIColor redColor];
    printtxt.selectedPlaceHolderColor = [UIColor redColor];
    printtxt.placeHolderColor = [UIColor grayColor];
    printtxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:printtxt];
    printtxt.hidden=YES;
    
    chanelpartnertxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    chanelpartnertxt.textAlignment=NSTextAlignmentLeft;
    chanelpartnertxt.delegate = self;
    chanelpartnertxt.textColor=[UIColor blackColor];
    [chanelpartnertxt setBackgroundColor:[UIColor clearColor]];
    chanelpartnertxt.leftViewMode = UITextFieldViewModeAlways;
    [chanelpartnertxt setKeyboardType:UIKeyboardTypeEmailAddress];
    chanelpartnertxt.returnKeyType=UIReturnKeyDone;
    chanelpartnertxt.selectedLineColor = [UIColor redColor];
    chanelpartnertxt.selectedPlaceHolderColor = [UIColor redColor];
    chanelpartnertxt.placeHolderColor = [UIColor grayColor];
    chanelpartnertxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:chanelpartnertxt];
    chanelpartnertxt.placeholder=@"Channel Partner Name";
    chanelpartnertxt.hidden=YES;
    
    referedbycustprotxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    referedbycustprotxt.textAlignment=NSTextAlignmentLeft;
    referedbycustprotxt.delegate = self;
    referedbycustprotxt.textColor=[UIColor blackColor];
    [referedbycustprotxt setBackgroundColor:[UIColor clearColor]];
    referedbycustprotxt.leftViewMode = UITextFieldViewModeAlways;
    [referedbycustprotxt setKeyboardType:UIKeyboardTypeEmailAddress];
    referedbycustprotxt.returnKeyType=UIReturnKeyDone;
    referedbycustprotxt.selectedLineColor = [UIColor redColor];
    referedbycustprotxt.selectedPlaceHolderColor = [UIColor redColor];
    referedbycustprotxt.placeHolderColor = [UIColor grayColor];
    referedbycustprotxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:referedbycustprotxt];
    referedbycustprotxt.placeholder=@"Ref by cusmtomer project";
    referedbycustprotxt.hidden=YES;
    
    hig=hig+ screenRect.size.height*0.10;
    refbycustnotxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    refbycustnotxt.textAlignment=NSTextAlignmentLeft;
    refbycustnotxt.delegate = self;
    refbycustnotxt.textColor=[UIColor blackColor];
    [refbycustnotxt setBackgroundColor:[UIColor clearColor]];
    refbycustnotxt.leftViewMode = UITextFieldViewModeAlways;
    [refbycustnotxt setKeyboardType:UIKeyboardTypeEmailAddress];
    refbycustnotxt.returnKeyType=UIReturnKeyDone;
    refbycustnotxt.selectedLineColor = [UIColor redColor];
    refbycustnotxt.selectedPlaceHolderColor = [UIColor redColor];
    refbycustnotxt.placeHolderColor = [UIColor grayColor];
    refbycustnotxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:refbycustnotxt];
    refbycustnotxt.placeholder=@"Ref by cusm unit no";
    refbycustnotxt.hidden=YES;
    
    hig=hig+ screenRect.size.height*0.10;
    addphondeclbl=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    [addphondeclbl setTitle:@"Add Phone Details" forState:UIControlStateNormal];
    [addphondeclbl setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addphondeclbl setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    addphondeclbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //  [addphondeclbl addTarget:self action:@selector(showphone) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:addphondeclbl];
    [addphondeclbl.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.045]];
    CALayer *bottomBorders1 = [CALayer layer];
    bottomBorders1.frame = CGRectMake(0.0f, addphondeclbl.frame.size.height - 5, addphondeclbl.frame.size.width, 1.0f);
    bottomBorders1.backgroundColor = [UIColor grayColor].CGColor;
    // [primaryaddrs.layer addSublayer:bottomBorders12];
    
    downbtn1=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.85,hig,screenRect.size.width*.10,screenRect.size.height*.07)];
    // [addbtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [downbtn1 setTitle:@"\uE5CF" forState:UIControlStateNormal];
    [downbtn1 setTitle:@"\uE316" forState:UIControlStateSelected];
    [downbtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [downbtn1.titleLabel setFont:customFontdregs];
    [downbtn1 setBackgroundColor:[UIColor clearColor]];
    [scrollView addSubview:downbtn1];
    
    hig=hig+ screenRect.size.height*0.07;
    hight=hig;
    
    phoneview=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,hig,screenRect.size.width,screenRect.size.height*0.20)];
    [scrollView addSubview:phoneview];
    
    workphone = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,0,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    workphone.textAlignment=NSTextAlignmentLeft;
    workphone.delegate = self;
    workphone.textColor=[UIColor blackColor];
    [workphone setBackgroundColor:[UIColor clearColor]];
    workphone.leftViewMode = UITextFieldViewModeAlways;
    workphone.returnKeyType=UIReturnKeyDone;
    workphone.selectedLineColor = [UIColor redColor];
    workphone.selectedPlaceHolderColor = [UIColor redColor];
    workphone.placeHolderColor = [UIColor grayColor];
    workphone.placeholder=@"Work Phone";
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbarzip sizeToFit];
    workphone.inputAccessoryView = numberToolbarzip;
    workphone.leftViewMode = UITextFieldViewModeAlways;
    workphone.keyboardType = UIKeyboardTypeDecimalPad;
    workphone.font = [UIFont systemFontOfSize:14];
    [phoneview addSubview:workphone];
    
    otherphone = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.10,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    otherphone.textAlignment=NSTextAlignmentLeft;
    otherphone.delegate = self;
    otherphone.textColor=[UIColor blackColor];
    [otherphone setBackgroundColor:[UIColor clearColor]];
    otherphone.leftViewMode = UITextFieldViewModeAlways;
    otherphone.returnKeyType=UIReturnKeyDone;
    otherphone.selectedLineColor = [UIColor redColor];
    otherphone.selectedPlaceHolderColor = [UIColor redColor];
    otherphone.placeHolderColor = [UIColor grayColor];
    otherphone.placeholder=@"Other Phone";
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.items = [NSArray arrayWithObjects:
                              [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                              [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                              [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                              nil];
    
    otherphone.inputAccessoryView = numberToolbarzip;
    otherphone.keyboardType = UIKeyboardTypeDecimalPad;
    otherphone.font = [UIFont systemFontOfSize:14];
    [phoneview addSubview:otherphone];
    
    hig=hig+ screenRect.size.height*0.20;
    
    primaryaddrs=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    [primaryaddrs setTitle:@"Primary Address" forState:UIControlStateNormal];
    [primaryaddrs setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [primaryaddrs setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    primaryaddrs.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //    [primaryaddrs addTarget:self action:@selector(showaddr) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:primaryaddrs];
    [primaryaddrs.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.045]];
    
    downbtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.85,hig,screenRect.size.width*.10,screenRect.size.height*.07)];
    // [addbtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [downbtn2 setTitle:@"\uE5CF" forState:UIControlStateNormal];
    [downbtn2 setTitle:@"\uE316" forState:UIControlStateSelected];
    [downbtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [downbtn2.titleLabel setFont:customFontdregs];
    [downbtn2 setBackgroundColor:[UIColor clearColor]];
    [scrollView addSubview:downbtn2];
    
    hig=hig+ screenRect.size.height*0.07;
    
    addrsview=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,hig,screenRect.size.width,screenRect.size.height*0.50)];
    [scrollView addSubview:addrsview];

    streetxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,0,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    streetxt.textAlignment=NSTextAlignmentLeft;
    streetxt.delegate = self;
    streetxt.textColor=[UIColor blackColor];
    [streetxt setBackgroundColor:[UIColor clearColor]];
    streetxt.leftViewMode = UITextFieldViewModeAlways;
    [streetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    streetxt.returnKeyType=UIReturnKeyDone;
    streetxt.selectedLineColor = [UIColor redColor];
    streetxt.selectedPlaceHolderColor = [UIColor redColor];
    streetxt.placeHolderColor = [UIColor grayColor];
    streetxt.placeholder=@"Street";
    streetxt.font = [UIFont systemFontOfSize:14];
    [addrsview addSubview:streetxt];

    citytxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.10,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    citytxt.textAlignment=NSTextAlignmentLeft;
    citytxt.delegate = self;
    citytxt.textColor=[UIColor blackColor];
    [citytxt setBackgroundColor:[UIColor clearColor]];
    citytxt.leftViewMode = UITextFieldViewModeAlways;
    [citytxt setKeyboardType:UIKeyboardTypeEmailAddress];
    citytxt.returnKeyType=UIReturnKeyDone;
    citytxt.selectedLineColor = [UIColor redColor];
    citytxt.selectedPlaceHolderColor = [UIColor redColor];
    citytxt.placeHolderColor = [UIColor grayColor];
    citytxt.placeholder=@"City";
    citytxt.font = [UIFont systemFontOfSize:14];
    [addrsview addSubview:citytxt];
    
    statetxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.20,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    statetxt.textAlignment=NSTextAlignmentLeft;
    statetxt.delegate = self;
    statetxt.textColor=[UIColor blackColor];
    [statetxt setBackgroundColor:[UIColor clearColor]];
    statetxt.leftViewMode = UITextFieldViewModeAlways;
    [statetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    statetxt.returnKeyType=UIReturnKeyDone;
    statetxt.selectedLineColor = [UIColor redColor];
    statetxt.selectedPlaceHolderColor = [UIColor redColor];
    statetxt.placeHolderColor = [UIColor grayColor];
    statetxt.placeholder=@"State";
    statetxt.font = [UIFont systemFontOfSize:14];
    [addrsview addSubview:statetxt];
    
    postaltxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.30,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    postaltxt.textAlignment=NSTextAlignmentLeft;
    postaltxt.delegate = self;
    postaltxt.textColor=[UIColor blackColor];
    [postaltxt setBackgroundColor:[UIColor clearColor]];
    postaltxt.leftViewMode = UITextFieldViewModeAlways;
    [postaltxt setKeyboardType:UIKeyboardTypeEmailAddress];
    postaltxt.returnKeyType=UIReturnKeyDone;
    postaltxt.selectedLineColor = [UIColor redColor];
    postaltxt.selectedPlaceHolderColor = [UIColor redColor];
    postaltxt.placeHolderColor = [UIColor grayColor];
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.items = [NSArray arrayWithObjects:
                              [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                              [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                              [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                              nil];
    
    postaltxt.inputAccessoryView = numberToolbarzip;
    postaltxt.keyboardType = UIKeyboardTypeDecimalPad;
    postaltxt.placeholder=@"Postal Code";
    postaltxt.font = [UIFont systemFontOfSize:14];
    [addrsview addSubview:postaltxt];
    
    countytxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.40,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    countytxt.textAlignment=NSTextAlignmentLeft;
    countytxt.delegate = self;
    countytxt.textColor=[UIColor blackColor];
    [countytxt setBackgroundColor:[UIColor clearColor]];
    countytxt.leftViewMode = UITextFieldViewModeAlways;
    [countytxt setKeyboardType:UIKeyboardTypeEmailAddress];
    countytxt.returnKeyType=UIReturnKeyDone;
    countytxt.selectedLineColor = [UIColor redColor];
    countytxt.selectedPlaceHolderColor = [UIColor redColor];
    countytxt.placeHolderColor = [UIColor grayColor];
    countytxt.placeholder=@"Country";
    countytxt.font = [UIFont systemFontOfSize:14];
    [addrsview addSubview:countytxt];
    
    hig=hig+ screenRect.size.height*0.50;
    
    if ([_comefrom isEqualToString:@"frontoffice"])
    {
        projectstxt.text=projectstr;
        NSLog(@"%@",indstr);
        mobiletxt.text=mobilestr;
        
        if (cpdict!=nil) {
            if ([[cpdict objectForKey:@"Type"]isEqualToString:@"c"]) {
                prsspectsourcetxt.text=@"Existing Customer";
                referedbycustprotxt.hidden=NO;
                refbycustnotxt.hidden=NO;
                refbycustnotxt.text=_unitnostr;
                referedbycustprotxt.text=_custprojstr;
                
                lnametxt.text=[cpdict objectForKey:@"fullname"];
                projectstxt.enabled=NO;
                refbycustnotxt.enabled=NO;
                referedbycustprotxt.enabled=NO;
                prsspectsourcetxt.enabled=NO;
            }
        }
    }
    
    scrollView.contentSize=CGSizeMake(screenRect.size.width,hig);
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0, screenRect.size.height *0.10, screenRect.size.width,screenRect.size.height *0.90);
    indicator.color=[UIColor colorWithHexString:@"#004c00"];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([_comefrom isEqualToString:@"frontoffice"])
    {
        [self getsalesperson];
    }
    
    [self getproject];
    NSString*   urlString = @"http://13.126.129.245/xrbia/index.php?entryPoint=getLeadSource";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [indicator startAnimating];
    [manager GET:urlString parameters:@"" progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", userDict);
        
        sourcedict=[[userDict objectForKey:@"Android"] objectForKey:@"sources"];
        [indicator stopAnimating];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

- (void)loadWeekDays {
    // cancel previous requests
    //    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(loadWeekDaysInBackground) object:self];
    //    [salesname setLoading:false];
    //
    //    // clear previous results
    //    [self.weeks removeAllObjects];
    //    [salesname reloadContents];
    //
    //    // start loading
    //    [salesname setLoading:true];
    //    [self performSelector:@selector(loadWeekDaysInBackground) withObject:self afterDelay:2.0f];
}

- (void)loadWeekDaysInBackground {
    // finish loading
    [salesname setLoading:false];
    
    [self.weeks addObjectsFromArray:assignarr];
    [salesname reloadContents];
}

#pragma mark - UITextFieldAutoSuggestionDataSource

- (UITableViewCell *)autoSuggestionField:(UITextField *)field tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath forText:(NSString *)text {
    static NSString *cellIdentifier = @"MonthAutoSuggestionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ([field.fieldIdentifier isEqualToString:@"salesID"]) {
        
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSArray *months = [assignarr mutableCopy];
        
        
        if (text.length > 0) {
            NSPredicate *filterPredictate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", text];
            months = [assignarr filteredArrayUsingPredicate:filterPredictate];
        }
        
        cell.textLabel.text =months[indexPath.row];
        
    }
    return cell;
    
}
- (NSInteger)autoSuggestionField:(UITextField *)field tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section forText:(NSString *)text {
    
    if (text.length == 0) {
        return assignarr.count;
    }
    NSPredicate *filterPredictate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", text];
    NSInteger count = [assignarr filteredArrayUsingPredicate:filterPredictate].count;
    return count;
}

- (void)autoSuggestionField:(UITextField *)field textChanged:(NSString *)text {
    [self loadWeekDays];
}

- (CGFloat)autoSuggestionField:(UITextField *)field tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath forText:(NSString *)text {
    return 50;
}

- (void)autoSuggestionField:(UITextField *)field tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath forText:(NSString *)text {
    NSLog(@"Selected suggestion at index row - %ld", (long)indexPath.row);
    
    NSArray *months = assignarr;
    
    if (text.length > 0) {
        NSPredicate *filterPredictate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", text];
        months = [assignarr filteredArrayUsingPredicate:filterPredictate];
    }
    salesname.text =months[indexPath.row];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return true;
}
-(void)getsalesperson
{
    if (assignarr.count<=0) {
        assignarr=[[NSMutableArray alloc]init];
        assignidarr=[[NSMutableArray alloc]init];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"usersimplecrmId"];
        
        [params setObject:[prefs objectForKey:@"url"] forKey:@"url"];
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getSalesPersonList.php?",[prefs objectForKey:@"Link"]];
        
        [indicator startAnimating];
        
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSMutableArray *suerarr=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSLog(@"JSON: %@", suerarr);
            
            for (int i=0; i<suerarr.count; i++) {
                NSDictionary* dict=[suerarr objectAtIndex:i];
                [assignarr addObject:[dict objectForKey:@"sales_user"]];
                [assignidarr addObject:[dict objectForKey:@"user_id"]];
            }
            [indicator stopAnimating];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
    
}
-(void)getproject
{
    if (!(appDelegate.projectarr.count>0)) {
        appDelegate.projectarr=[[NSMutableArray alloc]init];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"usersimplecrmId"];
        
        [params setObject:[prefs objectForKey:@"url"] forKey:@"url"];
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getsyncproject.php?",[prefs objectForKey:@"Link"]];
        
        [indicator startAnimating];
        
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            //  NSLog(@"JSON: %@", userDict);
            NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
            {
                appDelegate.projectarr=[dic objectForKey:@"projects"];
            }
            [indicator stopAnimating];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
}
-(void)doneWithNumberPad11:(UITextField*)toolbar{
    NSDateFormatter*  dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"MMM d,yyyy h:mm a"];
    
    UIDatePicker *  picker = (UIDatePicker*)self.scheduletxt.inputView;
    NSString *dateString = [dateFormatter stringFromDate:[picker date]];
    scheduletxt.text=dateString;
    [numberToolbarzip resignFirstResponder];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _formatteddatestr=[dateFormatter stringFromDate:[picker date]];
    [scheduletxt resignFirstResponder];
}
- (BOOL)validateEmailWithString
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailtxt.text];
}
-(void)save
{
    if (![lnametxt.text isEqual:@""]) {
        if (![mobiletxt.text isEqual:@""]&&mobiletxt.text.length==10) {
            if (![projectstxt.text isEqual:@""]) {
                {
                    if (![_comefrom isEqualToString:@"frontoffice"]||![salesname.text isEqualToString:@""]) {
                    if (![prsspectsourcetxt.text isEqual:@""]) {
                        if ([emailtxt.text isEqualToString:@""]||[self validateEmailWithString]) {
                            
                            if ([_comefrom isEqualToString:@"frontoffice"]||![scheduletxt.text isEqualToString:@""])
                            {
                                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                                NSString * useridstr=[prefs objectForKey:@"user_id"];
                                
                                _dict=[[NSMutableDictionary alloc]init];
                                [_dict setObject:projectstxt.text forKey:@"project_name"];
                                [_dict setObject:fnametxt.text  forKey:@"first_name"];
                                [_dict setObject:lnametxt.text  forKey:@"last_name"];
                                [_dict setObject:mobiletxt.text  forKey:@"phone_mobile"];
                                [_dict setObject:workphone.text forKey:@"work_phone_c"];
                                [_dict setObject:otherphone.text  forKey:@"phone_other"];
                                [_dict setObject:indstr forKey:@"project_id"];
                                [_dict setObject:emailtxt.text forKey:@"email"];
                                [_dict setObject:streetxt.text forKey:@"street"];
                                [_dict setObject:citytxt.text forKey:@"city"];
                                [_dict setObject:statetxt.text forKey:@"state"];
                                [_dict setObject:postaltxt.text forKey:@"postal_code"];
                                [_dict setObject:countytxt.text forKey:@"country"];
                                [_dict setObject:statusstr forKey:@"lead_stage"];
                                [_dict setObject:prsspectsourcetxt.text forKey:@"lead_source"];
                                [_dict setObject:refbycustnotxt.text forKey:@"ref_by_cust_unit_number_c"];
                                [_dict setObject:referedbycustprotxt.text forKey:@"ref_by_cust_project_c"];
                                NSMutableDictionary * data=[[NSMutableDictionary alloc]init];
                                [data setObject:[prefs objectForKey:@"username"] forKey:@"username"];
                                [data setObject:[prefs objectForKey:@"password"] forKey:@"password"];
                                [data setObject:useridstr  forKey:@"usersimplecrmId"];
                                [data setObject:[prefs objectForKey:@"url"] forKey:@"url"];
                                [data setObject:@"Leads"  forKey:@"module_name"];
                                
                                NSMutableDictionary *jsonDict=[[NSMutableDictionary alloc]init];
                                [jsonDict setObject:@"25"forKey:@"ID"];
                                NSMutableArray *arr =[[NSMutableArray alloc]initWithObjects:_dict, nil];
                                [jsonDict setObject:arr  forKey:@"data"];
                                
                                NSString *jsonString;
                                NSError *error;
                                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict
                                                                                   options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                                                     error:&error];
                                if (! jsonData) {
                                    //  NSLog(@"Got an error: %@", error);
                                } else {
                                    jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                                    // NSLog(@"Got Stringr %@",jsonString);
                                }
                                NSString*   encodedUrl = [jsonString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
                                [data setObject:encodedUrl  forKey:@"jsonParam"];
                                
                                [indicator startAnimating];
                                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                                NSString*   urlString = [[NSString alloc]initWithFormat:@"%@createleadsales.php?",[prefs objectForKey:@"Link"]];
                                //   NSString*   urlString = @"http://13.126.129.245/xrbia/mobilecrm/sales/createleadsales.php";
                                AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
                                [serializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
                                [indicator startAnimating];
                                
                                [manager GET:urlString parameters:data progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                                    NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                                    NSLog(@"JSON: %@", userDict);
                                    NSMutableArray *recordarr=[[userDict objectForKey:@"Android"] objectForKey:@"records"];
                                    if ([[[userDict objectForKey:@"Android"] objectForKey:@"result"] isEqualToString:@"Yes"])
                                    {
                                        [self getid];
                                        //   [self.navigationController popViewControllerAnimated:YES];
                                    }
                                    else
                                    {
                                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                        [alert show];
                                        [ indicator stopAnimating];
                                    }
                                    
                                } failure:^(NSURLSessionTask *operation, NSError *error) {
                                    NSLog(@"Error: %@", error);
                                    [indicator stopAnimating];
                                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                    [alert show];
                                    [indicator stopAnimating];
                                }];
                            }
                            else
                            {
                                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Select scheduled date"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                [alert show];
                            }
                    }
                    else
                    {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Invalid email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                    }
                    else
                    {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Source name is mandatory"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                    }
                    else
                    {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Assign to is mandatory"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                    
                }
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Select Project "delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Mobile number is invalid"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Last name is mandatory"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void)getid
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getprojectid.php",[prefs objectForKey:@"Link"]];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:indstr  forKey:@"pid"];
    [params setObject:mobiletxt.text  forKey:@"phone"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  
    [indicator startAnimating];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        gotid=[[NSString alloc]init];
        NSLog(@"JSON: %@", userDict);
        if ([[userDict objectForKey:@"status"]intValue]==1) {
            gotid=[userDict objectForKey:@"msg"];
            [self createvisit:gotid];
            if ([_comefrom isEqualToString:@"frontoffice"])
                [self addrecord:[userDict objectForKey:@"lead_id"]];
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userDict objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [indicator stopAnimating];
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
-(void)createvisit:(NSString*)gotid
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *datestr = [formatter stringFromDate:[NSDate date]];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString * useridstr=[prefs objectForKey:@"user_id"];
    if ([_comefrom isEqualToString:@"frontoffice"]) {
        for (int i=0; i<assignarr.count; i++) {
            if ([[assignarr objectAtIndex:i]isEqualToString:salesname.text]) {
                useridstr=[assignidarr objectAtIndex:i];
            }
        }
    }
    
    NSMutableDictionary * data=[[NSMutableDictionary alloc]init];
    [data setObject:[prefs objectForKey:@"username"] forKey:@"username"];
    [data setObject:[prefs objectForKey:@"password"] forKey:@"password"];
    [data setObject:[prefs objectForKey:@"user_id"]  forKey:@"usersimplecrmId"];
    [data setObject:[prefs objectForKey:@"url"] forKey:@"url"];
    [data setObject:@"Sales_Sales_Person"  forKey:@"module_name"];
    
    _submitdict=[[NSMutableDictionary alloc]init];
    [_submitdict setObject:[NSString stringWithFormat:@"%@ %@",fnametxt.text,lnametxt.text] forKey:@"name"];
    [_submitdict setObject:@"555" forKey:@"mobile_id_c"];
    [_submitdict setObject: workphone.text forKey:@"phone_office"];
    [_submitdict setObject:useridstr forKey:@"assigned_user_id"];
    [_submitdict setObject:datestr forKey:@"date_modified_mobile_c"];
    [_submitdict setObject:@"mobile"  forKey:@"record_updated_place_c"];
    [_submitdict setObject:projectstxt.text  forKey:@"project_sales_sales_person_1_name"];
    [_submitdict setObject:indstr  forKey:@"project_sales_sales_person_1project_ida"];
    [_submitdict setObject:@"Followup"  forKey:@"att_stage1_c"];
    [_submitdict setObject:datestr  forKey:@"att_date_c"];
    [_submitdict setObject:_formatteddatestr  forKey:@"fu_date_c"];
    [_submitdict setObject:@"1"  forKey:@"_formatteddatestr"];
    [_submitdict setObject:[NSString stringWithFormat:@"%@ %@",fnametxt.text,lnametxt.text]  forKey:@"customer_name_c"];
    [_submitdict setObject:mobiletxt.text  forKey:@"customer_mobile_c"];
    [_submitdict setObject:@"1"  forKey:@"no_of_visits_c"];
    [_submitdict setObject:@"1" forKey:@"visit_done_c"];
    [_submitdict setObject:statusstr forKey:@"prospect_stage_c"];
    [_submitdict setObject:gotid  forKey:@"leads_sales_sales_person_1leads_ida"];
    [_submitdict setObject:gotid  forKey:@"mobile_offline_parent_id_c"];
    
    if ([_comefrom isEqualToString:@"frontoffice"])
    {
        [_submitdict setObject:@"0" forKey:@"visit_done_c"];
        [_submitdict setObject:datestr  forKey:@"fu_date_c"];
    }
    NSMutableDictionary *jsonDict=[[NSMutableDictionary alloc]init];
    [jsonDict setObject:@"25"forKey:@"ID"];
    NSMutableArray *arr =[NSMutableArray arrayWithObjects:_submitdict, nil];
    [jsonDict setObject:arr  forKey:@"data"];
    
    NSString *jsonString;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        //  NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        // NSLog(@"Got Stringr %@",jsonString);
        //   NSArray* words = [jsonString componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        // jsonString = [words componentsJoinedByString:@""];
        //   jsonString=[jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    NSString*   encodedUrl = [jsonString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    [data setObject:encodedUrl  forKey:@"jsonParam"];
    
    [indicator startAnimating];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@androupdatedatatocrm.php?",[prefs objectForKey:@"Link"]];
    
    [indicator startAnimating];
    
    [manager GET:urlString parameters:data progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"JSON: %@", userDict);
        NSMutableArray *recordarr=[[userDict objectForKey:@"Android"] objectForKey:@"records"];
        
        NSDictionary *dict=[recordarr objectAtIndex:0];
        {
            if (![[dict objectForKey:@"mobile_id_c"] isEqualToString:@""]||!([dict objectForKey:@"mobile_id_c"]==nil)) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Sucessfully Saved."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                if ([_comefrom isEqualToString:@"frontoffice"]) {
                    Front_OfficeViewController *mainvc=[[Front_OfficeViewController alloc] initWithNibName:@"Front_OfficeViewController" bundle:nil];
                    [self.navigationController pushViewController:mainvc animated:YES];
                }
                else
                    [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to update"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        [ indicator stopAnimating];
    }
         failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [indicator stopAnimating];
    }];
}
-(void)addrecord:(NSString*)lid
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString * useridstr=[prefs objectForKey:@"user_id"];
    if ([_comefrom isEqualToString:@"frontoffice"]) {
        for (int i=0; i<assignarr.count; i++) {
            if ([[assignarr objectAtIndex:i]isEqualToString:salesname.text]) {
                useridstr=[assignidarr objectAtIndex:i];
            }
        }
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *datestr = [formatter stringFromDate:[NSDate date]];
    
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@savefrontdet.php",[prefs objectForKey:@"Link"]];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"attendby"];
    [params setObject:@"saveFrontoffice"  forKey:@"requestType"];
    [params setObject:lid  forKey:@"lead_id"];
    if ([[cpdict objectForKey:@"Type"]isEqualToString:@"c"])
        [params setObject:@"customer"  forKey:@"visitstatus"];
    else
        [params setObject:@"new"  forKey:@"visitstatus"];
    [params setObject: [NSString stringWithFormat:@"%@ %@",fnametxt.text,lnametxt.text] forKey:@"name"];
    [params setObject:mobiletxt.text  forKey:@"mobileno"];
    [params setObject:projectstxt.text  forKey:@"project"];
    [params setObject:datestr forKey:@"datetime"];
    [params setObject:useridstr  forKey:@"assignto"];
    [params setObject:_custypoestr  forKey:@"cust_type"];
    [params setObject:_purposestr  forKey:@"purpose"];
    [params setObject:_custprojstr  forKey:@"bproject"];
    [params setObject:_unitnostr  forKey:@"bunitno"];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", userDict);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
-(void)showphone
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int hig;
    if (addphondeclbl.selected) {
        phoneview.hidden=NO;
        downbtn1.selected=YES;
        addphondeclbl.selected=NO;
        
        hig=hight+ screenRect.size.height*0.20; primaryaddrs.frame=CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
        downbtn2.frame=CGRectMake(screenRect.size.width*.85,hig,screenRect.size.width*.10,screenRect.size.height*.07);
        
        hig=hig+screenRect.size.height*0.10;
        
        scrollView.contentSize=CGSizeMake(screenRect.size.width,hig);
    }
    else
    {
        phoneview.hidden=YES;
        downbtn1.selected=NO;
        addphondeclbl.selected=YES;
        
        hig=hight; primaryaddrs.frame=CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
        downbtn2.frame=CGRectMake(screenRect.size.width*.85,hig,screenRect.size.width*.10,screenRect.size.height*.07);
        scrollView.contentSize=CGSizeMake(screenRect.size.width,hig);
    }
    firsthight=hig;
    [self showaddr];
}
-(void)showaddr
{
    int hig=hight;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (addphondeclbl.selected) {
        hig=hig+screenRect.size.height*0.20;
    }
    //    addrsview.frame=CGRectMake(screenRect.size.width*0.0,hig,screenRect.size.width,screenRect.size.height*0.50);
    
    if (primaryaddrs.selected) {
        NSLog(@"selecterd");
        primaryaddrs.selected=NO;
        addrsview.hidden=NO;
        downbtn2.selected=YES;
        hig=hig+screenRect.size.height*0.60;
        
        scrollView.contentSize=CGSizeMake(screenRect.size.width,hig);
    }
    else
    {
        addrsview.hidden=YES;
        downbtn2.selected=NO;
        primaryaddrs.selected=YES;
        scrollView.contentSize=CGSizeMake(screenRect.size.width,hig);
    }
    //
    //
    //    if (primaryaddrs.selected) {
    //
    //
    //
    //addrsview.frame=CGRectMake(screenRect.size.width*0.0,hig,screenRect.size.width,screenRect.size.height*0.50);
    //        scrollView.contentSize=CGSizeMake(screenRect.size.width,hig);
    //    }
    //        else
    //        {
    
    //
    //            hig=hig+screenRect.size.height*0.07;
    //
    //addrsview.frame=CGRectMake(screenRect.size.width*0.0,hig,screenRect.size.width,screenRect.size.height*0.50);
    //
    //
    //        }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)doneWithNumberPad{
    [mobiletxt resignFirstResponder];
    [scheduletxt resignFirstResponder];
    [workphone resignFirstResponder];
    [homephone resignFirstResponder];
    [otherphone resignFirstResponder];
    [postaltxt resignFirstResponder];
    
}
-(void)checkleads
{
    projectoremove= [[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *jsonDict=[[NSMutableDictionary alloc]init];
    [jsonDict setObject:@"25"forKey:@"ID"];
    NSMutableDictionary * data=[[NSMutableDictionary alloc]init];
    
    [data setObject:mobiletxt.text forKey:@"phone_mobile"];
    
    NSArray *dataarr=[NSArray arrayWithObject:data];
    [jsonDict setObject:dataarr  forKey:@"data"];
    NSString *jsonString;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        //  NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        // NSLog(@"Got Stringr %@",jsonString);
        //            NSArray* words = [jsonString componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //            jsonString = [words componentsJoinedByString:@""];
        //            jsonString=[jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    [indicator startAnimating];
    NSURL *url;
    NSMutableString *httpBodyString;
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@checklead.php?",[prefs objectForKey:@"Link"]];
    NSString *post =[NSString stringWithFormat:@"module_name=Leads&password=%@&username=%@&usersimplecrmId=%@&jsonParam=%@",[prefs objectForKey:@"password"],[prefs objectForKey:@"username"],[prefs objectForKey:@"user_id"],jsonString];
    NSData *postData = [post dataUsingEncoding:NSISOLatin1StringEncoding];
    
    url=[[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error)
        {
            NSLog(@"Failed to submit request");
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [indicator stopAnimating];
        }
        else
        {
            NSMutableString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                                 length:[data length] encoding: NSUTF8StringEncoding];
            NSLog(@"content %@",content);
            if ([content isEqualToString:@""]) {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Invalid Details" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [indicator stopAnimating];
                
            }else {
                NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0
                                                                         error:nil];
                NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
                NSDictionary *datadict =[dic objectForKey:@"data"];
                
                if ([[dic objectForKey:@"prospect_exists"]isEqualToString:@"yes"]) {
                    projectoremove=[datadict objectForKey:@"project_names"];
                    fnametxt.text=[datadict objectForKey:@"first_name"];
                    lnametxt.text=[datadict objectForKey:@"last_name"];
                    if (![lnametxt.text isEqualToString:@""]) {
                        lnametxt.enabled=NO;
                    }
                }
                else
                {
                    fnametxt.enabled=YES;
                    lnametxt.enabled=YES;
                }
                [indicator stopAnimating];
            }
        }
    }];
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *rowItem;
    
    if (pickerView == projectpicker)
    {
        rowItem = [projectarr objectAtIndex: row];
    }
    if (pickerView == stegespickeer)
    {
        rowItem = [stagearr objectAtIndex: row];
    }
    if (pickerView == statuwpicker)
    {
        rowItem = [statusarr objectAtIndex: row];
    }
    if (pickerView == sourcepicker)
    {
        rowItem = [sourcearr objectAtIndex: row];
    }
    if (pickerView == printpicker)
    {
        rowItem = [printarr objectAtIndex: row];
    }
    if (pickerView == assignpicker)
    {
        rowItem = [assignarr objectAtIndex: row];
    }
    if (pickerView == countrpicker)
    {
        rowItem = [countryarr objectAtIndex: row];
    }
    UILabel *lblRow = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView bounds].size.width, 44.0f)];
    [lblRow setTextAlignment:UITextAlignmentCenter];
    [lblRow setTextColor: [UIColor blackColor]];
    [lblRow setText:rowItem];
    UIFont * fonts =[UIFont fontWithName:@"Open Sans" size:15.0f];
    lblRow.font=fonts;
    [lblRow setBackgroundColor:[UIColor clearColor]];
    return lblRow;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView ==stegespickeer)
    {
        stagestr=[[NSString alloc]init];
        stagestr=[NSString stringWithFormat:@"%@",[stagearr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==statuwpicker)
    {
        statusstr=[[NSString alloc]init];
        statusstr=[NSString stringWithFormat:@"%@",[statusarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==projectpicker)
    {
        projectstr=[[NSString alloc]init];
        indstr=[[NSString alloc]init];
        projectstr=[NSString stringWithFormat:@"%@",[projectarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
        indstr=[NSString stringWithFormat:@"%@",[prosjectidarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==sourcepicker)
    {
        sourcestr=[[NSString alloc]init];
        sourcestr=[NSString stringWithFormat:@"%@",[sourcearr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==printpicker)
    {
        printstr=[[NSString alloc]init];
        printstr=[NSString stringWithFormat:@"%@",[printarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==assignpicker)
    {
        assignstr=[[NSString alloc]init];
        assignidstr=[[NSString alloc]init];
        assignstr=[NSString stringWithFormat:@"%@",[assignarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
        assignidstr=[NSString stringWithFormat:@"%@",[assignidarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
        
    }
    if (pickerView ==countrpicker)
    {
        countrstr=[[NSString alloc]init];
        countrstr=[NSString stringWithFormat:@"%@",[countryarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (pickerView == stegespickeer)
    {
        return [stagearr objectAtIndex:row];
    }
    if (pickerView == statuwpicker)
    {
        return [statusarr objectAtIndex:row];
    }
    if (pickerView == projectpicker)
    {
        return [projectarr objectAtIndex:row];
    }
    if (pickerView == sourcepicker)
    {
        return [sourcearr objectAtIndex:row];
    }
    if (pickerView == printpicker)
    {
        return [printarr objectAtIndex:row];
    }
    if (pickerView == assignpicker)
    {
        return [assignarr objectAtIndex:row];
    }
    if (pickerView == countrpicker)
    {
        return [countryarr objectAtIndex:row];
    }
    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat componentWidth = 0.0;
    componentWidth = 300.0;
    return componentWidth;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    projectpicker.hidden=YES;
    projectttlbar.hidden=YES;
    stagestoolbar.hidden=YES;
    statuwpicker.hidden=YES;
    stegespickeer.hidden=YES;
    statustoolbar.hidden=YES;
    sourcepicker.hidden=YES;
    sourcetoolbar.hidden=YES;
    printpicker.hidden=YES;
    printtoolbar.hidden=YES;
    assignpicker.hidden=YES;
    assigntotoolbar.hidden=YES;
    countrytoolbar.hidden=YES;
    countrpicker.hidden=YES;
    
    if (textField ==prospectstagestxt) {
        stagearr=[[NSMutableArray alloc]initWithObjects:@"Warm",@"Hot",@"Cold", nil];
        stegespickeer = [[UIPickerView alloc] init];
        [stegespickeer setDataSource: self];
        [stegespickeer setDelegate: self];
        stegespickeer.backgroundColor = [UIColor whiteColor];
        [stegespickeer setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        stegespickeer.showsSelectionIndicator = YES;
        [stegespickeer selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: stegespickeer];
        stegespickeer.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            stagestoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            stagestoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [stagestoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed1)];
        [leftButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                  forState:UIControlStateNormal];
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)];
        [rightButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                   forState:UIControlStateNormal];
        
        stagestoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:stagestoolbar];
        
        stagestoolbar.hidden=NO;
        [prospectstagestxt resignFirstResponder];
        return NO;
    }
    
    if (textField ==printtxt) {
        printpicker = [[UIPickerView alloc] init];
        [printpicker setDataSource: self];
        [printpicker setDelegate: self];
        printpicker.backgroundColor = [UIColor whiteColor];
        [printpicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        printpicker.showsSelectionIndicator = YES;
        [printpicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: printpicker];
        printpicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            printtoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            printtoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [printtoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed5)];
        [leftButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                  forState:UIControlStateNormal];
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)];
        [rightButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                   forState:UIControlStateNormal];
        
        printtoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:printtoolbar];
        
        printtoolbar.hidden=NO;
        [printtxt resignFirstResponder];
        return NO;
    }
    if (textField ==prospectstatustxt) {
        statusarr=[[NSMutableArray alloc]initWithObjects:@"Warm",@"Hot",@"Cold", nil];
        
        statuwpicker = [[UIPickerView alloc] init];
        [statuwpicker setDataSource: self];
        [statuwpicker setDelegate: self];
        statuwpicker.backgroundColor = [UIColor whiteColor];
        [statuwpicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        statuwpicker.showsSelectionIndicator = YES;
        [statuwpicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: statuwpicker];
        statuwpicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            statustoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            statustoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [statustoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed3)];
        [leftButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                  forState:UIControlStateNormal];
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)];
        [rightButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                   forState:UIControlStateNormal];
        
        statustoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:statustoolbar];
        
        statustoolbar.hidden=NO;
        [prospectstatustxt resignFirstResponder];
        return NO;
    }
    if (textField ==projectstxt) {
        projectarr=[[NSMutableArray alloc]init];
        prosjectidarr=[[NSMutableArray alloc]init];
        
        for (int i=0; i<appDelegate.projectarr.count; i++) {
            NSDictionary* dict=[appDelegate.projectarr objectAtIndex:i];
            [projectarr addObject:[dict objectForKey:@"name"]];
            [prosjectidarr addObject:[dict objectForKey:@"id"]];
        }
        NSMutableArray *unfilterarr=[projectoremove mutableCopy];
        for(int i=unfilterarr.count-1;i>=0;i--){
            if([[unfilterarr objectAtIndex:i] isEqual:[NSNull null]]|| ([projectoremove objectAtIndex:i]==nil)){
                [unfilterarr removeObjectAtIndex:i];
            }
        }
        projectoremove=[unfilterarr mutableCopy];
        if (projectoremove.count>0) {
            for (int i=0; i<projectoremove.count; i++) {
                for (NSInteger j=projectarr.count-1;j>=0;j--) {
                    if ([[projectoremove objectAtIndex:i]isEqualToString:[projectarr objectAtIndex:j]]) {
                        [projectarr removeObject:[projectarr objectAtIndex:j]];
                        [prosjectidarr removeObjectAtIndex:j];
                    }
                }
            }
            
        }
        projectpicker = [[UIPickerView alloc] init];
        [projectpicker setDataSource: self];
        [projectpicker setDelegate: self];
        projectpicker.backgroundColor = [UIColor whiteColor];
        [projectpicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        projectpicker.showsSelectionIndicator = YES;
        [projectpicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: projectpicker];
        projectpicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            projectttlbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            projectttlbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed2)];
        
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)];
        
        projectttlbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:projectttlbar];
        
        projectttlbar.hidden=NO;
        [projectstxt resignFirstResponder];
        return NO;
    }
    if (textField ==prsspectsourcetxt) {
        sourcearr=[sourcedict objectForKey:@"primary_source"];
        sourcepicker = [[UIPickerView alloc] init];
        [sourcepicker setDataSource: self];
        [sourcepicker setDelegate: self];
        sourcepicker.backgroundColor = [UIColor whiteColor];
        [sourcepicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        sourcepicker.showsSelectionIndicator = YES;
        [sourcepicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: sourcepicker];
        sourcepicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            sourcetoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            sourcetoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [sourcetoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed4)];
        [leftButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                  forState:UIControlStateNormal];
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)];
        [rightButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                   forState:UIControlStateNormal];
        
        sourcetoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:sourcetoolbar];
        
        sourcetoolbar.hidden=NO;
        [prsspectsourcetxt resignFirstResponder];
        return NO;
    }
    
    if (textField ==_assigntotext) {
        
        assignpicker = [[UIPickerView alloc] init];
        [assignpicker setDataSource: self];
        [assignpicker setDelegate: self];
        assignpicker.backgroundColor = [UIColor whiteColor];
        [assignpicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        assignpicker.showsSelectionIndicator = YES;
        [assignpicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: assignpicker];
        assignpicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            assigntotoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            assigntotoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [assigntotoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed6)];
        [leftButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                  forState:UIControlStateNormal];
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)];
        [rightButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                   forState:UIControlStateNormal];
        
        assigntotoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:assigntotoolbar];
        
        assigntotoolbar.hidden=NO;
        [_assigntotext resignFirstResponder];
        return NO;
    }
    if (textField ==countrcodetxt) {
        countryarr=[[NSMutableArray alloc]initWithObjects:@"+91",@"+971",@"+44",@"+60",@"+65",@"+94",@"+1", nil];
        countrpicker = [[UIPickerView alloc] init];
        [countrpicker setDataSource: self];
        [countrpicker setDelegate: self];
        countrpicker.backgroundColor = [UIColor whiteColor];
        [countrpicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        countrpicker.showsSelectionIndicator = YES;
        [countrpicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: countrpicker];
        countrpicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            countrytoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            countrytoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [countrytoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed0)];
        [leftButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                  forState:UIControlStateNormal];
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)];
        [rightButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                   forState:UIControlStateNormal];
        
        countrytoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:countrytoolbar];
        
        countrytoolbar.hidden=NO;
        [countrcodetxt resignFirstResponder];
        return NO;
    }
    return YES;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if ([pickerView isEqual: projectpicker]) {
        return [projectarr count];
    }
    if ([pickerView isEqual: stegespickeer]) {
        return [stagearr count];
    }
    if ([pickerView isEqual: statuwpicker]) {
        return [statusarr count];
    }
    if ([pickerView isEqual: sourcepicker]) {
        return [sourcearr count];
    }
    if ([pickerView isEqual: printpicker]) {
        return [printarr count];
    }
    if ([pickerView isEqual: assignpicker]) {
        return [assignarr count];
    }
    if ([pickerView isEqual: countrpicker]) {
        return [countryarr count];
    }
    return 0;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
-(IBAction)doneBtnPressed2{
    projectpicker.hidden=YES;
    projectttlbar.hidden=YES;
    
    if ([projectstr isEqualToString:@""] || projectstr==nil) {
        if (projectarr.count>0) {
            projectstxt.text=[projectarr objectAtIndex:0];
            indstr=[prosjectidarr objectAtIndex:0];
        }
    }
    else{
        projectstxt.text=projectstr;
    }
}
-(IBAction)doneBtnPressed1{
    stagestoolbar.hidden=YES;
    stegespickeer.hidden=YES;
    
    if ([stagestr isEqualToString:@""] || stagestr==nil) {
        if (stagearr.count>0) {
            prospectstagestxt.text=[stagearr objectAtIndex:0];
        }
    }
    else{
        prospectstagestxt.text=stagestr;
    }
}
-(IBAction)doneBtnPressed3{
    statustoolbar.hidden=YES;
    statuwpicker.hidden=YES;
    
    if ([statusstr isEqualToString:@""] || statusstr==nil) {
        if (statusarr.count>0) {
            prospectstatustxt.text=[statusarr objectAtIndex:0];
        }
    }
    else{
        prospectstatustxt.text=statusstr;
    }
}
-(IBAction)doneBtnPressed5{
    printpicker.hidden=YES;
    printtoolbar.hidden=YES;
    
    if ([printstr isEqualToString:@""] || printstr==nil) {
        if (printarr.count>0) {
            printtxt.text=[printarr objectAtIndex:0];
        }
    }
    else{
        printtxt.text=printstr;
    }
}
-(IBAction)doneBtnPressed6{
    assigntotoolbar.hidden=YES;
    assignpicker.hidden=YES;
    
    if ([assignstr isEqualToString:@""] || assignstr==nil) {
        if (assignarr.count>0) {
            _assigntotext.text=[assignarr objectAtIndex:0];
            assignidstr=[assignidarr objectAtIndex:0];
        }
    }
    else{
        _assigntotext.text=assignstr;
    }
}
-(IBAction)doneBtnPressed0{
    countrytoolbar.hidden=YES;
    countrpicker.hidden=YES;
    
    if ([countrstr isEqualToString:@""] || countrstr==nil) {
        if (countryarr.count>0) {
            countrcodetxt.text=[countryarr objectAtIndex:0];
        }
    }
    else{
        countrcodetxt.text=countrstr;
    }
}
-(IBAction)doneBtnPressed4{
    sourcetoolbar.hidden=YES;
    sourcepicker.hidden=YES;
    printarr=[[NSMutableArray alloc]init];
    if ([sourcestr isEqualToString:@""] || sourcestr==nil) {
        if (sourcearr.count>0) {
            prsspectsourcetxt.text=[sourcearr objectAtIndex:0];
        }
    }
    else{
        prsspectsourcetxt.text=sourcestr;
    }
    if ([sourcestr isEqualToString:@"Print"]) {
        printarr=[sourcedict objectForKey:@"print"];
        
        printtxt.hidden=NO;
        printtxt.placeholder=@"Print";
        chanelpartnertxt.hidden=YES;
        referedbycustprotxt.hidden=YES;
        refbycustnotxt.hidden=YES;
    }
    else  if ([sourcestr isEqualToString:@"Radio"]) {
        printarr=[sourcedict objectForKey:@"radio"];
        printtxt.hidden=NO;
        printtxt.placeholder=@"Radio";
        chanelpartnertxt.hidden=YES;
        referedbycustprotxt.hidden=YES;
        refbycustnotxt.hidden=YES;
        
    }else if ([sourcestr isEqualToString:@"Digital"]) {
        printarr=[sourcedict objectForKey:@"digital"];
        printtxt.hidden=NO;
        printtxt.placeholder=@"Digital";
        chanelpartnertxt.hidden=YES;
        referedbycustprotxt.hidden=YES;
        refbycustnotxt.hidden=YES;
        
    }else if ([sourcestr isEqualToString:@"Channel Partner"]) {
        printtxt.hidden=YES;
        chanelpartnertxt.hidden=NO;
        referedbycustprotxt.hidden=YES;
        refbycustnotxt.hidden=YES;
    }
    else if ([sourcestr isEqualToString:@"Customer Referral"]) {
        printtxt.hidden=YES;
        chanelpartnertxt.hidden=YES;
        refbycustnotxt.hidden=NO;
        referedbycustprotxt.hidden=NO;
    }
    else
    {
        referedbycustprotxt.hidden=YES;
        refbycustnotxt.hidden=YES;
        printtxt.hidden=YES;
        chanelpartnertxt.hidden=YES;
    }
    
}
-(IBAction)cancelBtnpress{
    stagestoolbar.hidden=YES;
    statuwpicker.hidden=YES;
    stegespickeer.hidden=YES;
    statustoolbar.hidden=YES;
    projectpicker.hidden=YES;
    projectttlbar.hidden=YES;
    sourcetoolbar.hidden=YES;
    sourcepicker.hidden=YES;
    printpicker.hidden=YES;
    printtoolbar.hidden=YES;
    assigntotoolbar.hidden=YES;
    assignpicker.hidden=YES;
    countrytoolbar.hidden=YES;
    countrpicker.hidden=YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    //Keyboard becomes visible
    
    scrollView.frame = CGRectMake(scrollView.frame.origin.x,
                                  scrollView.frame.origin.y,
                                  scrollView.frame.size.width,
                                  scrollView.frame.size.height - 250 );
    //resize
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==mobiletxt)
    {
        if(textField.text.length >9 && range.length == 0)
        {
            return NO;
        }
    }
    return YES;
}
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    //keyboard will hide
    
    scrollView.frame = CGRectMake(scrollView.frame.origin.x,
                                  scrollView.frame.origin.y,
                                  scrollView.frame.size.width,
                                  scrollView.frame.size.height + 250 );
    
    if (textField==mobiletxt) {
        if (![mobiletxt.text isEqual:@""]&&mobiletxt.text.length==10) {
            [self checkleads];
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Mobile number is invalid"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
}
-(void)backbtn{
    [self.navigationController popViewControllerAnimated:YES];
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

