//
//  AddbookingViewController.m
//  Sales App
//
//  Created by Infinitum on 22/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//
#import "AddbookingViewController.h"
#import "UIColor+Expanded.h"
#import "RPFloatingPlaceholderTextField.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <ACFloatingTextField.h>
#import <AFNetworking.h>
#import <DLRadioButton.h>
#import "MyBookingViewController.h"

@interface AddbookingViewController ()<UITextFieldDelegate,UITextFieldAutoSuggestionDataSource>
@property (weak, nonatomic) IBOutlet ACFloatingTextField *textFieldUserName;
@property (nonatomic, retain) NSString *radiobtntxt,*selectedstr;
@property (nonatomic, retain) UIView *bottmborder1,*bottmborder2,*bottmborder3,*bottmborder4,*view1,*view2,*view3,*view4,*view5,*bottmborder5,*demoView,*checkboxview;
@end
@implementation AddbookingViewController
@synthesize scrollView,step1btn,step2btn,step3btn,step4btn,nametxt,buildingtxt,sitestr,sitenamearr,sitenametoolbar,sitenamepickerview,collectioonview,step5btn,projectnamearr,projectnamestr,projectpickerview,projectnametoolbar,TakePhotoView,view2scrollview,schemearr,schemestr,schemetxt,schemetoolbar,schemepickerview,descontvaluetxt,discountremarktxt,revisedagrttxt,tableViewHome,custaddrtxt,custnametxt,custemailtxt,custmobnotxt,custSourcetxt,numberToolbarzip,view5scrollview,bankamountxt,typeofpayment,typeofpaymentstr,typeofpaymentoolbar,typeofpaymentpicker,Typeofpaymentarr,checktableview,addbtn,captureimgbtn,capturebookingbtn,remainingtxt,rmarktxt,chequeimage,bookingimage,indicator,siteidstr,unitsarr,flatyplbl2,unitlbl2,carlbl2,redcarpetlbl2,totalagrlbl2,totalarwlbl2,schemeidstr,agrementvaluetxt,registrationchartxt,stampdutytxt,gstlbltxt,legaldocchartxt,totalcosttxt,pamentschemetxt,handedovertotext,amounttxt,comefromstr,projectarr,revisedagrementvaluetxt,cibiltext,Customertypetxt,customertypestr,customertypepicker,customertypetoolbar,customertypearr,step3radiobtn,remaingbtn,businessdetailstxt,sourcetxt,sourcedict,sourcestr,sourcearr,sourcepicker,sourcetoolbar,paymentgateybtn,flooridstr,floorno,chequeinstrumentdatetxt,chequeimage2,chequeimage3,chequeimagecollectionview,imagerarr,datePicker,countrcodetxt,countrytoolbar,countrpicker,countryarr,countrstr,finalbookbtn,timer,approvebtn,chequeAmountxt,remainingamtdict,unitlbl,assignlbl,view4scrollview,bk_numstr,indexarray;

NSMutableArray *colorNames;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    _buildingarr=[[NSMutableArray alloc]init];
    sitenamearr=[[NSMutableArray alloc]init];
    _siteidarr=[[NSMutableArray alloc]init];
    siteidstr=[[NSString alloc]init];
    _schemeidarr=[[NSMutableArray alloc]init];
    schemeidstr=[[NSString alloc]init];
    schemearr=[[NSMutableArray alloc]init];
    projectarr=[[NSMutableArray alloc]init];
    projectnamearr=[[NSMutableArray alloc]init];
    _projectidarr=[[NSMutableArray alloc]init];
_projectidstr=[[NSString alloc]init];
    _floorarr=[[NSMutableArray alloc]init];
    imagerarr=[[NSMutableArray alloc]init];
    remainingamtdict=[[NSMutableDictionary alloc]init];
    _chequeamountarr=[[NSMutableArray alloc]init];
    indexarray=[[NSMutableArray alloc]init];
    indexcount=1;
    if (bk_numstr==nil) {
        bk_numstr=@"";
    }
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(triggerAction:) name:@"onlinebooking" object:nil];
    
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.20,screenRect.size.height*.03,screenRect.size.width*.50,screenRect.size.height*.07)];
    titlelable.textAlignment = NSTextAlignmentCenter;
    titlelable.text=@"Booking";
    titlelable.textColor=[UIColor whiteColor];
    [titlelable setBackgroundColor:[UIColor clearColor]];
    titlelable.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:titlelable];
    
  unitlbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.70,screenRect.size.height*.03,screenRect.size.width*.30,screenRect.size.height*.07)];
    unitlbl.textAlignment = NSTextAlignmentCenter;
    unitlbl.text=@"";
    unitlbl.textColor=[UIColor whiteColor];
    [unitlbl setBackgroundColor:[UIColor clearColor]];
    unitlbl.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:unitlbl];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:self action:@selector(backbtn) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE5C4" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];
    
    CGRect scrollViewFrame = CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.17,screenRect.size.width,screenRect.size.height*0.83);
    scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
   // scrollView.contentSize=CGSizeMake(screenRect.size.width*2.4,screenRect.size.height*0.05);
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    step1btn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.10,screenRect.size.width*0.20,screenRect.size.height*0.07)];
    [step1btn setTitle:@"Step 1" forState:UIControlStateNormal];
    [step1btn setTitleColor:[UIColor colorWithHexString:@"#d7d7d7"] forState:UIControlStateNormal];
    [step1btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    step1btn.selected=YES;
    step1btn.tag=1;
    step1btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [step1btn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [step1btn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.05]];
    step1btn.backgroundColor=[UIColor colorWithHexString:@"#00bfff"];
    [self.view addSubview:step1btn];
    _bottmborder1 = [[UIView alloc] initWithFrame:CGRectMake(0, step1btn.frame.size.height - 1.5f, step1btn.frame.size.width, 1.5)];
    _bottmborder1.backgroundColor = [UIColor yellowColor];
    [step1btn addSubview:_bottmborder1];
    
    step2btn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.10,screenRect.size.width*0.20,screenRect.size.height*0.07)];
    [step2btn setTitle:@"Step 2" forState:UIControlStateNormal];
    step2btn.tag=2;
    [step2btn setTitleColor:[UIColor colorWithHexString:@"#d7d7d7"] forState:UIControlStateNormal];
    [step2btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    step2btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
   // [step2btn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [step2btn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.05]];
    step2btn.backgroundColor=[UIColor colorWithHexString:@"#00bfff"];
    _bottmborder2 = [[UIView alloc] initWithFrame:CGRectMake(0, step2btn.frame.size.height - 1.5f, step2btn.frame.size.width, 1.5)];
    _bottmborder2.backgroundColor = [UIColor yellowColor];
    [step2btn addSubview:_bottmborder2];
    _bottmborder2.hidden=YES;
    
    [self.view addSubview:step2btn];
    step3btn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.10,screenRect.size.width*0.20,screenRect.size.height*0.07)];
    [step3btn setTitle:@"Step 3" forState:UIControlStateNormal];
    step3btn.tag=3;
    [step3btn setTitleColor:[UIColor colorWithHexString:@"#d7d7d7"] forState:UIControlStateNormal];
    [step3btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    step3btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  //  [step3btn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [step3btn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.05]];
    step3btn.backgroundColor=[UIColor colorWithHexString:@"#00bfff"];
    [self.view addSubview:step3btn];
    _bottmborder3 = [[UIView alloc] initWithFrame:CGRectMake(0, step3btn.frame.size.height - 1.5f, step3btn.frame.size.width, 1.5)];
    _bottmborder3.backgroundColor = [UIColor yellowColor];
    [step3btn addSubview:_bottmborder3];
    _bottmborder3.hidden=YES;
    
    step4btn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.60,screenRect.size.height*0.10,screenRect.size.width*0.20,screenRect.size.height*0.07)];
    step4btn.tag=4;
    [step4btn setTitle:@"Step 4" forState:UIControlStateNormal];
    [step4btn setTitleColor:[UIColor colorWithHexString:@"#d7d7d7"] forState:UIControlStateNormal];
    [step4btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    step4btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
 //   [step4btn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [step4btn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.05]];
    step4btn.backgroundColor=[UIColor colorWithHexString:@"#00bfff"];
    [self.view addSubview:step4btn];
    _bottmborder4 = [[UIView alloc] initWithFrame:CGRectMake(0, step4btn.frame.size.height - 1.5f, step4btn.frame.size.width, 1.5)];
    _bottmborder4.backgroundColor = [UIColor yellowColor];
    [step4btn addSubview:_bottmborder4];
    _bottmborder4.hidden=YES;

    step5btn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.80,screenRect.size.height*0.10,screenRect.size.width*0.20,screenRect.size.height*0.07)];
    step5btn.tag=5;
    [step5btn setTitle:@"Step 5" forState:UIControlStateNormal];
    [step5btn setTitleColor:[UIColor colorWithHexString:@"#d7d7d7"] forState:UIControlStateNormal];
    [step5btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    step5btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [step5btn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [step5btn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.05]];
    step5btn.backgroundColor=[UIColor colorWithHexString:@"#00bfff"];
    [self.view addSubview:step5btn];
    
    _bottmborder5 = [[UIView alloc] initWithFrame:CGRectMake(0, step5btn.frame.size.height - 1.5f, step5btn.frame.size.width, 1.5)];
    _bottmborder5.backgroundColor = [UIColor yellowColor];
    [step5btn addSubview:_bottmborder5];
    _bottmborder5.hidden=YES;
    
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.90)];
    [scrollView addSubview:_view1];
    _view1.backgroundColor=[UIColor clearColor];
    {
        count=1;
    nametxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.03,screenRect.size.width*0.90,screenRect.size.height*0.07)];
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
    bottomBorders3.backgroundColor = [UIColor grayColor].CGColor;
    [nametxt.layer addSublayer:bottomBorders3];
    nametxt.placeholder=@"Project Name*";
        nametxt.text=[_dict objectForKey:@"project_name"];
        _projectidstr=[_dict objectForKey:@"project_id"];

    nametxt.font = [UIFont systemFontOfSize:14];
    [_view1 addSubview:nametxt];
    
    buildingtxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.13,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    buildingtxt.textAlignment=NSTextAlignmentLeft;
    buildingtxt.delegate = self;
    buildingtxt.textColor=[UIColor blackColor];
    [buildingtxt setBackgroundColor:[UIColor clearColor]];
    buildingtxt.leftViewMode = UITextFieldViewModeAlways;
    [buildingtxt setKeyboardType:UIKeyboardTypeEmailAddress];
    buildingtxt.returnKeyType=UIReturnKeyDone;
    buildingtxt.floatingLabelActiveTextColor = [UIColor redColor];
    buildingtxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders1 = [CALayer layer];
    bottomBorders1.frame = CGRectMake(0.0f, nametxt.frame.size.height - 5, nametxt.frame.size.width, 1.5f);
    bottomBorders1.backgroundColor = [UIColor grayColor].CGColor;
    [buildingtxt.layer addSublayer:bottomBorders1];
    buildingtxt.placeholder=@"Select Building*";
    buildingtxt.font = [UIFont systemFontOfSize:14];
    [_view1 addSubview:buildingtxt];
}
    _view2 = [[UIView alloc] initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.83)];
    [scrollView addSubview:_view2];
    _view2.backgroundColor=[UIColor clearColor];
    _view2.hidden=YES;
    {
        UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.20,screenRect.size.height*.0,screenRect.size.width*.60,screenRect.size.height*.07)];
        titlelable.textAlignment = NSTextAlignmentCenter;
        titlelable.text=@"Flat Details";
        titlelable.textColor=[UIColor blackColor];
        [titlelable setBackgroundColor:[UIColor clearColor]];
        titlelable.font=[UIFont systemFontOfSize:18];
        [_view2 addSubview:titlelable];
        
        CGRect scrollViewFrame1 = CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.07,screenRect.size.width,screenRect.size.height*0.68);
        view2scrollview = [[UIScrollView alloc] initWithFrame:scrollViewFrame1];
        view2scrollview.backgroundColor=[UIColor clearColor];
        view2scrollview.delegate = self;
        view2scrollview.showsHorizontalScrollIndicator = NO;
        [_view2 addSubview:view2scrollview];
        
        int hig=screenRect.size.height*0.02;
        
        schemetxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        schemetxt.textAlignment=NSTextAlignmentLeft;
        schemetxt.delegate = self;
        schemetxt.textColor=[UIColor blackColor];
        [schemetxt setBackgroundColor:[UIColor clearColor]];
        schemetxt.leftViewMode = UITextFieldViewModeAlways;
        [schemetxt setKeyboardType:UIKeyboardTypeEmailAddress];
        schemetxt.returnKeyType=UIReturnKeyDone;
        schemetxt.floatingLabelActiveTextColor = [UIColor redColor];
        schemetxt.floatingLabelInactiveTextColor = [UIColor grayColor];
        CALayer *bottomBorders3 = [CALayer layer];
        bottomBorders3.frame = CGRectMake(0.0f, schemetxt.frame.size.height - 5, schemetxt.frame.size.width, 1.0f);
        bottomBorders3.backgroundColor = [UIColor lightGrayColor].CGColor;
        [schemetxt.layer addSublayer:bottomBorders3];
        schemetxt.placeholder=@"Select Scheme*";
        schemetxt.font = [UIFont systemFontOfSize:14];
        [view2scrollview addSubview:schemetxt];
        
        hig=hig+screenRect.size.height*0.1;
        
        descontvaluetxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        descontvaluetxt.textAlignment=NSTextAlignmentLeft;
        descontvaluetxt.delegate = self;
        descontvaluetxt.textColor=[UIColor blackColor];
        [descontvaluetxt setBackgroundColor:[UIColor clearColor]];
        descontvaluetxt.leftViewMode = UITextFieldViewModeAlways;
        [descontvaluetxt setKeyboardType:UIKeyboardTypeEmailAddress];
        descontvaluetxt.returnKeyType=UIReturnKeyDone;
        descontvaluetxt.floatingLabelActiveTextColor = [UIColor redColor];
        descontvaluetxt.floatingLabelInactiveTextColor = [UIColor grayColor];
        CALayer *bottomBorders1 = [CALayer layer];
        bottomBorders1.frame = CGRectMake(0.0f, descontvaluetxt.frame.size.height - 5, descontvaluetxt.frame.size.width, 1.0f);
        bottomBorders1.backgroundColor = [UIColor lightGrayColor].CGColor;
        [descontvaluetxt.layer addSublayer:bottomBorders1];
        descontvaluetxt.placeholder=@"Discount Value";
        numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbarzip.barStyle = UIBarStyleBlackOpaque;
        numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbarzip sizeToFit];
        numberToolbarzip.tintColor=[UIColor whiteColor];
        descontvaluetxt.inputAccessoryView = numberToolbarzip;
        descontvaluetxt.leftViewMode = UITextFieldViewModeAlways;
        descontvaluetxt.keyboardType = UIKeyboardTypeDecimalPad;
        descontvaluetxt.font = [UIFont systemFontOfSize:14];
        [view2scrollview addSubview:descontvaluetxt];
        
        hig=hig+screenRect.size.height*0.1;
        
        discountremarktxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        discountremarktxt.textAlignment=NSTextAlignmentLeft;
        discountremarktxt.delegate = self;
        discountremarktxt.textColor=[UIColor blackColor];
        [discountremarktxt setBackgroundColor:[UIColor clearColor]];
        discountremarktxt.leftViewMode = UITextFieldViewModeAlways;
        [discountremarktxt setKeyboardType:UIKeyboardTypeEmailAddress];
        discountremarktxt.returnKeyType=UIReturnKeyDone;
        discountremarktxt.floatingLabelActiveTextColor = [UIColor redColor];
        discountremarktxt.floatingLabelInactiveTextColor = [UIColor grayColor];
        CALayer *bottomBorders2 = [CALayer layer];
        bottomBorders2.frame = CGRectMake(0.0f, discountremarktxt.frame.size.height - 5, discountremarktxt.frame.size.width, 1.0f);
        bottomBorders2.backgroundColor = [UIColor lightGrayColor].CGColor;
        [discountremarktxt.layer addSublayer:bottomBorders2];
        discountremarktxt.placeholder=@"Discount Remark";
        discountremarktxt.font = [UIFont systemFontOfSize:14];
        [view2scrollview addSubview:discountremarktxt];
        
        hig=hig+screenRect.size.height*0.1;
        
        revisedagrttxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        revisedagrttxt.textAlignment=NSTextAlignmentLeft;
        revisedagrttxt.delegate = self;
        revisedagrttxt.textColor=[UIColor grayColor];
        [revisedagrttxt setBackgroundColor:[UIColor clearColor]];
        revisedagrttxt.leftViewMode = UITextFieldViewModeAlways;
        [revisedagrttxt setKeyboardType:UIKeyboardTypeEmailAddress];
        revisedagrttxt.returnKeyType=UIReturnKeyDone;
        revisedagrttxt.floatingLabelActiveTextColor = [UIColor redColor];
        revisedagrttxt.floatingLabelInactiveTextColor = [UIColor lightGrayColor];
        CALayer *bottomBorders0 = [CALayer layer];
        bottomBorders0.frame = CGRectMake(0.0f, revisedagrttxt.frame.size.height - 5, revisedagrttxt.frame.size.width, 1.0f);
        bottomBorders0.backgroundColor = [UIColor lightGrayColor].CGColor;
        [revisedagrttxt.layer addSublayer:bottomBorders0];
        revisedagrttxt.placeholder=@"Revised Agreement Value";
        revisedagrttxt.font = [UIFont systemFontOfSize:14];
        revisedagrttxt.enabled=NO;
        [view2scrollview addSubview:revisedagrttxt];
        
        hig=hig+screenRect.size.height*0.1;

        UILabel *unitlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.40,screenRect.size.height*0.06)];
        unitlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        unitlbl.text=@"Unit No";
        [unitlbl setTextColor:[UIColor blackColor]];
        unitlbl.backgroundColor=[UIColor clearColor];
        unitlbl.textAlignment = NSTextAlignmentLeft;
        [view2scrollview addSubview:unitlbl];
        CALayer *bottomBorders4 = [CALayer layer];
        bottomBorders4.frame = CGRectMake(0.0f, unitlbl.frame.size.height - 5, unitlbl.frame.size.width, 1.0f);
        bottomBorders4.backgroundColor = [UIColor lightGrayColor].CGColor;
        [unitlbl.layer addSublayer:bottomBorders4];
        
       unitlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.55,hig,screenRect.size.width*0.40,screenRect.size.height*0.06)];
        unitlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        [unitlbl2 setTextColor:[UIColor blackColor]];
        unitlbl2.backgroundColor=[UIColor clearColor];
        unitlbl2.textAlignment = NSTextAlignmentLeft;
        [view2scrollview addSubview:unitlbl2];
        
        hig=hig+screenRect.size.height*0.08;

        UILabel *flatyplbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.40,screenRect.size.height*0.06)];
        flatyplbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        flatyplbl.text=@"Flat Type";
        [flatyplbl setTextColor:[UIColor blackColor]];
        flatyplbl.backgroundColor=[UIColor clearColor];
        flatyplbl.textAlignment = NSTextAlignmentLeft;
        [view2scrollview addSubview:flatyplbl];
        CALayer *bottomBorders5 = [CALayer layer];
        bottomBorders5.frame = CGRectMake(0.0f, unitlbl.frame.size.height - 5, unitlbl.frame.size.width, 1.0f);
        bottomBorders5.backgroundColor = [UIColor lightGrayColor].CGColor;
        [flatyplbl.layer addSublayer:bottomBorders5];
        
       flatyplbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.55,hig,screenRect.size.width*0.40,screenRect.size.height*0.06)];
        flatyplbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        [flatyplbl2 setTextColor:[UIColor blackColor]];
        flatyplbl2.backgroundColor=[UIColor clearColor];
        flatyplbl2.textAlignment = NSTextAlignmentLeft;
        [view2scrollview addSubview:flatyplbl2];
        
        hig=hig+screenRect.size.height*0.08;
        
        UILabel *carpetlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.40,screenRect.size.height*0.06)];
        carpetlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        carpetlbl.text=@"Carpet Area";
        [carpetlbl setTextColor:[UIColor blackColor]];
        carpetlbl.backgroundColor=[UIColor clearColor];
        carpetlbl.textAlignment = NSTextAlignmentLeft;
        [view2scrollview addSubview:carpetlbl];
        CALayer *bottomBorders6 = [CALayer layer];
        bottomBorders6.frame = CGRectMake(0.0f, carpetlbl.frame.size.height - 5, carpetlbl.frame.size.width, 1.0f);
        bottomBorders6.backgroundColor = [UIColor lightGrayColor].CGColor;
        [carpetlbl.layer addSublayer:bottomBorders6];
        
       carlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.55,hig,screenRect.size.width*0.40,screenRect.size.height*0.06)];
        carlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        [carlbl2 setTextColor:[UIColor blackColor]];
        carlbl2.backgroundColor=[UIColor clearColor];
        carlbl2.textAlignment = NSTextAlignmentLeft;
        [view2scrollview addSubview:carlbl2];
        
        hig=hig+screenRect.size.height*0.08;
        
        UILabel *redcarpetlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.40,screenRect.size.height*0.06)];
        redcarpetlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        redcarpetlbl.text=@"Red Carpet Area";
        [redcarpetlbl setTextColor:[UIColor blackColor]];
        redcarpetlbl.backgroundColor=[UIColor clearColor];
        redcarpetlbl.textAlignment = NSTextAlignmentLeft;
        [view2scrollview addSubview:redcarpetlbl];
        CALayer *bottomBorders7 = [CALayer layer];
        bottomBorders7.frame = CGRectMake(0.0f, redcarpetlbl.frame.size.height - 5, redcarpetlbl.frame.size.width, 1.0f);
        bottomBorders7.backgroundColor = [UIColor lightGrayColor].CGColor;
        [redcarpetlbl.layer addSublayer:bottomBorders7];
        
       redcarpetlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.55,hig,screenRect.size.width*0.40,screenRect.size.height*0.06)];
        redcarpetlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        [redcarpetlbl2 setTextColor:[UIColor blackColor]];
        redcarpetlbl2.backgroundColor=[UIColor clearColor];
        redcarpetlbl2.textAlignment = NSTextAlignmentLeft;
        [view2scrollview addSubview:redcarpetlbl2];
        
        hig=hig+screenRect.size.height*0.08;
        
        UILabel *totalarwlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.40,screenRect.size.height*0.06)];
        totalarwlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        totalarwlbl.text=@"Total Area";
        [totalarwlbl setTextColor:[UIColor blackColor]];
        totalarwlbl.backgroundColor=[UIColor clearColor];
        totalarwlbl.textAlignment = NSTextAlignmentLeft;
        [view2scrollview addSubview:totalarwlbl];
        CALayer *bottomBorders8 = [CALayer layer];
        bottomBorders8.frame = CGRectMake(0.0f, totalarwlbl.frame.size.height - 5, totalarwlbl.frame.size.width, 1.0f);
        bottomBorders8.backgroundColor = [UIColor lightGrayColor].CGColor;
        [totalarwlbl.layer addSublayer:bottomBorders8];
        
       totalarwlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.55,hig,screenRect.size.width*0.40,screenRect.size.height*0.06)];
        totalarwlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        [totalarwlbl2 setTextColor:[UIColor blackColor]];
        totalarwlbl2.backgroundColor=[UIColor clearColor];
        totalarwlbl2.textAlignment = NSTextAlignmentLeft;
        [view2scrollview addSubview:totalarwlbl2];
        
        hig=hig+screenRect.size.height*0.08;
        
        UILabel *totalagrlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.40,screenRect.size.height*0.06)];
        totalagrlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        totalagrlbl.text=@"Agreement Value";
        [totalagrlbl setTextColor:[UIColor blackColor]];
        totalagrlbl.backgroundColor=[UIColor clearColor];
        totalagrlbl.textAlignment = NSTextAlignmentLeft;
        [view2scrollview addSubview:totalagrlbl];
        CALayer *bottomBorders9 = [CALayer layer];
        bottomBorders9.frame = CGRectMake(0.0f, totalagrlbl.frame.size.height - 5, totalagrlbl.frame.size.width, 1.0f);
        bottomBorders9.backgroundColor = [UIColor lightGrayColor].CGColor;
        [totalagrlbl.layer addSublayer:bottomBorders9];
        
       totalagrlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.55,hig,screenRect.size.width*0.40,screenRect.size.height*0.06)];
        totalagrlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        [totalagrlbl2 setTextColor:[UIColor blackColor]];
        totalagrlbl2.backgroundColor=[UIColor clearColor];
        totalagrlbl2.textAlignment = NSTextAlignmentLeft;
        [view2scrollview addSubview:totalagrlbl2];
        
       approvebtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*.25,screenRect.size.height*.76,screenRect.size.width*.50,screenRect.size.height*.07)];
        [approvebtn setTitle:@"Proceed" forState:UIControlStateNormal];
        approvebtn.font=[UIFont systemFontOfSize:14];
        [approvebtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        // [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
        approvebtn.tag=3;
        [approvebtn setBackgroundColor:[UIColor colorWithHexString:@"#F8F8F8"]];
        [approvebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [approvebtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        approvebtn.layer.borderColor = [UIColor grayColor].CGColor;
        approvebtn.layer.borderWidth = 0.5;
        [_view2 addSubview:approvebtn];
        
        hig=hig+screenRect.size.height*0.10;
        view2scrollview.contentSize=CGSizeMake(screenRect.size.width,hig);
    }
    _view3 = [[UIView alloc] initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.83)];
    [scrollView addSubview:_view3];
    _view3.backgroundColor=[UIColor clearColor];
    _view3.hidden=YES;
    {
         int hig =screenRect.size.height*0.21;
        _view3scrollview.contentSize=CGSizeMake(screenRect.size.width,hig);

        UIButton *okbtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*.25,screenRect.size.height*.76,screenRect.size.width*.50,screenRect.size.height*.07)];
        [okbtn setTitle:@"Proceed" forState:UIControlStateNormal];
        okbtn.font=[UIFont systemFontOfSize:14];
        [okbtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        // [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
        okbtn.tag=4;
        [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#F8F8F8"]];
        [okbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [okbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        okbtn.layer.borderColor = [UIColor grayColor].CGColor;
        okbtn.layer.borderWidth = 0.5;
        [_view3 addSubview:okbtn];
    }
    _view4 = [[UIView alloc] initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.83)];
    [scrollView addSubview:_view4];
    _view4.backgroundColor=[UIColor clearColor];
    _view4.hidden=YES;
    {
       
        
        CGRect scrollViewFrame1 = CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.0,screenRect.size.width,screenRect.size.height*0.83);
        view4scrollview = [[UIScrollView alloc] initWithFrame:scrollViewFrame1];
        view4scrollview.backgroundColor=[UIColor clearColor];
        view4scrollview.delegate = self;
        view4scrollview.showsHorizontalScrollIndicator = NO;
        [_view4 addSubview:view4scrollview];
        
        UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.20,screenRect.size.height*.0,screenRect.size.width*.60,screenRect.size.height*.07)];
        titlelable.textAlignment = NSTextAlignmentCenter;
        titlelable.text=@"Customer Details";
        titlelable.textColor=[UIColor blackColor];
        [titlelable setBackgroundColor:[UIColor clearColor]];
        titlelable.font=[UIFont systemFontOfSize:18];
        [view4scrollview addSubview:titlelable];
        
        countrcodetxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.08,screenRect.size.width*0.15,screenRect.size.height*0.06)];
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
        [view4scrollview addSubview:countrcodetxt];
        CALayer *bottomBorders01 = [CALayer layer];
        bottomBorders01.frame = CGRectMake(0.0f, countrcodetxt.frame.size.height - 5, countrcodetxt.frame.size.width, 1.0f);
        bottomBorders01.backgroundColor = [UIColor whiteColor].CGColor;
        [countrcodetxt.layer addSublayer:bottomBorders01];
        
        custmobnotxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.08,screenRect.size.width*0.70,screenRect.size.height*0.07)];
        custmobnotxt.textAlignment=NSTextAlignmentLeft;
        custmobnotxt.delegate = self;
        custmobnotxt.textColor=[UIColor blackColor];
        [custmobnotxt setBackgroundColor:[UIColor clearColor]];
        custmobnotxt.leftViewMode = UITextFieldViewModeAlways;
        [custmobnotxt setKeyboardType:UIKeyboardTypeEmailAddress];
        custmobnotxt.returnKeyType=UIReturnKeyDone;
        custmobnotxt.floatingLabelActiveTextColor = [UIColor redColor];
        custmobnotxt.floatingLabelInactiveTextColor = [UIColor grayColor];
        CALayer *bottomBorders6 = [CALayer layer];
        bottomBorders6.frame = CGRectMake(0.0f, custmobnotxt.frame.size.height - 5, custmobnotxt.frame.size.width, 1.0f);
        bottomBorders6.backgroundColor = [UIColor lightGrayColor].CGColor;
        [custmobnotxt.layer addSublayer:bottomBorders6];
        numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbarzip.barStyle = UIBarStyleBlackOpaque;
        numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbarzip sizeToFit];
        numberToolbarzip.tintColor=[UIColor whiteColor];
        custmobnotxt.inputAccessoryView = numberToolbarzip;
        custmobnotxt.leftViewMode = UITextFieldViewModeAlways;
        custmobnotxt.keyboardType = UIKeyboardTypeNumberPad;
        custmobnotxt.placeholder = @"Mobile No*";
        [view4scrollview addSubview:custmobnotxt];
        
         custnametxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*.18,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        custnametxt.textAlignment=NSTextAlignmentLeft;
        custnametxt.delegate = self;
        custnametxt.textColor=[UIColor blackColor];
        [custnametxt setBackgroundColor:[UIColor clearColor]];
        custnametxt.leftViewMode = UITextFieldViewModeAlways;
        [custnametxt setKeyboardType:UIKeyboardTypeEmailAddress];
        custnametxt.returnKeyType=UIReturnKeyDone;
        custnametxt.floatingLabelActiveTextColor = [UIColor redColor];
        custnametxt.floatingLabelInactiveTextColor = [UIColor grayColor];
        CALayer *bottomBorders3 = [CALayer layer];
        bottomBorders3.frame = CGRectMake(0.0f, custnametxt.frame.size.height - 5, custnametxt.frame.size.width, 1.0f);
        bottomBorders3.backgroundColor = [UIColor lightGrayColor].CGColor;
        [custnametxt.layer addSublayer:bottomBorders3];
        custnametxt.placeholder=@"Name*";
        [view4scrollview addSubview:custnametxt];
        
        custemailtxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*.28,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        custemailtxt.textAlignment=NSTextAlignmentLeft;
        custemailtxt.delegate = self;
        custemailtxt.textColor=[UIColor blackColor];
        [custemailtxt setBackgroundColor:[UIColor clearColor]];
        custemailtxt.leftViewMode = UITextFieldViewModeAlways;
        [custemailtxt setKeyboardType:UIKeyboardTypeEmailAddress];
        custemailtxt.returnKeyType=UIReturnKeyDone;
        custemailtxt.floatingLabelActiveTextColor = [UIColor redColor];
        custemailtxt.floatingLabelInactiveTextColor = [UIColor grayColor];
        CALayer *bottomBorders4 = [CALayer layer];
        bottomBorders4.frame = CGRectMake(0.0f, custemailtxt.frame.size.height - 5, custemailtxt.frame.size.width, 1.0f);
        bottomBorders4.backgroundColor = [UIColor lightGrayColor].CGColor;
        [custemailtxt.layer addSublayer:bottomBorders4];
        custemailtxt.placeholder=@"Email*";
        [view4scrollview addSubview:custemailtxt];
        
        custaddrtxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*.38,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        custaddrtxt.textAlignment=NSTextAlignmentLeft;
        custaddrtxt.delegate = self;
        custaddrtxt.textColor=[UIColor blackColor];
        [custaddrtxt setBackgroundColor:[UIColor clearColor]];
        custaddrtxt.leftViewMode = UITextFieldViewModeAlways;
        [custaddrtxt setKeyboardType:UIKeyboardTypeEmailAddress];
        custaddrtxt.returnKeyType=UIReturnKeyDone;
        custaddrtxt.floatingLabelActiveTextColor = [UIColor redColor];
        custaddrtxt.floatingLabelInactiveTextColor = [UIColor grayColor];
        CALayer *bottomBorders5 = [CALayer layer];
        bottomBorders5.frame = CGRectMake(0.0f, custaddrtxt.frame.size.height - 5, custaddrtxt.frame.size.width, 1.0f);
        bottomBorders5.backgroundColor = [UIColor lightGrayColor].CGColor;
        [custaddrtxt.layer addSublayer:bottomBorders5];
        custaddrtxt.placeholder=@"Address";
        [view4scrollview addSubview:custaddrtxt];
        
        sourcetxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*.48,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        sourcetxt.textAlignment=NSTextAlignmentLeft;
        sourcetxt.delegate = self;
        sourcetxt.textColor=[UIColor blackColor];
        sourcetxt.delegate=self;
        [sourcetxt setBackgroundColor:[UIColor clearColor]];
        sourcetxt.leftViewMode = UITextFieldViewModeAlways;
        [sourcetxt setKeyboardType:UIKeyboardTypeEmailAddress];
        sourcetxt.returnKeyType=UIReturnKeyDone;
        sourcetxt.selectedLineColor = [UIColor redColor];
        sourcetxt.selectedPlaceHolderColor = [UIColor redColor];
        sourcetxt.placeHolderColor = [UIColor grayColor];
        sourcetxt.placeholder=@"Source*";
        sourcetxt.font = [UIFont systemFontOfSize:14];
        [_view4 addSubview:sourcetxt];
        
      revisedagrementvaluetxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*.58,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        revisedagrementvaluetxt.textAlignment=NSTextAlignmentLeft;
        revisedagrementvaluetxt.delegate = self;
        revisedagrementvaluetxt.textColor=[UIColor lightGrayColor];
        [revisedagrementvaluetxt setBackgroundColor:[UIColor clearColor]];
        revisedagrementvaluetxt.leftViewMode = UITextFieldViewModeAlways;
        [revisedagrementvaluetxt setKeyboardType:UIKeyboardTypeEmailAddress];
        revisedagrementvaluetxt.returnKeyType=UIReturnKeyDone;
        pamentschemetxt.floatingLabelActiveTextColor = [UIColor redColor];
        pamentschemetxt.floatingLabelInactiveTextColor = [UIColor grayColor];
        CALayer *bottomBorders8 = [CALayer layer];
        bottomBorders8.frame = CGRectMake(0.0f, revisedagrementvaluetxt.frame.size.height - 5, revisedagrementvaluetxt.frame.size.width, 1.0f);
        bottomBorders8.backgroundColor = [UIColor lightGrayColor].CGColor;
        [revisedagrementvaluetxt.layer addSublayer:bottomBorders8];
        revisedagrementvaluetxt.placeholder=@"Revised Agreement Value";
        revisedagrementvaluetxt.font = [UIFont systemFontOfSize:14];
        revisedagrementvaluetxt.enabled=NO;
        [view4scrollview addSubview:revisedagrementvaluetxt];
        
        UIButton *okbtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*.25,screenRect.size.height*.76,screenRect.size.width*.50,screenRect.size.height*.07)];
        [okbtn setTitle:@"Proceed" forState:UIControlStateNormal];
        okbtn.font=[UIFont systemFontOfSize:14];
        [okbtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        // [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
        okbtn.tag=5;
        [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#F8F8F8"]];
        [okbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [okbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        okbtn.layer.borderColor = [UIColor grayColor].CGColor;
        okbtn.layer.borderWidth = 0.5;
        [view4scrollview addSubview:okbtn];
        
    }
    _view5 = [[UIView alloc] initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.83)];
    [scrollView addSubview:_view5];
    _view5.backgroundColor=[UIColor clearColor];
    _view5.hidden=YES;
    {
        noofcheque=1;
        UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.20,screenRect.size.height*.0,screenRect.size.width*.60,screenRect.size.height*.07)];
        titlelable.textAlignment = NSTextAlignmentCenter;
        titlelable.text=@"Payment Details";
        titlelable.textColor=[UIColor blackColor];
        [titlelable setBackgroundColor:[UIColor clearColor]];
        titlelable.font=[UIFont systemFontOfSize:18];
        [_view5 addSubview:titlelable];
        
        CGRect scrollViewFrame1 = CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.07,screenRect.size.width,screenRect.size.height*0.68);
        view5scrollview = [[UIScrollView alloc] initWithFrame:scrollViewFrame1];
        view5scrollview.backgroundColor=[UIColor clearColor];
        view5scrollview.delegate = self;
        view5scrollview.showsHorizontalScrollIndicator = NO;
        [_view5 addSubview:view5scrollview];
        
        bankamountxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.02,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        bankamountxt.textAlignment=NSTextAlignmentLeft;
        bankamountxt.delegate = self;
        bankamountxt.textColor=[UIColor blackColor];
        [bankamountxt setBackgroundColor:[UIColor clearColor]];
        bankamountxt.leftViewMode = UITextFieldViewModeAlways;
        [bankamountxt setKeyboardType:UIKeyboardTypeEmailAddress];
        bankamountxt.returnKeyType=UIReturnKeyDone;
        bankamountxt.floatingLabelActiveTextColor = [UIColor redColor];
        bankamountxt.floatingLabelInactiveTextColor = [UIColor grayColor];
        CALayer *bottomBorders3 = [CALayer layer];
        bottomBorders3.frame = CGRectMake(0.0f, bankamountxt.frame.size.height - 5, bankamountxt.frame.size.width, 1.0f);
        bottomBorders3.backgroundColor = [UIColor lightGrayColor].CGColor;
        [bankamountxt.layer addSublayer:bottomBorders3];
        bankamountxt.placeholder=@"Booking amount";
        bankamountxt.font = [UIFont systemFontOfSize:14];
        [view5scrollview addSubview:bankamountxt];
        bankamountxt.enabled=NO;
        
        typeofpayment = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.12,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        typeofpayment.textAlignment=NSTextAlignmentLeft;
        typeofpayment.delegate = self;
        typeofpayment.textColor=[UIColor blackColor];
        [typeofpayment setBackgroundColor:[UIColor clearColor]];
        typeofpayment.leftViewMode = UITextFieldViewModeAlways;
        [typeofpayment setKeyboardType:UIKeyboardTypeEmailAddress];
        typeofpayment.returnKeyType=UIReturnKeyDone;
        typeofpayment.floatingLabelActiveTextColor = [UIColor redColor];
        typeofpayment.floatingLabelInactiveTextColor = [UIColor grayColor];
        CALayer *bottomBorders1 = [CALayer layer];
        bottomBorders1.frame = CGRectMake(0.0f, typeofpayment.frame.size.height - 5, typeofpayment.frame.size.width, 1.0f);
        bottomBorders1.backgroundColor = [UIColor lightGrayColor].CGColor;
        [typeofpayment.layer addSublayer:bottomBorders1];
        typeofpayment.placeholder=@"Select Type of Paymenet*";
        typeofpayment.font = [UIFont systemFontOfSize:14];
        [view5scrollview addSubview:typeofpayment];
        typeofpayment.text=@"Cheque";
        
    assignlbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,screenRect.size.height*.19,screenRect.size.width*.96,screenRect.size.height*.05)];
        assignlbl.textAlignment = NSTextAlignmentCenter;
        assignlbl.textColor=[UIColor blackColor];
        [assignlbl setBackgroundColor:[UIColor clearColor]];
        assignlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.03];
        assignlbl.lineBreakMode = NSLineBreakByWordWrapping;
        assignlbl.numberOfLines = 0;
        [view5scrollview addSubview:assignlbl];
        
       addbtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*.10,screenRect.size.height*.75,screenRect.size.width*.80,screenRect.size.height*.05)];
        [addbtn setTitle:@"Add another cheque details" forState:UIControlStateNormal];
        addbtn.font=[UIFont systemFontOfSize:16];
        [addbtn addTarget:self action:@selector(addcheque:) forControlEvents:UIControlEventTouchUpInside];
        // [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
        [addbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [view5scrollview addSubview:addbtn];
        
        captureimgbtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*.20,screenRect.size.height*.83,screenRect.size.width*.60,screenRect.size.height*.05)];
        [captureimgbtn setTitle:@"Capture cheque image" forState:UIControlStateNormal];
        captureimgbtn.font=[UIFont systemFontOfSize:14];
        captureimgbtn.tag=10;
        [captureimgbtn addTarget:self action:@selector(opencam:) forControlEvents:UIControlEventTouchUpInside];
         [captureimgbtn setBackgroundColor:[UIColor colorWithHexString:@"#F8F8F8"]];
        [captureimgbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [captureimgbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [view5scrollview addSubview:captureimgbtn];
        capturebookingbtn.layer.borderColor = [UIColor grayColor].CGColor;
        captureimgbtn.layer.borderWidth = 0.5;
        
        capturebookingbtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*.20,screenRect.size.height*.90,screenRect.size.width*.60,screenRect.size.height*.05)];
        [capturebookingbtn setTitle:@"Capture Booking form" forState:UIControlStateNormal];
        capturebookingbtn.font=[UIFont systemFontOfSize:14];
        capturebookingbtn.tag=11;
        [capturebookingbtn addTarget:self action:@selector(opencam:) forControlEvents:UIControlEventTouchUpInside];
         [capturebookingbtn setBackgroundColor:[UIColor colorWithHexString:@"#F8F8F8"]];
        [capturebookingbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [capturebookingbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        capturebookingbtn.layer.borderColor = [UIColor grayColor].CGColor;
        capturebookingbtn.layer.borderWidth = 0.5;
        [view5scrollview addSubview:capturebookingbtn];
        
        
//        chequeimage=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*.90, screenRect.size.width*0.30,screenRect.size.height*0.15)];
//        chequeimage.contentMode = UIViewContentModeScaleAspectFit;
//        [view5scrollview addSubview:chequeimage];
//        chequeimage.backgroundColor=[UIColor clearColor];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.headerReferenceSize = CGSizeZero;
        layout.footerReferenceSize = CGSizeZero;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        chequeimagecollectionview=[[UICollectionView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.20,screenRect.size.height*1.0, screenRect.size.width*0.60,screenRect.size.height*0.15)
                                           collectionViewLayout:layout];
        [chequeimagecollectionview setDataSource:self];
        [chequeimagecollectionview setDelegate:self];
        chequeimagecollectionview.scrollEnabled=YES;
        [chequeimagecollectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        //  collectioonview.backgroundColor=[UIColor blackColor];
        chequeimagecollectionview.backgroundColor=[UIColor clearColor]  ;
        [chequeimagecollectionview registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        [view5scrollview addSubview:chequeimagecollectionview];
        
        bookingimage=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.55,screenRect.size.height*.90, screenRect.size.width*0.40,screenRect.size.height*0.15)];
        bookingimage.contentMode = UIViewContentModeScaleAspectFit;
        [view5scrollview addSubview:bookingimage];
        bookingimage.backgroundColor=[UIColor clearColor];
        
        checktableview = [[UITableView alloc] init];
        [checktableview setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.24,screenRect.size.width*0.90,screenRect.size.height*0.50)];
        checktableview.scrollEnabled=NO;
        checktableview.backgroundColor=[UIColor clearColor];
        checktableview.delegate = self;
        checktableview.dataSource = self;
        checktableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        [view5scrollview addSubview:checktableview];
        
        rmarktxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.98,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        rmarktxt.textAlignment=NSTextAlignmentLeft;
        rmarktxt.delegate = self;
        rmarktxt.textColor=[UIColor blackColor];
        rmarktxt.delegate=self;
        [rmarktxt setBackgroundColor:[UIColor clearColor]];
        rmarktxt.leftViewMode = UITextFieldViewModeAlways;
        [rmarktxt setKeyboardType:UIKeyboardTypeEmailAddress];
        rmarktxt.returnKeyType=UIReturnKeyDone;
        rmarktxt.selectedLineColor = [UIColor redColor];
        rmarktxt.selectedPlaceHolderColor = [UIColor redColor];
        rmarktxt.placeHolderColor = [UIColor grayColor];
        rmarktxt.placeholder=@"Remark";
        rmarktxt.font = [UIFont systemFontOfSize:14];
        [view5scrollview addSubview:rmarktxt];
        
        remainingtxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*1.06,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        remainingtxt.textAlignment=NSTextAlignmentLeft;
        remainingtxt.delegate = self;
        remainingtxt.textColor=[UIColor blackColor];
        [remainingtxt setBackgroundColor:[UIColor clearColor]];
        remainingtxt.leftViewMode = UITextFieldViewModeAlways;
        [remainingtxt setKeyboardType:UIKeyboardTypeEmailAddress];
        remainingtxt.returnKeyType=UIReturnKeyDone;
        remainingtxt.selectedLineColor = [UIColor redColor];
        remainingtxt.selectedPlaceHolderColor = [UIColor redColor];
        remainingtxt.placeHolderColor = [UIColor grayColor];
        remainingtxt.placeholder=@"Remaining Amount";
        remainingtxt.font = [UIFont systemFontOfSize:14];
        [view5scrollview addSubview:remainingtxt];
        
        handedovertotext=[[ACFloatingTextField alloc]init];
        amounttxt=[[ACFloatingTextField alloc]init];
        _instrumentdatetxt=[[ACFloatingTextField alloc]init];
        _instrumentno=[[ACFloatingTextField alloc]init];
        _lastfourdigitsofcardtxt=[[ACFloatingTextField alloc]init];
        handedovertotext=[[ACFloatingTextField alloc]init];

        view5scrollview.contentSize=CGSizeMake(screenRect.size.width,screenRect.size.height*1.18);
        
finalbookbtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*.25,screenRect.size.height*.76,screenRect.size.width*.50,screenRect.size.height*.07)];
        [finalbookbtn setTitle:@"Book Now" forState:UIControlStateNormal];
        finalbookbtn.font=[UIFont systemFontOfSize:14];
        [finalbookbtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        // [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
        finalbookbtn.tag=6;
        [finalbookbtn setBackgroundColor:[UIColor colorWithHexString:@"#F8F8F8"]];
        [finalbookbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [finalbookbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        finalbookbtn.layer.borderColor = [UIColor grayColor].CGColor;
        finalbookbtn.layer.borderWidth = 0.5;
        [_view5 addSubview:finalbookbtn];
    }
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0, screenRect.size.height *0.10, screenRect.size.width,screenRect.size.height *0.90);
    indicator.color=[UIColor colorWithHexString:@"#004c00"];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
}
-(void)viewDidAppear:(BOOL)animated
{
    if ([comefromstr isEqualToString:@"Visit"]) {
        nametxt.enabled=NO;
        [self getbuilding];
    }
    else if([comefromstr isEqualToString:@"booking"])
    {
    [self getinventorydata];
        nametxt.enabled=YES;
    }
    [self getsource];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self isMovingFromParentViewController])
    {
        NSLog(@"View controller was popped");
        [timer invalidate];
    }
    else
    {
        NSLog(@"New view controller was pushed");
    }
}
-(void) getsource
{
    NSString*   urlString = @"http://13.126.129.245/xrbia/index.php?entryPoint=getLeadSource";
    //
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:@"" progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", userDict);
        sourcedict=[[userDict objectForKey:@"Android"] objectForKey:@"sources"];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
-(void)getbuilding
{
     {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"get_buildings"  forKey:@"requestType"];
        [params setObject:[_dict objectForKey:@"project_id"] forKey:@"projectId"];
        
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getinventorydata.php?",[prefs objectForKey:@"Link"]];
        [indicator startAnimating];
        
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            _floorarr=[[NSMutableArray alloc]init];
            _buildingarr=[[NSMutableArray alloc]init];
            buildingtxt.text=@"";
            [collectioonview reloadData];
            NSLog(@"JSON: %@", userDict);
            NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
            _buildingarr=[dic objectForKey:@"buildings"];
            [indicator stopAnimating];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
}
-(void)getinventorydata
{
    if (projectnamearr.count==0) {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"get_projects"  forKey:@"requestType"];
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"user_id"];
        
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getinventorydata.php?",[prefs objectForKey:@"Link"]];
        [indicator startAnimating];
        
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            NSLog(@"JSON: %@", userDict);
            projectarr=[[NSMutableArray alloc]init];
            NSDictionary* dic =[userDict objectForKey:@"Android"];
            projectarr=[dic objectForKey:@"projects"];
            [indicator stopAnimating];

        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
    
}
-(void)getflowerunit:(NSString*)str
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"get_floors_units"  forKey:@"requestType"];
    [params setObject:str  forKey:@"buildingId"];
    [params setObject:[_dict objectForKey:@"project_id"] forKey:@"projectId"];

    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getinventorydata.php?",[prefs objectForKey:@"Link"]];
    [indicator startAnimating];
    
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"JSON: %@", userDict);
        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
        _floorarr=[[NSMutableArray alloc]init];
       _floorarr=[dic objectForKey:@"inventory_data"];
        [indicator stopAnimating];
        [collectioonview reloadData];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
-(void)addcheque:(UIButton*)sender
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSMutableArray *checkquearr=[[NSMutableArray alloc]init];

    if ([sender.titleLabel.text isEqualToString:@"Add another cheque details"]) {
        noofcheque++;
         [checktableview insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:noofcheque-1 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        indexcount++;
    }
   else
   {
       noofcheque--;
    [checktableview deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
       [indexarray addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    
      bool flag=0;
       for (int i=0; i<indexcount; i++) {
           int   j=201;
           flag=0;
           j=j+4;
           for (int k=0; k<indexarray.count;k++) {
               if (i==[[indexarray objectAtIndex:k]intValue]) {
                   flag=1;
                   break;
               }
           }
           if (flag==1) {
               continue;
           }
           else
           {
               NSString *tex4 = ((RPFloatingPlaceholderTextField*)[self.view viewWithTag:i*100+j]).text;
               [checkquearr addObject:tex4];
           }
         
   }
       NSLog(@"%@",checkquearr);
       float remaingamt=0.00;
       for (int i=0; i<checkquearr.count; i++) {
           remaingamt=remaingamt+[[checkquearr objectAtIndex:i] floatValue];
       }
       NSLocale *locale = [NSLocale currentLocale];
       NSString *thousandSeparator = [locale objectForKey:NSLocaleGroupingSeparator];
       NSString *result = [bankamountxt.text stringByReplacingOccurrencesOfString:thousandSeparator withString:@""];
       float remainingamt=[result floatValue]-remaingamt;
       if (remainingamt<0) {
           remainingtxt.text=@"0.00";
       }
       else
           remainingtxt.text=[NSString stringWithFormat:@"%.02f",remainingamt];
    }
    checktableview.frame=CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.24,screenRect.size.width*0.90,noofcheque*screenRect.size.height*0.52);
    addbtn.frame=CGRectMake(screenRect.size.width*0.05,noofcheque*screenRect.size.height*0.52+screenRect.size.height*0.25,screenRect.size.width*0.90,screenRect.size.height*0.05);
    captureimgbtn.frame=CGRectMake(screenRect.size.width*0.20,noofcheque*screenRect.size.height*0.52+screenRect.size.height*0.30,screenRect.size.width*0.60,screenRect.size.height*0.05);
    
    int hig=noofcheque*screenRect.size.height*0.52+screenRect.size.height*0.38;
    if (imagerarr.count>0) {
  chequeimagecollectionview.frame=CGRectMake(screenRect.size.width*0.14,hig,screenRect.size.width*0.76,screenRect.size.height*0.15);
        
        hig=hig+screenRect.size.height*0.17; capturebookingbtn.frame=CGRectMake(screenRect.size.width*0.20,hig,screenRect.size.width*0.6,screenRect.size.height*0.05);
        hig=hig+screenRect.size.height*0.08;
        
        if (bookingimage.image!=nil) { bookingimage.frame=CGRectMake(screenRect.size.width*0.30,hig,screenRect.size.width*0.40,screenRect.size.height*0.15);
            hig=hig+screenRect.size.height*0.17;
        }
    }
    else if(imagerarr.count==0)
    {
capturebookingbtn.frame=CGRectMake(screenRect.size.width*0.20,hig,screenRect.size.width*0.60,screenRect.size.height*0.05);
        hig=hig+screenRect.size.height*0.08;

        if (bookingimage.image!=nil) { bookingimage.frame=CGRectMake(screenRect.size.width*0.30,hig,screenRect.size.width*0.40,screenRect.size.height*0.15);
            hig=hig+screenRect.size.height*0.17;
        }
    }

rmarktxt.frame=CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
    
    hig=hig+screenRect.size.height*0.08; remainingtxt.frame=CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
    
    hig=hig+screenRect.size.height*0.08;
    view5scrollview.contentSize=CGSizeMake(screenRect.size.width,hig);
    
}
-(void)opencam:(UIButton*)btn
{
    tag=btn.tag;
    if (imagerarr.count<3) {
        [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Maximum 3 cheque images can be uploaded"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
 //    [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
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
        if (tag==10) {
            [imagerarr addObject:chosenImage];
            [chequeimagecollectionview reloadData];
        }
        if (tag==11){
            bookingimage.image=chosenImage;
        }
//        checktableview.frame=CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.22,screenRect.size.width*0.90,count*screenRect.size.height*0.52);    addbtn.frame=CGRectMake(screenRect.size.width*0.05,count*screenRect.size.height*0.52+screenRect.size.height*0.24,screenRect.size.width*0.90,screenRect.size.height*0.07);
//        captureimgbtn.frame=CGRectMake(screenRect.size.width*0.05,count*screenRect.size.height*0.52+screenRect.size.height*0.32,screenRect.size.width*0.46,screenRect.size.height*0.07);
//        capturebookingbtn.frame=CGRectMake(screenRect.size.width*0.52,count*screenRect.size.height*0.52+screenRect.size.height*0.32,screenRect.size.width*0.46,screenRect.size.height*0.07);
        if (checktableview.hidden!=YES) {

            int hig=noofcheque*screenRect.size.height*0.52+screenRect.size.height*0.38;
            if (imagerarr.count>0) {
    chequeimagecollectionview.frame=CGRectMake(screenRect.size.width*0.14,hig,screenRect.size.width*0.76,screenRect.size.height*0.15);

                 hig=hig+screenRect.size.height*0.16;
                }
            capturebookingbtn.frame=CGRectMake(screenRect.size.width*0.20,hig,screenRect.size.width*0.60,screenRect.size.height*0.05);
            hig=hig+screenRect.size.height*0.10;
            
            if (bookingimage.image!=nil) {
                bookingimage.frame=CGRectMake(screenRect.size.width*0.30,hig,screenRect.size.width*0.40,screenRect.size.height*0.15);
                hig=hig+screenRect.size.height*0.16;
            }
rmarktxt.frame=CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
            
            hig=hig+screenRect.size.height*0.10;
            remainingtxt.frame=CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
            hig=hig+screenRect.size.height*0.10;
            
            view5scrollview.contentSize=CGSizeMake(screenRect.size.width,hig);
            }
else
{
   
    if ([typeofpaymentstr isEqualToString:@"Cash"]) {
        
        handedovertotext.frame = CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.25,screenRect.size.width*0.90,screenRect.size.height*0.07);
      
        
        amounttxt.frame = CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.35,screenRect.size.width*0.90,screenRect.size.height*0.07);
        captureimgbtn.frame=CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.45,screenRect.size.width*0.46,screenRect.size.height*0.07);
        captureimgbtn.hidden=YES;
        
        capturebookingbtn.frame=CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.45,screenRect.size.width*0.60,screenRect.size.height*0.05);
        
        int hig=screenRect.size.height*0.55;
        if (bookingimage.image!=nil)
        {
            bookingimage.frame=CGRectMake(screenRect.size.width*0.30,hig, screenRect.size.width*0.40,screenRect.size.height*0.15);
            
            hig=hig+screenRect.size.height*0.17;
        }
        rmarktxt.frame =  CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
        hig=hig+screenRect.size.height*0.08;
        
        remainingtxt.frame = CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
        
        hig=hig+screenRect.size.height*0.10;
        
        view5scrollview.contentSize=CGSizeMake(screenRect.size.width,hig);
    }
    
    if ([typeofpaymentstr isEqualToString:@"Card Swipe"]) {
       
        _instrumentdatetxt.frame = CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.20,screenRect.size.width*0.90,screenRect.size.height*0.07);
        
        _instrumentno.frame = CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.30,screenRect.size.width*0.90,screenRect.size.height*0.07);
        _instrumentno.textAlignment=NSTextAlignmentLeft;
        _instrumentno.delegate = self;
        _instrumentno.textColor=[UIColor blackColor];
        _instrumentno.delegate=self;
        [_instrumentno setBackgroundColor:[UIColor clearColor]];
        _instrumentno.leftViewMode = UITextFieldViewModeAlways;
        [_instrumentno setKeyboardType:UIKeyboardTypeEmailAddress];
        _instrumentno.returnKeyType=UIReturnKeyDone;
        _instrumentno.selectedPlaceHolderColor = [UIColor redColor];
        _instrumentno.placeHolderColor = [UIColor grayColor];
        _instrumentno.placeholder=@"Instrument No.";
        _instrumentno.font = [UIFont systemFontOfSize:14];
        [view5scrollview addSubview:_instrumentno];
        
        _lastfourdigitsofcardtxt.frame = CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.40,screenRect.size.width*0.90,screenRect.size.height*0.07);
      
        
        captureimgbtn.hidden=YES;
        capturebookingbtn.frame=CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.50,screenRect.size.width*0.6,screenRect.size.height*0.05);
        
        int hig=screenRect.size.height*0.58;
        if (bookingimage.image!=nil)
        {
            bookingimage.frame=CGRectMake(screenRect.size.width*0.30,hig, screenRect.size.width*0.40,screenRect.size.height*0.15);
            
            hig=hig+screenRect.size.height*0.17;
        }
        
        amounttxt.frame = CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
       
        hig=hig+screenRect.size.height*0.08;
        
        rmarktxt.frame = CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
        hig=hig+screenRect.size.height*0.08;
        
        remainingtxt.frame =CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
        hig=hig+screenRect.size.height*0.08;
        
        view5scrollview.contentSize=CGSizeMake(screenRect.size.width,screenRect.size.height*1.07);
    }
    if ([typeofpaymentstr isEqualToString:@"Online"]) {
       
        
        _instrumentdatetxt.frame =CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.20,screenRect.size.width*0.90,screenRect.size.height*0.07);
       
        
        _instrumentno.frame =CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.30,screenRect.size.width*0.90,screenRect.size.height*0.07);
        
        
        _lastfourdigitsofcardtxt.frame = CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.20,screenRect.size.width*0.90,screenRect.size.height*0.07);
        captureimgbtn.frame=CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.30,screenRect.size.width*0.46,screenRect.size.height*0.07);
        captureimgbtn.hidden=YES;
        capturebookingbtn.frame=CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.30,screenRect.size.width*0.6,screenRect.size.height*0.05);
        
        int hig=screenRect.size.height*0.38;
        if (bookingimage.image!=nil)
        {
            bookingimage.frame=CGRectMake(screenRect.size.width*0.30,hig, screenRect.size.width*0.40,screenRect.size.height*0.15);
            
            hig=hig+screenRect.size.height*0.17;
        }
        
        
        amounttxt.frame = CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
      
        hig=hig+screenRect.size.height*0.08;
        
        rmarktxt.frame = CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
        hig=hig+screenRect.size.height*0.08;
        
        remainingtxt.frame =CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
        hig=hig+screenRect.size.height*0.15;
        
paymentgateybtn.frame=CGRectMake(screenRect.size.width*0.10,hig,screenRect.size.width*0.80,screenRect.size.height*0.07);
        
        
        hig=hig+screenRect.size.height*0.10;
        view5scrollview.contentSize=CGSizeMake(screenRect.size.width,hig);
    }

}
//            capturebookingbtn.frame=CGRectMake(screenRect.size.width*0.52,count*screenRect.size.height*0.52+screenRect.size.height*0.32,screenRect.size.width*0.46,screenRect.size.height*0.07);
//            bookingimage.frame=CGRectMake(screenRect.size.width*0.55,noofcheque*screenRect.size.height*0.52+screenRect.size.height*0.42,screenRect.size.width*0.40,screenRect.size.height*0.15);
//            rmarktxt.frame=CGRectMake(screenRect.size.width*0.05,noofcheque*screenRect.size.height*0.52+screenRect.size.height*0.59,screenRect.size.width*0.90,screenRect.size.height*0.07);
//            remainingtxt.frame=CGRectMake(screenRect.size.width*0.05,noofcheque*screenRect.size.height*0.52+screenRect.size.height*0.69,screenRect.size.width*0.90,screenRect.size.height*0.07);
//            view5scrollview.contentSize=CGSizeMake(screenRect.size.width,screenRect.size.height*0.79+checktableview.frame.size.height);
     //   }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==tableViewHome) {
        return _tableheadrarr.count;
    }
      if (tableView==checktableview)
        {
            return noofcheque;
        }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];

    if (tableView==tableViewHome) {
        NSDictionary *dic=[_tableheadrarr objectAtIndex:indexPath.row];
        if (cell==nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width,screenRect.size.height*0.07)];
        headerView.backgroundColor=[UIColor clearColor];
        
        //    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 2.0f)];
        //    lineView2.backgroundColor = [UIColor grayColor];
        //    [headerView addSubview:lineView2];
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        Srnolbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.030];
        Srnolbl.textAlignment = NSTextAlignmentCenter;
        Srnolbl.text = [dic objectForKey:@"milestone"];
        Srnolbl.backgroundColor = [UIColor clearColor];
        Srnolbl.textColor=[UIColor blackColor];
        Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
        Srnolbl.numberOfLines = 0;
        [headerView addSubview:Srnolbl];
        
        UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.25,0,screenRect.size.width*0.13,screenRect.size.height*0.07)];
        namelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.030];
        namelbl.textAlignment = NSTextAlignmentCenter;
        namelbl.text = [dic objectForKey:@"due"];
        namelbl.backgroundColor = [UIColor clearColor];
        namelbl.textColor=[UIColor blackColor];
        namelbl.lineBreakMode = NSLineBreakByWordWrapping;
        namelbl.numberOfLines = 0;
        [headerView addSubview:namelbl];
        
        UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.38,0,screenRect.size.width*0.23,screenRect.size.height*0.07)];
        datelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.030];
        datelbl.textAlignment = NSTextAlignmentCenter;
        datelbl.text = [dic objectForKey:@"milestone_agreement_value"];
        datelbl.backgroundColor = [UIColor clearColor];
        datelbl.textColor=[UIColor blackColor];
        datelbl.lineBreakMode = NSLineBreakByWordWrapping;
        datelbl.numberOfLines = 0;
        [headerView addSubview:datelbl];
        
        UILabel*  cashlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.61,0,screenRect.size.width*0.22,screenRect.size.height*0.07)];
        cashlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.030];
        cashlbl.textAlignment = NSTextAlignmentCenter;
        cashlbl.text = [dic objectForKey:@"taxes"];
        cashlbl.backgroundColor = [UIColor clearColor];
        cashlbl.textColor=[UIColor blackColor];
        cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
        cashlbl.numberOfLines = 0;
        [headerView addSubview:cashlbl];
        
        UILabel*  expencelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.83,0,screenRect.size.width*0.17,screenRect.size.height*0.07)];
        expencelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.030];
        expencelbl.textAlignment = NSTextAlignmentCenter;
        expencelbl.text = [dic objectForKey:@"total_cost"];
        expencelbl.backgroundColor = [UIColor clearColor];
        expencelbl.textColor=[UIColor blackColor];
        expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
        expencelbl.numberOfLines = 0;
        [headerView addSubview:expencelbl];
        [cell.contentView addSubview:headerView];
        }
    }
    if (tableView==checktableview) {
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
            UIView * view=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.0,screenRect.size.width*0.90,screenRect.size.height*0.50)];
            [cell.contentView addSubview:view];
            
            view.layer.borderWidth = 1.0f;
            view.layer.borderColor = [UIColor lightGrayColor].CGColor;
            
            UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.15,screenRect.size.height*.0,screenRect.size.width*.60,screenRect.size.height*.07)];
            titlelable.textAlignment = NSTextAlignmentCenter;
            titlelable.text=@"Cheque Details";
            titlelable.textColor=[UIColor blackColor];
            [titlelable setBackgroundColor:[UIColor clearColor]];
            titlelable.font=[UIFont systemFontOfSize:18];
            [view addSubview:titlelable];
            
            int i=201;
            
        RPFloatingPlaceholderTextField*  chequeinstrumenttxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.08,screenRect.size.width*0.80,screenRect.size.height*0.06)];
            chequeinstrumenttxt.textAlignment=NSTextAlignmentLeft;
            chequeinstrumenttxt.delegate = self;
            chequeinstrumenttxt.textColor=[UIColor blackColor];
            [chequeinstrumenttxt setBackgroundColor:[UIColor clearColor]];
            chequeinstrumenttxt.leftViewMode = UITextFieldViewModeAlways;
            [chequeinstrumenttxt setKeyboardType:UIKeyboardTypeEmailAddress];
            chequeinstrumenttxt.returnKeyType=UIReturnKeyDone;
            chequeinstrumenttxt.floatingLabelActiveTextColor = [UIColor redColor];
            chequeinstrumenttxt.floatingLabelInactiveTextColor = [UIColor grayColor];
            CALayer *bottomBorders1 = [CALayer layer];
            bottomBorders1.frame = CGRectMake(0.0f, chequeinstrumenttxt.frame.size.height - 5, chequeinstrumenttxt.frame.size.width, 1.0f);
            bottomBorders1.backgroundColor = [UIColor lightGrayColor].CGColor;
            [chequeinstrumenttxt.layer addSublayer:bottomBorders1];
            chequeinstrumenttxt.placeholder=@"Instrument No*";
            chequeinstrumenttxt.font = [UIFont systemFontOfSize:14];
            [view addSubview:chequeinstrumenttxt];
            NSLog(@"Tag is 1=%ld",indexPath.row*100+i);
            chequeinstrumenttxt.tag=(indexPath.row*100)+i;
            chequeinstrumenttxt.text=@"";
            
            i++;
          chequeinstrumentdatetxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.16,screenRect.size.width*0.80,screenRect.size.height*0.06)];
            chequeinstrumentdatetxt.textAlignment=NSTextAlignmentLeft;
            chequeinstrumentdatetxt.delegate = self;
            chequeinstrumentdatetxt.textColor=[UIColor blackColor];
            [chequeinstrumentdatetxt setBackgroundColor:[UIColor clearColor]];
            chequeinstrumentdatetxt.leftViewMode = UITextFieldViewModeAlways;
            [chequeinstrumentdatetxt setKeyboardType:UIKeyboardTypeEmailAddress];
            chequeinstrumentdatetxt.returnKeyType=UIReturnKeyDone;
            chequeinstrumentdatetxt.floatingLabelActiveTextColor = [UIColor redColor];
            chequeinstrumentdatetxt.floatingLabelInactiveTextColor = [UIColor grayColor];
            CALayer *bottomBorders0 = [CALayer layer];
            bottomBorders0.frame = CGRectMake(0.0f, chequeinstrumentdatetxt.frame.size.height - 5, chequeinstrumentdatetxt.frame.size.width, 1.0f);
            chequeinstrumentdatetxt.tag=indexPath.row*100+i;
            bottomBorders0.backgroundColor = [UIColor lightGrayColor].CGColor;
            [chequeinstrumentdatetxt.layer addSublayer:bottomBorders0];
            chequeinstrumentdatetxt.placeholder=@"Instrument Date*";
            chequeinstrumentdatetxt.font = [UIFont systemFontOfSize:14];
            datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
            [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
            numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbarzip.barStyle = UIBarStyleBlackOpaque;
            numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)],
                                       [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                       [[UIBarButtonItem alloc]initWithTitle:@"Done"
                                                                       style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad11:)]];
            [numberToolbarzip sizeToFit];
            chequeinstrumentdatetxt.inputView =datePicker;
            chequeinstrumentdatetxt.inputAccessoryView = numberToolbarzip;
            numberToolbarzip.tintColor=[UIColor whiteColor];
            [view addSubview:chequeinstrumentdatetxt];
            NSLog(@"Tag is 2%ld",(long)chequeinstrumentdatetxt.tag);
            chequeinstrumentdatetxt.text=@"";

            i++;
            
        RPFloatingPlaceholderTextField*   chequebanknametxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.24,screenRect.size.width*0.80,screenRect.size.height*0.06)];
            chequebanknametxt.textAlignment=NSTextAlignmentLeft;
            chequebanknametxt.delegate = self;
            chequebanknametxt.textColor=[UIColor blackColor];
            [chequebanknametxt setBackgroundColor:[UIColor clearColor]];
            chequebanknametxt.leftViewMode = UITextFieldViewModeAlways;
            [chequebanknametxt setKeyboardType:UIKeyboardTypeEmailAddress];
            chequebanknametxt.returnKeyType=UIReturnKeyDone;
            chequebanknametxt.floatingLabelActiveTextColor = [UIColor redColor];
            chequebanknametxt.floatingLabelInactiveTextColor = [UIColor grayColor];
            CALayer *bottomBorders2 = [CALayer layer];
            bottomBorders2.frame = CGRectMake(0.0f, chequebanknametxt.frame.size.height - 5, chequebanknametxt.frame.size.width, 1.0f);
            bottomBorders2.backgroundColor = [UIColor lightGrayColor].CGColor;
            [chequebanknametxt.layer addSublayer:bottomBorders2];
            chequebanknametxt.placeholder=@"Bank Name*";
            chequebanknametxt.font = [UIFont systemFontOfSize:14];
            [view addSubview:chequebanknametxt];
            chequebanknametxt.tag=indexPath.row*100+i;
            NSLog(@"Tag is 3%ld",(long)chequebanknametxt.tag);
            chequebanknametxt.text=@"";

            i++;
            
         RPFloatingPlaceholderTextField*  chequebranchnametxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.32,screenRect.size.width*0.80,screenRect.size.height*0.06)];
            chequebranchnametxt.textAlignment=NSTextAlignmentLeft;
            chequebranchnametxt.delegate = self;
            chequebranchnametxt.textColor=[UIColor blackColor];
            [chequebranchnametxt setBackgroundColor:[UIColor clearColor]];
            chequebranchnametxt.leftViewMode = UITextFieldViewModeAlways;
            [chequebranchnametxt setKeyboardType:UIKeyboardTypeEmailAddress];
            chequebranchnametxt.returnKeyType=UIReturnKeyDone;
            chequebranchnametxt.floatingLabelActiveTextColor = [UIColor redColor];
            chequebranchnametxt.floatingLabelInactiveTextColor = [UIColor grayColor];
            CALayer *bottomBorders3 = [CALayer layer];
            bottomBorders3.frame = CGRectMake(0.0f, chequebranchnametxt.frame.size.height - 5, chequebranchnametxt.frame.size.width, 1.0f);
            bottomBorders3.backgroundColor = [UIColor lightGrayColor].CGColor;
            [chequebranchnametxt.layer addSublayer:bottomBorders3];
            chequebranchnametxt.placeholder=@"Branch Name*";
            chequebranchnametxt.font = [UIFont systemFontOfSize:14];
            [view addSubview:chequebranchnametxt];
            chequebranchnametxt.tag=indexPath.row*100+i;
            NSLog(@"Tag is 4%ld",(long)chequebranchnametxt.tag);
            chequebranchnametxt.text=@"";

            i++;
            
        chequeAmountxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.40,screenRect.size.width*0.80,screenRect.size.height*0.06)];
            chequeAmountxt.textAlignment=NSTextAlignmentLeft;
            chequeAmountxt.delegate = self;
            chequeAmountxt.textColor=[UIColor blackColor];
            [chequeAmountxt setBackgroundColor:[UIColor clearColor]];
            chequeAmountxt.leftViewMode = UITextFieldViewModeAlways;
            [chequeAmountxt setKeyboardType:UIKeyboardTypeEmailAddress];
            chequeAmountxt.returnKeyType=UIReturnKeyDone;
            chequeAmountxt.floatingLabelActiveTextColor = [UIColor redColor];
            chequeAmountxt.floatingLabelInactiveTextColor = [UIColor grayColor];
            CALayer *bottomBorders4 = [CALayer layer];
            bottomBorders4.frame = CGRectMake(0.0f, chequeAmountxt.frame.size.height - 5, chequeAmountxt.frame.size.width, 1.0f);
            bottomBorders4.backgroundColor = [UIColor lightGrayColor].CGColor;
            [chequeAmountxt.layer addSublayer:bottomBorders4];
            numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbarzip.barStyle = UIBarStyleBlackOpaque;
            numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                                       [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                       [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbarzip sizeToFit];
            numberToolbarzip.tintColor=[UIColor blackColor];
            chequeAmountxt.inputAccessoryView = numberToolbarzip;
            chequeAmountxt.leftViewMode = UITextFieldViewModeAlways;
            chequeAmountxt.keyboardType = UIKeyboardTypeDecimalPad;
            chequeAmountxt.placeholder=@"Amount*";
            chequeAmountxt.font = [UIFont systemFontOfSize:14];
            [view addSubview:chequeAmountxt];
            chequeAmountxt.fieldIdentifier=@"chequeamount";
            chequeAmountxt.tag=indexPath.row*100+i;
            NSLog(@"Tag is 5%ld",(long)chequeAmountxt.tag);
            chequeAmountxt.text=@"";
            i++;
            
            if (indexPath.row>0) {
                UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];
                UIButton* rmvbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.80,screenRect.size.height*0.0,screenRect.size.width*.10,screenRect.size.height*.07)];
                [rmvbtn addTarget:self action:@selector(addcheque:) forControlEvents:UIControlEventTouchUpInside];
                [rmvbtn setTitle:@"\uE5C9" forState:UIControlStateNormal];
                [rmvbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [rmvbtn.titleLabel setFont:customFontdregs];
                rmvbtn.tag=indexPath.row;
                [rmvbtn setBackgroundColor:[UIColor clearColor]];
                [view addSubview:rmvbtn];
                
            }
    }
    }
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.contentMode= UIViewContentModeLeft;
    
    cell.backgroundColor = [UIColor clearColor];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (tableView==tableViewHome)
    return screenRect.size.height*0.07;
    else
        return screenRect.size.height*0.52;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (tableView==tableViewHome) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width,screenRect.size.height*0.07)];
        headerView.backgroundColor=[UIColor colorWithHexString:@"#E8E8E8"];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height, headerView.frame.size.width, 2.0f)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [headerView addSubview:lineView];
        
        //    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 2.0f)];
        //    lineView2.backgroundColor = [UIColor grayColor];
        //    [headerView addSubview:lineView2];
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        Srnolbl.textAlignment = NSTextAlignmentCenter;
        Srnolbl.text = @"Milestone";
        Srnolbl.backgroundColor = [UIColor clearColor];
        Srnolbl.textColor=[UIColor blackColor];
        Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
        Srnolbl.numberOfLines = 0;
        [[Srnolbl layer] setBorderWidth:1.0f];
        [[Srnolbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:Srnolbl];
        
        UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.25,0,screenRect.size.width*0.13,screenRect.size.height*0.07)];
        namelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        namelbl.textAlignment = NSTextAlignmentCenter;
        namelbl.text = @"% Due";
        namelbl.backgroundColor = [UIColor clearColor];
        namelbl.textColor=[UIColor blackColor];
        namelbl.lineBreakMode = NSLineBreakByWordWrapping;
        namelbl.numberOfLines = 0;
        [[namelbl layer] setBorderWidth:1.0f];
        [[namelbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:namelbl];
        
        UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.38,0,screenRect.size.width*0.23,screenRect.size.height*0.07)];
        datelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        datelbl.textAlignment = NSTextAlignmentCenter;
        datelbl.text = @"Agreeement\nValue";
        datelbl.backgroundColor = [UIColor clearColor];
        datelbl.textColor=[UIColor blackColor];
        datelbl.lineBreakMode = NSLineBreakByWordWrapping;
        [[datelbl layer] setBorderWidth:1.0f];
        datelbl.lineBreakMode = NSLineBreakByWordWrapping;
        datelbl.numberOfLines = 0;
        [headerView addSubview:datelbl];
        
        UILabel*  cashlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.61,0,screenRect.size.width*0.22,screenRect.size.height*0.07)];
        cashlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        cashlbl.textAlignment = NSTextAlignmentCenter;
        cashlbl.text = @"Tax & other\nCharges";
        cashlbl.backgroundColor = [UIColor clearColor];
        cashlbl.textColor=[UIColor blackColor];
        cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
        [[cashlbl layer] setBorderWidth:1.0f];
        cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
        cashlbl.numberOfLines = 0;
        [headerView addSubview:cashlbl];
        
        UILabel*  expencelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.83,0,screenRect.size.width*0.17,screenRect.size.height*0.07)];
        expencelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        expencelbl.textAlignment = NSTextAlignmentCenter;
        expencelbl.text = @"Total\nCost";
        expencelbl.backgroundColor = [UIColor clearColor];
        expencelbl.textColor=[UIColor blackColor];
        expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
        [[expencelbl layer] setBorderWidth:1.0f];
        expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
        expencelbl.numberOfLines = 0;
        [headerView addSubview:expencelbl];
        return headerView;
    }
   else
       return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (tableView==tableViewHome) {
        return  screenRect.size.height*0.07;
    }
    else
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectioonview==collectionView) {
        return _floorarr.count;
    }
    else if(collectionView==chequeimagecollectionview)
        return imagerarr.count;
    return 0;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    if (collectioonview==collectionView) {
//    return CGSizeMake(screenRect.size.width*0.20,screenRect.size.height*0.13);
//    }
//    if (collectioonview==chequeimagecollectionview) {
//        return CGSizeMake(screenRect.size.width*0.20,screenRect.size.height*0.15);
//    }
//    return CGSizeMake(0, 0);
//
//}
- (UICollectionViewCell *)collectionView:(UICollectionView* )collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
   
  if (collectionView==collectioonview) {
           CGRect screenRect = [[UIScreen mainScreen] bounds];
        for (UIView *view in cell.contentView.subviews) {
            if ([view isKindOfClass:[UILabel class]]) {
                [view removeFromSuperview];
            }
        }
        NSMutableDictionary * dict=[_floorarr objectAtIndex:indexPath.row];
        UILabel *linelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.0,screenRect.size.width*0.20,screenRect.size.height*0.07)];
        linelbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        linelbl2.text=[NSString stringWithFormat:@"Floor %@",[dict objectForKey:@"floor"]];
        [linelbl2 setTextColor:[UIColor blackColor]];
        linelbl2.backgroundColor=[UIColor clearColor];
        linelbl2.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:linelbl2];
        linelbl2.layer.borderColor = [UIColor blackColor].CGColor;
        linelbl2.layer.borderWidth = 1.0;
      
        UILabel *linelbl1 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.07,screenRect.size.width*0.20,screenRect.size.height*0.05)];
        linelbl1.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        linelbl1.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"units"]];
        [linelbl1 setTextColor:[UIColor whiteColor]];
        linelbl1.backgroundColor=[UIColor blackColor];
        linelbl1.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:linelbl1];
      return cell;
    }
    else if(collectionView==chequeimagecollectionview)
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];

        UIImageView*  imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,screenRect.size.width*0.19,screenRect.size.height*0.15)];
        imageview.image=[imagerarr objectAtIndex:indexPath.row];
        imageview.contentMode = UIViewContentModeScaleToFill;
        imageview.clipsToBounds = YES;

        [cell.contentView addSubview:imageview];
        
        UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];

        UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.15,screenRect.size.height*0.0,screenRect.size.width*.07,screenRect.size.height*.04)];
        [navigationbtn addTarget:self action:@selector(removeimage:) forControlEvents:UIControlEventTouchUpInside];
        navigationbtn.tag=indexPath.row;
        [navigationbtn setTitle:@"\uE5C9" forState:UIControlStateNormal];
        [navigationbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [navigationbtn.titleLabel setFont:customFontdregs];
        [navigationbtn setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:navigationbtn];;
        return cell;
    }
    return cell;

}
- (CGSize)collectionView:(UICollectionView* )collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath* )indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (collectionView==collectioonview) {
    return CGSizeMake(screenRect.size.width*.20, screenRect.size.height*0.13);
    }
     if(collectionView==chequeimagecollectionview)
    {
        return CGSizeMake(screenRect.size.width*0.24,screenRect.size.height*0.15);
    }
    return CGSizeMake(0, 0);
}
-(void)doneWithNumberPad{
    [custmobnotxt resignFirstResponder];
    [descontvaluetxt resignFirstResponder];
    [chequeAmountxt resignFirstResponder];
    [amounttxt resignFirstResponder];
    [_lastfourdigitsofcardtxt resignFirstResponder];
    [ (RPFloatingPlaceholderTextField *)[self.view viewWithTag:chequetag] resignFirstResponder];
}
-(void)collectionView:(UICollectionView* )collectionView didSelectItemAtIndexPath:(NSIndexPath* )indexPath
{
    if (collectionView==collectioonview) {
        
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"get_flats"  forKey:@"requestType"];
    [params setObject:siteidstr  forKey:@"buildingId"];
    [params setObject:[_dict objectForKey:@"project_id"] forKey:@"projectId"];
    [params setObject:[[_floorarr objectAtIndex:indexPath.row] objectForKey:@"id"] forKey:@"unitNumber"];
    flooridstr=[[_floorarr objectAtIndex:indexPath.row] objectForKey:@"id"];
    floorno=[[_floorarr objectAtIndex:indexPath.row] objectForKey:@"floor"];
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getinventorydata.php?",[prefs objectForKey:@"Link"]];
    [indicator startAnimating];
        
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", userDict);
        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
        unitsarr=[[NSMutableArray alloc]init];
        unitsarr=[dic objectForKey:@"units"];
        [indicator stopAnimating];
        [TakePhotoView removeFromSuperview];
        TakePhotoView = [[CustomIOS7AlertView alloc] init];
        [TakePhotoView setContainerView:[self signImageSetAlert]];
        [TakePhotoView setDelegate:self];
        [TakePhotoView setUseMotionEffects:true];
        [TakePhotoView show];
    }
        failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
    }
}
-(void)removeimage:(UIButton*)btn
{
    [imagerarr removeObjectAtIndex:btn.tag];
    [chequeimagecollectionview reloadData];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    int hig=noofcheque*screenRect.size.height*0.52+screenRect.size.height*0.38;
    if (imagerarr.count==0) {
        capturebookingbtn.frame=CGRectMake(screenRect.size.width*0.20,hig,screenRect.size.width*0.60,screenRect.size.height*0.07);
        hig=hig+screenRect.size.height*0.10;
        
        if (bookingimage.image!=nil) {
            bookingimage.frame=CGRectMake(screenRect.size.width*0.30,hig,screenRect.size.width*0.40,screenRect.size.height*0.15);
            hig=hig+screenRect.size.height*0.16;
        }
        rmarktxt.frame=CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
        
        hig=hig+screenRect.size.height*0.10;
        remainingtxt.frame=CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
        hig=hig+screenRect.size.height*0.10;
        
        view5scrollview.contentSize=CGSizeMake(screenRect.size.width,hig);
    }
}
-(void)doneWithNumberPad11:(UITextField*)toolbar{
    NSDateFormatter*  dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"MMM d,yyyy h:mm a"];
    
    UIDatePicker *  picker = (UIDatePicker*)((UITextField*)[self.view viewWithTag:chequetag]).inputView;
    NSString *dateString = [dateFormatter stringFromDate:[picker date]];
    self.chequeinstrumentdatetxt.text=dateString;
    [numberToolbarzip resignFirstResponder];
 //   [self.chequeinstrumentdatetxt resignFirstResponder];
    
   [ (ACFloatingTextField *)[self.view viewWithTag:chequetag] resignFirstResponder];

 ((UITextField*)[self.view viewWithTag:chequetag]).text=dateString ;
    NSLog(@"%ld",(long)toolbar.tag);
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    _formatdatestr =[dateFormatter stringFromDate:[picker date]];
}
-(void)doneWithNumberPad12:(UITextField*)toolbar{
    NSDateFormatter*  dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"MMM d,yyyy h:mm a"];
    
    UIDatePicker *  picker = (UIDatePicker*)self.instrumentdatetxt.inputView;
    NSString *dateString = [dateFormatter stringFromDate:[picker date]];
    _instrumentdatetxt.text=dateString;
    [numberToolbarzip resignFirstResponder];

    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    _formatdatestr =[dateFormatter stringFromDate:[picker date]];
    [_instrumentdatetxt resignFirstResponder];
}
-(UIView *)signImageSetAlert{
    int heig=0;
  //  [_demoView removeFromSuperview];
    heig=150;
    _radiobtntxt=@"";
    _demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,210)];
    [_demoView setBackgroundColor:[UIColor whiteColor]];
    _demoView.layer.cornerRadius=5;
    [_demoView.layer setMasksToBounds:YES];
    [_demoView.layer setBorderWidth:1.0];
    _demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    //remove comment
   // NSMutableArray *colorNames=[[NSMutableArray alloc]init];
    colorNames = [[NSMutableArray alloc]init];
    NSMutableArray *colors =[[NSMutableArray alloc]init];
    
    for (int i=0;i<unitsarr.count; i++) {
        [colorNames addObject:[[unitsarr objectAtIndex:i]objectForKey:@"name"]];
        if ([[[unitsarr objectAtIndex:i]objectForKey:@"unit_status"] isEqualToString:@"Blocked"]) {
        
           // [colors addObject:[UIColor blackColor]];
            [colors addObject:[UIColor colorWithHexString:@"#cc0404"]];

        }
     else if ([[[unitsarr objectAtIndex:i]objectForKey:@"premium"] isEqualToString:@"0"] || [[[unitsarr objectAtIndex:i]objectForKey:@"premium"] isEqualToString:@"1"]) {
            //[colors addObject:[UIColor redColor]];
         [colors addObject:[UIColor colorWithHexString:@"#cc0404"]];
        }
     else if ([[[unitsarr objectAtIndex:i]objectForKey:@"premium"] isEqualToString:@"2"] ||[[[unitsarr objectAtIndex:i]objectForKey:@"premium"] isEqualToString:@"3"]) {
        // [colors addObject:[UIColor blueColor]];
         [colors addObject:[UIColor colorWithHexString:@"#0000FF"]];
     }
     else if ([[[unitsarr objectAtIndex:i]objectForKey:@"premium"] isEqualToString:@"4"] ||[[[unitsarr objectAtIndex:i]objectForKey:@"premium"] isEqualToString:@"5"]) {
         //[colors addObject:[UIColor greenColor]];
         [colors addObject:[UIColor colorWithHexString:@"#008000"]];
     }
        else
        {
           [colors addObject:[UIColor blackColor]];
            
        }
    }
    
    int width=05;
    int high=40;
  if(unitsarr.count<80)
  {
      _demoView.frame =CGRectMake(0, 0, 300,700);

    CGRect frame = CGRectMake(10, 10, 262, 25);
    DLRadioButton *firstRadioButton = [self createRadioButtonWithFrame:frame
                                                                 Title:nil
                                                                 Color:nil
                                                                  ];
    firstRadioButton.tag=1;
    UILabel*  tittlelbl = [[UILabel alloc] initWithFrame:CGRectMake(0,0 , 300, 30)];
    tittlelbl.font=[UIFont systemFontOfSize:16];
    tittlelbl.textAlignment = NSTextAlignmentCenter;
    tittlelbl.text =@"Select unit";
    tittlelbl.userInteractionEnabled=NO;
    tittlelbl.backgroundColor = [UIColor clearColor];
    tittlelbl.textColor=[UIColor blackColor];
    [_demoView addSubview:tittlelbl];
    
    // other buttons
    NSInteger i = 0;
  
    NSMutableArray *otherButtons = [NSMutableArray new];
    for (UIColor *color in colors) {
        CGRect frame = CGRectMake(width,high, 262, 17);
        DLRadioButton *radioButton;
        //for attributed text
        if ([[[unitsarr objectAtIndex:i]objectForKey:@"unit_status"] isEqualToString:@"Blocked"]){
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:colorNames[i]];
            [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                    value:@2
                                    range:NSMakeRange(0, [attributeString length])];
            
           [attributeString addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorWithHexString:@"#cc0404"] range:NSMakeRange(0, [attributeString length])];
            
            [attributeString addAttribute:NSForegroundColorAttributeName
                                     value:[UIColor colorWithHexString:@"#cc0404"]
                                     range:NSMakeRange(0, [attributeString length])];

            radioButton = [self createRadioButtonWithFrameAttributedTitile:frame
                                                     Title:attributeString
                                                          Color:color];
        }else{
            NSString * title = colorNames[i];
            if ([[[unitsarr objectAtIndex:i]objectForKey:@"premium"] isEqualToString:@"3"] || [[[unitsarr objectAtIndex:i]objectForKey:@"premium"] isEqualToString:@"1"] || [[[unitsarr objectAtIndex:i]objectForKey:@"premium"] isEqualToString:@"5"]){
                title = [NSString stringWithFormat:@"%@p",colorNames[i]];
            }
            radioButton = [self createRadioButtonWithFrame:frame
                                                     Title:title
                                                     Color:color];
        }
        
        radioButton.tag=1;
      if (i%3==2) {
            width=100;
        }
       else if (i%3==0) {
            width=200;
        }
        else if(i%3==1)
        {
            high=high+20;
            width=05;
        }
//        if (i % 2 == 0) {
//            radioButton.iconSquare = YES;
//        }
//        if (i > 1) {
//            // put icon on the right side
//            radioButton.iconOnRight = YES;
//            radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        }
        [otherButtons addObject:radioButton];
        i++;
    }
      firstRadioButton.otherButtons = otherButtons;
      
      high=high+20;
      UIButton *blockbtn=[[UIButton alloc] initWithFrame:CGRectMake(05,high,90,40)];
      [blockbtn setTitle:@"Block" forState:UIControlStateNormal];
      [blockbtn addTarget:self
                   action:@selector(block)
         forControlEvents:UIControlEventTouchUpInside];
      [blockbtn setBackgroundColor:[UIColor clearColor]];
      blockbtn.font=[UIFont systemFontOfSize:14];
      [blockbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [blockbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
      blockbtn.layer.borderColor = [UIColor grayColor].CGColor;
      blockbtn.layer.borderWidth = 1.0;
      [_demoView addSubview:blockbtn];
      
      UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(100,high,90,40)];
      [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
      [cancelBtn addTarget:self
                    action:@selector(closeAlert:)
          forControlEvents:UIControlEventTouchUpInside];
      cancelBtn.font=[UIFont systemFontOfSize:14];
      [cancelBtn setBackgroundColor:[UIColor clearColor]];
      [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
      cancelBtn.layer.borderColor = [UIColor grayColor].CGColor;
      cancelBtn.layer.borderWidth = 1.0;
      [_demoView addSubview:cancelBtn];
      
      UIButton *okbtn=[[UIButton alloc] initWithFrame:CGRectMake(195,high,100,40)];
      [okbtn setTitle:@"View details" forState:UIControlStateNormal];
      okbtn.font=[UIFont systemFontOfSize:14];
      [okbtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
      // [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
      okbtn.tag=2;
      [okbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [okbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
      okbtn.layer.borderColor = [UIColor grayColor].CGColor;
      okbtn.layer.borderWidth = 1.0;
      
      //***
       high=high+70;
      UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(05, high, 50, 20)];
      myLabel.text = @"Red -";
      //myLabel.backgroundColor = [UIColor yellowColor];
      myLabel.textColor = [UIColor colorWithHexString:@"#cc0404"];
      myLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
            [_demoView addSubview:myLabel];
      
      UILabel *myLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(45, high, 200, 20)];
      myLabel1.text = @"Xrbia Inventory";
     // myLabel1.backgroundColor = [UIColor yellowColor];
      myLabel1.textColor = [UIColor blackColor];
      myLabel1.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
      [_demoView addSubview:myLabel1];
      
     high=high+20;
      UILabel *myLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(05, high, 50, 20)];
      myLabel2.text = @"Blue -";
     // myLabel2.backgroundColor = [UIColor yellowColor];
      myLabel2.textColor = [UIColor colorWithHexString:@"#0000FF"];
      myLabel2.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
      [_demoView addSubview:myLabel2];
      
      UILabel *myLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(45, high, 200, 20)];
      myLabel3.text = @"Casalia Inventory";
      //myLabel3.backgroundColor = [UIColor yellowColor];
      myLabel3.textColor = [UIColor blackColor];
      myLabel3.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
      [_demoView addSubview:myLabel3];
      
      high=high+20;
      UILabel *myLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(05, high, 60, 20)];
      myLabel4.text = @"Green -";
      //myLabel4.backgroundColor = [UIColor yellowColor];
      myLabel4.textColor = [UIColor colorWithHexString:@"#008000"];
      myLabel4.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
      [_demoView addSubview:myLabel4];
      
      UILabel *myLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(55, high, 200, 20)];
      myLabel5.text = @"Issue Customer";
     // myLabel5.backgroundColor = [UIColor redColor];
      myLabel5.textColor = [UIColor blackColor];
      myLabel5.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
      [_demoView addSubview:myLabel5];

      
      //***
      
      _demoView.frame=CGRectMake(0, 0, 300,high+50);
      [_demoView addSubview:okbtn];
  }
    else
    {
        _demoView.frame=CGRectMake(0, 0, 300,520);
      _radioscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0,30,300,420)];
        _radioscrollview.scrollEnabled = YES;
        _radioscrollview.showsVerticalScrollIndicator = YES;
        [_demoView addSubview:_radioscrollview];
        
        CGRect frame = CGRectMake(10, 0, 262, 25);
        DLRadioButton *firstRadioButton = [self createRadioButtonWithFrame:frame
                                                                     Title:nil
                                                                     Color:nil];
        int high=10;
        firstRadioButton.tag=1;
        UILabel*  tittlelbl = [[UILabel alloc] initWithFrame:CGRectMake(0,0 , 300, 30)];
        tittlelbl.font=[UIFont systemFontOfSize:16];
        tittlelbl.textAlignment = NSTextAlignmentCenter;
        tittlelbl.text =@"Select unit";
        tittlelbl.userInteractionEnabled=NO;
        tittlelbl.backgroundColor = [UIColor clearColor];
        tittlelbl.textColor=[UIColor blackColor];
        [_demoView addSubview:tittlelbl];
                // other buttons
        NSInteger i = 0;
        
        NSMutableArray *otherButtons = [NSMutableArray new];
        for (UIColor *color in colors) {
            CGRect frame = CGRectMake(width,high, 262, 17);
            DLRadioButton *radioButton = [self createRadioButtonWithFrame:frame
                                                                    Title:[colorNames[i] stringByAppendingString:@""]
                                                                    Color:color];
            radioButton.tag=1;
            if (i%3==2) {
                width=100;
            }
            else if (i%3==0) {
                width=200;
            }
            else if(i%3==1)
            {
                high=high+20;
                width=05;
            }
            //        if (i % 2 == 0) {
            //            radioButton.iconSquare = YES;
            //        }
            //        if (i > 1) {
            //            // put icon on the right side
            //            radioButton.iconOnRight = YES;
            //            radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            //        }
            [otherButtons addObject:radioButton];
            i++;
        }
        _radioscrollview.contentSize = CGSizeMake(300 ,high);
        firstRadioButton.otherButtons = otherButtons;
        
        UIButton *blockbtn=[[UIButton alloc] initWithFrame:CGRectMake(05,470,90,40)];
        [blockbtn setTitle:@"Block" forState:UIControlStateNormal];
        [blockbtn addTarget:self
                     action:@selector(block)
           forControlEvents:UIControlEventTouchUpInside];
        [blockbtn setBackgroundColor:[UIColor clearColor]];
        blockbtn.font=[UIFont systemFontOfSize:14];
        [blockbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [blockbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        blockbtn.layer.borderColor = [UIColor grayColor].CGColor;
        blockbtn.layer.borderWidth = 1.0;
        [_demoView addSubview:blockbtn];
        
        UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(100,470,90,40)];
        [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
        [cancelBtn addTarget:self
                      action:@selector(closeAlert:)
            forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.font=[UIFont systemFontOfSize:14];
        [cancelBtn setBackgroundColor:[UIColor clearColor]];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        cancelBtn.layer.borderColor = [UIColor grayColor].CGColor;
        cancelBtn.layer.borderWidth = 1.0;
        [_demoView addSubview:cancelBtn];
        
        UIButton *okbtn=[[UIButton alloc] initWithFrame:CGRectMake(195,470,100,40)];
        [okbtn setTitle:@"View details" forState:UIControlStateNormal];
        okbtn.font=[UIFont systemFontOfSize:14];
        [okbtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        // [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
        okbtn.tag=2;
        [okbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [okbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        okbtn.layer.borderColor = [UIColor grayColor].CGColor;
        okbtn.layer.borderWidth = 1.0;
        [_demoView addSubview:okbtn];
    }
   
    
    _indicator2 = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indicator2.frame = _demoView.frame;
    _indicator2.color=[UIColor grayColor];
    [_demoView addSubview:_indicator2];
    [_indicator2 bringSubviewToFront:_demoView];
    _indicator2.layer.cornerRadius=15.0f;
    
    return _demoView;
}

- (DLRadioButton *)createRadioButtonWithFrameAttributedTitile:(CGRect) frame Title:(NSAttributedString *)title Color:(UIColor *)color
{
    if (unitsarr.count<80) {
        DLRadioButton *radioButton = [[DLRadioButton alloc] initWithFrame:frame];
        //radioButton.titleLabel.font = [UIFont systemFontOfSize:18];//14
        radioButton.titleLabel.font =   [UIFont fontWithName:@"Helvetica-Bold" size:14];
        [radioButton setAttributedTitle:title forState:UIControlStateNormal];
        [radioButton setTitleColor:color forState:UIControlStateNormal];
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.iconSize=14;
        radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [radioButton addTarget:self action:@selector(logSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
        [_demoView addSubview:radioButton];
        return radioButton;
    }
    else
    {
        DLRadioButton *radioButton = [[DLRadioButton alloc] initWithFrame:frame];
      //  radioButton.titleLabel.font = [UIFont systemFontOfSize:18];//14
        radioButton.titleLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:14];
        [radioButton setAttributedTitle:title forState:UIControlStateNormal];
        [radioButton setTitleColor:color forState:UIControlStateNormal];
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.iconSize=14;
        radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [radioButton addTarget:self action:@selector(logSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
        [_radioscrollview addSubview:radioButton];
        return radioButton;
    }
}

- (DLRadioButton *)createRadioButtonWithFrame:(CGRect) frame Title:(NSString *)title Color:(UIColor *)color
{
    if (unitsarr.count<80) {
        DLRadioButton *radioButton = [[DLRadioButton alloc] initWithFrame:frame];
       // radioButton.titleLabel.font = [UIFont systemFontOfSize:18];//14
        radioButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        [radioButton setTitle:title forState:UIControlStateNormal];
        [radioButton setTitleColor:color forState:UIControlStateNormal];
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.iconSize=14;
        radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [radioButton addTarget:self action:@selector(logSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
        [_demoView addSubview:radioButton];
        return radioButton;
    }
    else
    {
        DLRadioButton *radioButton = [[DLRadioButton alloc] initWithFrame:frame];
       // radioButton.titleLabel.font = [UIFont systemFontOfSize:18];//14
        radioButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];

        [radioButton setTitle:title forState:UIControlStateNormal];
        [radioButton setTitleColor:color forState:UIControlStateNormal];
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.iconSize=14;
        radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [radioButton addTarget:self action:@selector(logSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
        [_radioscrollview addSubview:radioButton];
        return radioButton;
    }
}
- (DLRadioButton *)createcheckboxWithFrame:(CGRect) frame Title:(NSString *)title Color:(UIColor *)color
{
    DLRadioButton *radioButton = [[DLRadioButton alloc] initWithFrame:frame];
    //radioButton.titleLabel.font = [UIFont systemFontOfSize:18];//14
    radioButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];

    [radioButton setTitle:title forState:UIControlStateNormal];
    [radioButton setTitleColor:color forState:UIControlStateNormal];
    radioButton.iconColor = color;
    radioButton.indicatorColor = color;
    radioButton.iconSize=14;
    radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [radioButton addTarget:self action:@selector(logSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
    [_view3scrollview addSubview:radioButton];
    return radioButton;
}
- (IBAction)logSelectedButton:(DLRadioButton *)radioButton {
    if (radioButton.isMultipleSelectionEnabled) {
        for (DLRadioButton *button in radioButton.selectedButtons) {
            NSLog(@"%@ is selected.\n", button.titleLabel.text);
        }
    } else
    {
        //check whether button tittle appends "p" then remove it
        NSString * buttonTitle = [NSString stringWithFormat:@"%@",radioButton.selectedButton.titleLabel.text];
        if([[buttonTitle substringFromIndex:[buttonTitle length]-1] isEqualToString:@"p"]){
            //Remove p
            NSString *StringAfterRemovep = [buttonTitle substringToIndex:[buttonTitle length] - 1];
            _radiobtntxt = StringAfterRemovep;
            
        }else{
            _radiobtntxt = buttonTitle;
        }
    
//        _radiobtntxt=[NSString stringWithFormat:@"%@",radioButton.selectedButton.titleLabel.text];
    }
}
-(void)block
{
    if ([_radiobtntxt isEqualToString:@""]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Select unit first"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Block" message:_radiobtntxt delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Block", nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert textFieldAtIndex:1].secureTextEntry = NO; //Will disable secure text entry for second textfield.
    [alert textFieldAtIndex:0].placeholder = @"Blocking reason"; //Will replace "Username"
    [alert textFieldAtIndex:1].placeholder = @"Blocked for"; //Will replace "Password"
    [alert show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag==101) {
        if (buttonIndex==0)
        {
            approvebtn.enabled=YES;
            revisedagrttxt.text= totalagrlbl2.text;
            descontvaluetxt.text=@"";
        }
          if (buttonIndex==1)
          {
//              approvebtn.enabled=NO;
//              NSLocale *locale = [NSLocale currentLocale];
//              NSString *thousandSeparator = [locale objectForKey:NSLocaleGroupingSeparator];
//              NSString *result = [totalagrlbl2.text stringByReplacingOccurrencesOfString:thousandSeparator withString:@""];
//
//              NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//              AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//              manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//              NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
//              [params setObject:result  forKey:@"agvalue"];
//              [params setObject:@"saveDiscountvalue"  forKey:@"requestType"];
//              [params setObject:[prefs objectForKey:@"user_name"]  forKey:@"requestedby"];
//              [params setObject:nametxt.text  forKey:@"projname"];
//              [params setObject:_radiobtntxt  forKey:@"unitno"];
//              [params setObject: descontvaluetxt.text forKey:@"discount_amt"];
//              [params setObject:[_flatdetailsdict objectForKey:@"discount_percentage"]  forKey:@"discount_per"];
//              [params setObject:@"validate_user"  forKey:@"requestdate"];
//
//              NSString*   urlString = [[NSString alloc]initWithFormat:@"%@savediscountapproval.php?",[prefs objectForKey:@"Link"]];
//
//              [indicator startAnimating];
//              [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//                  NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//                  NSString *content = [[NSString alloc]  initWithBytes:[responseObject bytes]
//                                                                length:[responseObject length] encoding: NSUTF8StringEncoding];
//                  NSLog(@"content %@",content);
//                  //NSLog(@"JSON: %@", userDict);
//                  int status=[[userDict objectForKey:@"status"]intValue];
//                  if (status==1) {
//                      _pkidstr=[userDict objectForKey:@"id"];
//                      UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"request has been sent for approval"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                      [alert show];
//                      [timer invalidate];
//                      timer = [NSTimer scheduledTimerWithTimeInterval: 5.0
//                                                           target: self
//                                                         selector:@selector(onTick:)
//                                                         userInfo: nil repeats:YES];
//                  }
//                  else
//                  {
//                      UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                      [alert show];
//                  }
//                  [indicator stopAnimating];
//              } failure:^(NSURLSessionTask *operation, NSError *error) {
//                  NSLog(@"Error: %@", error);
//                  [indicator stopAnimating];
//                  UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                  [alert show];
//              }];
          }
          }
    else{
    
    if (buttonIndex==1) {
        _ipprojectdic=[[NSMutableDictionary alloc]init];
        for (int i=0; i<unitsarr.count; i++) {
            _selectedstr=[[unitsarr objectAtIndex:i]objectForKey:@"id"];
            if ([_radiobtntxt isEqualToString:_selectedstr])
                _ipprojectdic=[unitsarr objectAtIndex:i];
        }
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"blockUnit" forKey:@"module_name"];
        [params setObject:[prefs objectForKey:@"username"] forKey:@"username"];
        [params setObject:[prefs objectForKey:@"password"] forKey:@"password"];
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"usersimplecrmId"];
        [params setObject:[prefs objectForKey:@"url"] forKey:@"url"];
        AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
        [serializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        NSMutableDictionary *jsonDict=[[NSMutableDictionary alloc]init];
        [jsonDict setObject:@"25"forKey:@"ID"];
        NSMutableDictionary *datadict=[[NSMutableDictionary alloc]init];
        [datadict setObject:[_ipprojectdic objectForKey:@"id"] forKey:@"unit_no"];
        [datadict setObject:[_ipprojectdic objectForKey:@"ipProjectId"]forKey:@"ipprojectId"];
        [datadict setObject:[alertView textFieldAtIndex:0].text forKey:@"block_remarks"];
        [datadict setObject:[alertView textFieldAtIndex:1].text forKey:@"blocked_for"];
        NSMutableArray *arr =[[NSMutableArray alloc]initWithObjects:datadict, nil];

        [jsonDict setObject:arr forKey:@"data"];
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
        [params setObject:jsonString  forKey:@"jsonParam"];
        
        //    NSString*   encodedUrl = [jsonString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        //    [params setObject:encodedUrl  forKey:@"jsonParam"];
        
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@cancel_shift_original.php?",[prefs objectForKey:@"Link"]];
        
        [_indicator2 startAnimating];
        
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];

            NSLog(@"JSON: %@", userDict);
            NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[dic objectForKey:@"message"]delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [_indicator2 stopAnimating];
            [TakePhotoView close];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [_indicator2 stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [TakePhotoView close];
        }];
    }
    }
}

-(void)onTick:(NSTimer *)timer {
    
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"getstatus"  forKey:@"requestType"];
        [params setObject:_pkidstr  forKey:@"pkid"];
    
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@checkdiscountstatus.php?",[prefs objectForKey:@"Link"]];
        
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSLog(@"JSON: %@", userDict);
            if ([[userDict objectForKey:@"status"] isEqualToString:@"Requested"]) {
                
            }
else if ([[userDict objectForKey:@"status"] isEqualToString:@"Rejected"])
           {
                [timer invalidate];
               UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Your request has been rejected"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
               [alert show];
               approvebtn.enabled=YES;
               revisedagrttxt.text=[_flatdetailsdict objectForKey:@"agreement_value"];
               descontvaluetxt.text=@"";
            }
            else if ([[userDict objectForKey:@"status"] isEqualToString:@"Approved"])
            {
                approvebtn.enabled=YES;
                [timer invalidate];
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Your request has been approved"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
           
            [indicator stopAnimating];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
        }];
}
-(void)closeAlert:(id)sender{
    [TakePhotoView close];
    _radiobtntxt=nil;
}
-(void)check:(UIButton*) sender
{
    if (sender.isSelected) {
        sender.selected=NO;
    }
    else
    {
        sender.selected=YES;
    }
}
-(void)select:(UIButton*)sender
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    count=sender.tag;
    if (sender.tag==1) {
        step1btn.selected=YES;
        step2btn.selected=NO;
        step3btn.selected=NO;
        step4btn.selected=NO;
        step5btn.selected=NO;

        _bottmborder1.hidden=NO;
        _bottmborder2.hidden=YES;
        _bottmborder3.hidden=YES;
        _bottmborder4.hidden=YES;
        _bottmborder5.hidden=YES;
        
        _view1.hidden=NO;
        _view2.hidden=YES;
        _view3.hidden=YES;
        _view4.hidden=YES;
        _view5.hidden=YES;
    }
    
    if (sender.tag==2) {
        if ([_radiobtntxt isEqualToString:@""]) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Select unit first"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            unitlbl.text=_radiobtntxt;
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            _ipprojectdic=[[NSMutableDictionary alloc]init];
            for (int i=0; i<unitsarr.count; i++) {
                _selectedstr=[[unitsarr objectAtIndex:i]objectForKey:@"id"];
                if ([_radiobtntxt isEqualToString:_selectedstr]){
                    _ipprojectdic=[unitsarr objectAtIndex:i];

                }
            }
            //NSString *truncatedString = [str substringToIndex:[str length]-1];
//            unit_status
//            Available
            if ([[[_ipprojectdic objectForKey:@"unit_status"] uppercaseString]isEqualToString:[@"Available" uppercaseString]]||[[[_ipprojectdic objectForKey:@"blocked_user_name"]uppercaseString]isEqualToString:[[prefs objectForKey:@"user_name"]uppercaseString]]) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
                [params setObject:@"get_flat_details"  forKey:@"requestType"];
                [params setObject:siteidstr  forKey:@"buildingId"];
                [params setObject:_radiobtntxt  forKey:@"unitCode"];
                
                [params setObject:[_dict objectForKey:@"project_id"] forKey:@"projectId"];
                [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"user_id"];

                NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getinventorydata.php?",[prefs objectForKey:@"Link"]];
                [indicator startAnimating];
                
                [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                    NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    
                    NSLog(@"JSON: %@", userDict);
                    NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
                    self->_flatdetailsdict=[[NSMutableDictionary alloc]init];
                    self->_flatdetailsdict=[dic objectForKey:@"flat_details"];
                    self->unitlbl2.text=[self->_flatdetailsdict objectForKey:@"unit_no"];
                    self->flatyplbl2.text=[self->_flatdetailsdict objectForKey:@"flat_type"];
                    self->carlbl2.text=[self->_flatdetailsdict objectForKey:@"carpet_area"];
                    self->redcarpetlbl2.text=[self->_flatdetailsdict objectForKey:@"rera_ca"];
                    self->totalarwlbl2.text=[self->_flatdetailsdict objectForKey:@"rera_total"];
                    self->totalagrlbl2.text=[self->_flatdetailsdict objectForKey:@"agreement_value"];
                    self->revisedagrttxt.text=[self->_flatdetailsdict objectForKey:@"agreement_value"];
                    self->_avaragevaluastr=[self->_flatdetailsdict objectForKey:@"agreement_value"];
                    self->bankamountxt.text=[self->_flatdetailsdict objectForKey:@"booking_amount"];
           //         assignlbl.text=[NSString stringWithFormat:@"In fav. of:%@",[[_flatdetailsdict objectForKey:@"in_fav"]lowercaseString]];

                    step1btn.selected=NO;
                    step2btn.selected=YES;
                    step3btn.selected=NO;
                    step4btn.selected=NO;
                    step5btn.selected=NO;
                    
                    _bottmborder1.hidden=YES;
                    _bottmborder2.hidden=NO;
                    _bottmborder3.hidden=YES;
                    _bottmborder4.hidden=YES;
                    _bottmborder5.hidden=YES;
                    
                    _view1.hidden=YES;
                    _view2.hidden=NO;
                    _view3.hidden=YES;
                    _view4.hidden=YES;
                    _view5.hidden=YES;
                    
                    descontvaluetxt.text=@"";
                    discountremarktxt.text=@"";
                    [TakePhotoView close];
                    [indicator stopAnimating];
                } failure:^(NSURLSessionTask *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    [indicator stopAnimating];
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }];
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"The unit is already bolcked"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            }
    }
    if (sender.tag==3) {
       if(![schemetxt.text isEqualToString:@""])
       {
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
           AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
           manager.responseSerializer = [AFHTTPResponseSerializer serializer];
           NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
           [params setObject:@"getPaymentSchedule"  forKey:@"requestType"];
           [params setObject:siteidstr  forKey:@"buildingId"];
           [params setObject:revisedagrttxt.text  forKey:@"agreement_value"];
           [params setObject:schemeidstr forKey:@"schemeId"];
           [params setObject:[_ipprojectdic objectForKey:@"ipProjectId"] forKey:@"ipProjectId"];
           [params setObject:_radiobtntxt  forKey:@"unit_no"];

           NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getinventorydata.php?",[prefs objectForKey:@"Link"]];
           [indicator startAnimating];
           
           [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
               NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
               
               NSLog(@"JSON: %@", userDict);
               _pamentdetialsfinaldict =[userDict objectForKey:@"Android"];
               _paymentdetailsdict=[[NSMutableDictionary alloc]init];
               _paymentdetailsdict=[_pamentdetialsfinaldict objectForKey:@"payment_details"];
               _tableheadrarr=[_paymentdetailsdict objectForKey:@"milestones"];
               [tableViewHome reloadData];

               //            unitlbl2.text=[_flatdetailsdict objectForKey:@"unit_no"];
               //            flatyplbl2.text=[_flatdetailsdict objectForKey:@"flat_type"];
               //            carlbl2.text=[_flatdetailsdict objectForKey:@"carpet_area"];
               //            redcarpetlbl2.text=[_flatdetailsdict objectForKey:@"rera_ca"];
               //            totalarwlbl2.text=[_flatdetailsdict objectForKey:@"rera_total"];
               //            totalagrlbl2.text=[_flatdetailsdict objectForKey:@"agreement_value"];
               //            revisedagrttxt.text=[_flatdetailsdict objectForKey:@"agreement_value"];
               [indicator stopAnimating];
               [_view3scrollview removeFromSuperview];
               
               CGRect scrollViewFrame1 = CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.0,screenRect.size.width,screenRect.size.height*0.76);
               _view3scrollview = [[UIScrollView alloc] initWithFrame:scrollViewFrame1];
               _view3scrollview.backgroundColor=[UIColor clearColor];
               _view3scrollview.delegate = self;
               _view3scrollview.showsHorizontalScrollIndicator = NO;
               [_view3 addSubview:_view3scrollview];
               
               UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.20,screenRect.size.height*.0,screenRect.size.width*.60,screenRect.size.height*.07)];
               titlelable.textAlignment = NSTextAlignmentCenter;
               titlelable.text=@"Payment Schedule";
               titlelable.textColor=[UIColor blackColor];
               [titlelable setBackgroundColor:[UIColor clearColor]];
               titlelable.font=[UIFont systemFontOfSize:18];
               [_view3scrollview addSubview:titlelable];
               
               pamentschemetxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*.08,screenRect.size.width*0.90,screenRect.size.height*0.07)];
               pamentschemetxt.textAlignment=NSTextAlignmentLeft;
               pamentschemetxt.delegate = self;
               pamentschemetxt.textColor=[UIColor lightGrayColor];
               [pamentschemetxt setBackgroundColor:[UIColor clearColor]];
               pamentschemetxt.leftViewMode = UITextFieldViewModeAlways;
               [pamentschemetxt setKeyboardType:UIKeyboardTypeEmailAddress];
               pamentschemetxt.returnKeyType=UIReturnKeyDone;
               pamentschemetxt.floatingLabelActiveTextColor = [UIColor redColor];
               pamentschemetxt.floatingLabelInactiveTextColor = [UIColor grayColor];
               CALayer *bottomBorders3 = [CALayer layer];
               bottomBorders3.frame = CGRectMake(0.0f, pamentschemetxt.frame.size.height - 5, pamentschemetxt.frame.size.width, 1.0f);
               bottomBorders3.backgroundColor = [UIColor lightGrayColor].CGColor;
               [pamentschemetxt.layer addSublayer:bottomBorders3];
               pamentschemetxt.placeholder=@"Payment Scheme";
               pamentschemetxt.font = [UIFont systemFontOfSize:14];
               pamentschemetxt.enabled=NO;
               [_view3scrollview addSubview:pamentschemetxt];
               
               NSMutableDictionary *taxdetailsdict=[_paymentdetailsdict objectForKey:@"tax_details"];
               agrementvaluetxt.text=[taxdetailsdict objectForKey:@"agreementValue"];
               NSMutableDictionary* loaddict=[_paymentdetailsdict objectForKey:@"loan_details"];
             
               pamentschemetxt.text=schemetxt.text;
               int hig=screenRect.size.height*0.18;
            
               {
                   if (![pamentschemetxt.text isEqualToString:@"FULUPFRONT"]) {
                       cibiltext = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
                       cibiltext.textAlignment=NSTextAlignmentLeft;
                       cibiltext.delegate = self;
                       cibiltext.textColor=[UIColor blackColor];
                       [cibiltext setBackgroundColor:[UIColor clearColor]];
                       cibiltext.leftViewMode = UITextFieldViewModeAlways;
                       [cibiltext setKeyboardType:UIKeyboardTypeEmailAddress];
                       cibiltext.returnKeyType=UIReturnKeyDone;
                       cibiltext.placeholder=@"Enter cibil score";
                       cibiltext.font = [UIFont systemFontOfSize:14];
                       [_view3scrollview addSubview:cibiltext];
                       
                       hig =hig+screenRect.size.height*0.10;
                       
                       if (![pamentschemetxt.text isEqualToString:@"SELFFUNDING(R)"]) {
                           Customertypetxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
                           Customertypetxt.textAlignment=NSTextAlignmentLeft;
                           Customertypetxt.delegate = self;
                           Customertypetxt.textColor=[UIColor blackColor];
                           [Customertypetxt setBackgroundColor:[UIColor clearColor]];
                           Customertypetxt.leftViewMode = UITextFieldViewModeAlways;
                           [Customertypetxt setKeyboardType:UIKeyboardTypeEmailAddress];
                           Customertypetxt.returnKeyType=UIReturnKeyDone;
                           Customertypetxt.placeholder=@"Customer type";
                           Customertypetxt.font = [UIFont systemFontOfSize:14];
                           [_view3scrollview addSubview:Customertypetxt];
                           
                           hig =hig+screenRect.size.height*0.10;
                           
                           hight=hig;
                        
                           int high=0;
                           UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];
                           
                           _checkboxview=[[UIView alloc]initWithFrame:CGRectMake(0,hight,screenRect.size.width,screenRect.size.height*0.27)];
                           [_view3scrollview addSubview:_checkboxview];
                           
                           _checkbox1=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,0,screenRect.size.width*.08,screenRect.size.height*.05)];
                           [_checkbox1 addTarget:self action:@selector(selectcheckbox:) forControlEvents:UIControlEventTouchUpInside];
                           [_checkbox1 setTitle:@"\uE835" forState:UIControlStateNormal];
                           [_checkbox1 setTitle:@"\uE834" forState:UIControlStateSelected];
                           [_checkbox1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                           [_checkbox1.titleLabel setFont:customFontdregs];
                           [_checkboxview addSubview:_checkbox1];
                           
                           _checkboxlbl1=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,0,screenRect.size.width*0.20,screenRect.size.height*.05)];
                           _checkboxlbl1.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
                           _checkboxlbl1.text=@"Salary slip";
                           [_checkboxlbl1 setTextColor:[UIColor blackColor]];
                           _checkboxlbl1.textAlignment = NSTextAlignmentCenter;
                           [_checkboxview addSubview:_checkboxlbl1];
                           
                           _checkbox2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.30,0,screenRect.size.width*.08,screenRect.size.height*.05)];
                           [_checkbox2 addTarget:self action:@selector(selectcheckbox:) forControlEvents:UIControlEventTouchUpInside];
                           [_checkbox2 setTitle:@"\uE835" forState:UIControlStateNormal];
                           [_checkbox2 setTitle:@"\uE834" forState:UIControlStateSelected];
                           [_checkbox2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                           [_checkbox2.titleLabel setFont:customFontdregs];
                           [_checkboxview addSubview:_checkbox2];
                           
                           _checkboxlbl2=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.38,0,screenRect.size.width*0.15,screenRect.size.height*.05)];
                           _checkboxlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
                           _checkboxlbl2.text=@"Form 16";
                           [_checkboxlbl2 setTextColor:[UIColor blackColor]];
                           _checkboxlbl2.textAlignment = NSTextAlignmentCenter;
                           [_checkboxview addSubview:_checkboxlbl2];
                           
                           _checkbox3=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.54,0,screenRect.size.width*.15,screenRect.size.height*.05)];
                           [_checkbox3 addTarget:self action:@selector(selectcheckbox:) forControlEvents:UIControlEventTouchUpInside];
                           [_checkbox3 setTitle:@"\uE835" forState:UIControlStateNormal];
                           [_checkbox3 setTitle:@"\uE834" forState:UIControlStateSelected];
                           [_checkbox3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                           [_checkbox3.titleLabel setFont:customFontdregs];
                           [_checkboxview addSubview:_checkbox3];
                           
                           _checkboxlbl3=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.62,0,screenRect.size.width*0.36,screenRect.size.height*.05)];
                           _checkboxlbl3.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
                           _checkboxlbl3.text=@"Bank Statement";
                           [_checkboxlbl3 setTextColor:[UIColor blackColor]];
                           _checkboxlbl3.textAlignment = NSTextAlignmentCenter;
                           [_checkboxview addSubview:_checkboxlbl3];
                           
                           high=high+screenRect.size.height*.05;
                           
                           _checkbox4=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,high,screenRect.size.width*.08,screenRect.size.height*.05)];
                           [_checkbox4 addTarget:self action:@selector(selectcheckbox:) forControlEvents:UIControlEventTouchUpInside];
                           [_checkbox4 setTitle:@"\uE835" forState:UIControlStateNormal];
                           [_checkbox4 setTitle:@"\uE834" forState:UIControlStateSelected];
                           [_checkbox4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                           [_checkbox4.titleLabel setFont:customFontdregs];
                           [_checkboxview addSubview:_checkbox4];
                           
                           _checkboxlbl4=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,high,screenRect.size.width*0.20,screenRect.size.height*.05)];
                           _checkboxlbl4.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
                           _checkboxlbl4.text=@"Badge";
                           [_checkboxlbl4 setTextColor:[UIColor blackColor]];
                           _checkboxlbl4.lineBreakMode = NSLineBreakByWordWrapping;
                           _checkboxlbl4.numberOfLines = 0;
                           _checkboxlbl4.textAlignment = NSTextAlignmentCenter;
                           [_checkboxview addSubview:_checkboxlbl4];
                           
                           _checkbox5=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.30,high,screenRect.size.width*.08,screenRect.size.height*.05)];
                           [_checkbox5 addTarget:self action:@selector(selectcheckbox:) forControlEvents:UIControlEventTouchUpInside];
                           [_checkbox5 setTitle:@"\uE835" forState:UIControlStateNormal];
                           [_checkbox5 setTitle:@"\uE834" forState:UIControlStateSelected];
                           [_checkbox5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                           [_checkbox5.titleLabel setFont:customFontdregs];
                           [_checkboxview addSubview:_checkbox5];
                           
                           _checkboxlbl5=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.38,high,screenRect.size.width*0.15,screenRect.size.height*.05)];
                           _checkboxlbl5.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
                           _checkboxlbl5.text=@"IPR";
                           [_checkboxlbl5 setTextColor:[UIColor blackColor]];
                           _checkboxlbl5.textAlignment = NSTextAlignmentCenter;
                           [_checkboxview addSubview:_checkboxlbl5];
                           
                           _checkbox6=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.54,high,screenRect.size.width*.15,screenRect.size.height*.05)];
                           [_checkbox6 addTarget:self action:@selector(selectcheckbox:) forControlEvents:UIControlEventTouchUpInside];
                           [_checkbox6 setTitle:@"\uE835" forState:UIControlStateNormal];
                           [_checkbox6 setTitle:@"\uE834" forState:UIControlStateSelected];
                           [_checkbox6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                           [_checkbox6.titleLabel setFont:customFontdregs];
                           [_checkboxview addSubview:_checkbox6];
                           
                           _checkboxlbl6=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.62,high,screenRect.size.width*0.36,screenRect.size.height*.05)];
                           _checkboxlbl6.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
                           _checkboxlbl6.text=@"Employment Certificate";
                           _checkboxlbl6.lineBreakMode = NSLineBreakByWordWrapping;
                           _checkboxlbl6.numberOfLines = 0;
                           [_checkboxlbl6 setTextColor:[UIColor blackColor]];
                           
                           _checkboxlbl6.textAlignment = NSTextAlignmentCenter;
                           [_checkboxview addSubview:_checkboxlbl6];
                           
                           high=high+screenRect.size.height*0.04;
                           
                           _checkbox7=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,high,screenRect.size.width*.08,screenRect.size.height*.05)];
                           [_checkbox7 addTarget:self action:@selector(selectcheckbox:) forControlEvents:UIControlEventTouchUpInside];
                           [_checkbox7 setTitle:@"\uE835" forState:UIControlStateNormal];
                           [_checkbox7 setTitle:@"\uE834" forState:UIControlStateSelected];
                           [_checkbox7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                           [_checkbox7.titleLabel setFont:customFontdregs];
                           [_checkboxview addSubview:_checkbox7];
                           
                           _checkboxlbl7=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,high,screenRect.size.width*0.20,screenRect.size.height*.05)];
                           _checkboxlbl7.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
                           _checkboxlbl7.text=@"Proof of business";
                           _checkboxlbl7.lineBreakMode = NSLineBreakByWordWrapping;
                           _checkboxlbl7.numberOfLines = 0;
                           [_checkboxlbl7 setTextColor:[UIColor blackColor]];
                           _checkboxlbl7.textAlignment = NSTextAlignmentCenter;
                           [_checkboxview addSubview:_checkboxlbl7];
                           
                           _checkbox8=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.30,high,screenRect.size.width*.08,screenRect.size.height*.05)];
                           [_checkbox8 addTarget:self action:@selector(selectcheckbox:) forControlEvents:UIControlEventTouchUpInside];
                           [_checkbox8 setTitle:@"\uE835" forState:UIControlStateNormal];
                           [_checkbox8 setTitle:@"\uE834" forState:UIControlStateSelected];
                           [_checkbox8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                           [_checkbox8.titleLabel setFont:customFontdregs];
                           [_checkboxview addSubview:_checkbox8];
                           
                           _checkboxlbl8=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.38,high,screenRect.size.width*0.15,screenRect.size.height*.05)];
                           _checkboxlbl8.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
                           _checkboxlbl8.text=@"Shop act";
                           [_checkboxlbl8 setTextColor:[UIColor blackColor]];
                           _checkboxlbl8.textAlignment = NSTextAlignmentCenter;
                           [_checkboxview addSubview:_checkboxlbl8];
                           
                           _checkbox9=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.54,high,screenRect.size.width*.15,screenRect.size.height*.05)];
                           [_checkbox9 addTarget:self action:@selector(selectcheckbox:) forControlEvents:UIControlEventTouchUpInside];
                           [_checkbox9 setTitle:@"\uE835" forState:UIControlStateNormal];
                           [_checkbox9 setTitle:@"\uE834" forState:UIControlStateSelected];
                           [_checkbox9 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                           [_checkbox9.titleLabel setFont:customFontdregs];
                           [_checkboxview addSubview:_checkbox9];
                           
                           _checkboxlbl9=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.62,high,screenRect.size.width*0.36,screenRect.size.height*.05)];
                           _checkboxlbl9.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
                           _checkboxlbl9.text=@"Investigation report";
                           [_checkboxlbl9 setTextColor:[UIColor blackColor]];
                           _checkboxlbl9.textAlignment = NSTextAlignmentCenter;
                           [_checkboxview addSubview:_checkboxlbl9];
                           
                           high=high+screenRect.size.height*.05;
                           
                           _checkbox10=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,high,screenRect.size.width*.08,screenRect.size.height*.05)];
                           [_checkbox10 addTarget:self action:@selector(selectcheckbox:) forControlEvents:UIControlEventTouchUpInside];
                           [_checkbox10 setTitle:@"\uE835" forState:UIControlStateNormal];
                           [_checkbox10 setTitle:@"\uE834" forState:UIControlStateSelected];
                           [_checkbox10 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                           [_checkbox10.titleLabel setFont:customFontdregs];
                           [_checkboxview addSubview:_checkbox10];
                           
                           _checkboxlbl10=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,high,screenRect.size.width*0.30,screenRect.size.height*.05)];
                           _checkboxlbl10.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
                           _checkboxlbl10.text=@"PD Assessment";
                           [_checkboxlbl10 setTextColor:[UIColor blackColor]];
                           _checkboxlbl10.textAlignment = NSTextAlignmentCenter;
                           [_checkboxview addSubview:_checkboxlbl10];
                           
                           _checkbox12=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.40,high,screenRect.size.width*.08,screenRect.size.height*.05)];
                           [_checkbox12 addTarget:self action:@selector(selectcheckbox:) forControlEvents:UIControlEventTouchUpInside];
                           [_checkbox12 setTitle:@"\uE835" forState:UIControlStateNormal];
                           [_checkbox12 setTitle:@"\uE834" forState:UIControlStateSelected];
                           [_checkbox12 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                           [_checkbox12.titleLabel setFont:customFontdregs];
                           [_checkboxview addSubview:_checkbox12];
                           
                           _checkboxlbl12=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.48,high,screenRect.size.width*0.35,screenRect.size.height*.05)];
                           _checkboxlbl12.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
                           _checkboxlbl12.text=@"Appointment Letter";
                           [_checkboxlbl12 setTextColor:[UIColor blackColor]];
                           _checkboxlbl12.textAlignment = NSTextAlignmentCenter;
                           [_checkboxview addSubview:_checkboxlbl12];
                           
                           high=high+screenRect.size.height*.05;

                           businessdetailstxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,high,screenRect.size.width*0.90,screenRect.size.height*0.07)];
                           businessdetailstxt.textAlignment=NSTextAlignmentLeft;
                           businessdetailstxt.delegate = self;
                           businessdetailstxt.textColor=[UIColor blackColor];
                           [businessdetailstxt setBackgroundColor:[UIColor clearColor]];
                           businessdetailstxt.leftViewMode = UITextFieldViewModeAlways;
                           [businessdetailstxt setKeyboardType:UIKeyboardTypeEmailAddress];
                           businessdetailstxt.returnKeyType=UIReturnKeyDone;
                           businessdetailstxt.font = [UIFont systemFontOfSize:14];
                           [_checkboxview addSubview:businessdetailstxt];
                           businessdetailstxt.hidden=YES;
                           
                           hig =hig+screenRect.size.height*0.27;
                           {
                               _checkbox1.enabled=NO;
                               _checkboxlbl1.textColor=[UIColor lightGrayColor];
                               [_checkbox1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                               
                               _checkbox2.enabled=NO;
                               _checkboxlbl2.textColor=[UIColor lightGrayColor];
                               [_checkbox2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                               
                               _checkbox3.enabled=NO;
                               _checkboxlbl3.textColor=[UIColor lightGrayColor];
                               [_checkbox3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                               
                               _checkbox4.enabled=NO;
                               _checkboxlbl4.textColor=[UIColor lightGrayColor];
                               [_checkbox4 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                               
                               _checkbox5.enabled=NO;
                               _checkboxlbl5.textColor=[UIColor lightGrayColor];
                               [_checkbox5 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                               
                               _checkbox6.enabled=NO;
                               _checkboxlbl6.textColor=[UIColor lightGrayColor];
                               [_checkbox6 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                               
                               _checkbox7.enabled=NO;
                               _checkboxlbl7.textColor=[UIColor lightGrayColor];
                               [_checkbox7 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                               
                               _checkbox8.enabled=NO;
                               _checkboxlbl8.textColor=[UIColor lightGrayColor];
                               [_checkbox8 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                               
                               _checkbox9.enabled=NO;
                               _checkboxlbl9.textColor=[UIColor lightGrayColor];
                               [_checkbox9 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                               
                               _checkbox10.enabled=NO;
                               _checkboxlbl10.textColor=[UIColor lightGrayColor];
                               [_checkbox10 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                               
                               _checkbox11.enabled=NO;
                               _checkboxlbl11.textColor=[UIColor lightGrayColor];
                               [_checkbox11 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                               
                               _checkbox12.enabled=NO;
                               _checkboxlbl12.textColor=[UIColor lightGrayColor];
                               [_checkbox12 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                           }
                       }
                   }
               UILabel *headerlbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.90,screenRect.size.height*.07)];
               headerlbl.textAlignment = NSTextAlignmentCenter;
               headerlbl.text=@"Agreement Value and Tax Details";
               headerlbl.textColor=[UIColor whiteColor];
               [headerlbl setBackgroundColor:[UIColor colorWithHexString:@"#2C60C2"]];
               headerlbl.font=[UIFont systemFontOfSize:18];
               [_view3scrollview addSubview:headerlbl];
               
               hig =hig+screenRect.size.height*0.10;
               
               UILabel *agrementvaluelbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.35,screenRect.size.height*.05)];
               agrementvaluelbl.textAlignment = NSTextAlignmentLeft;
               agrementvaluelbl.text=@"Agreement Value";
               agrementvaluelbl.textColor=[UIColor blackColor];
               [agrementvaluelbl setBackgroundColor:[UIColor clearColor]];
               agrementvaluelbl.font=[UIFont systemFontOfSize:14];
               [_view3scrollview addSubview:agrementvaluelbl];
                   
               agrementvaluetxt=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.60,hig,screenRect.size.width*.35,screenRect.size.height*.05)];
               agrementvaluetxt.textAlignment = NSTextAlignmentRight;
               agrementvaluetxt.textColor=[UIColor blackColor];
               [agrementvaluetxt setBackgroundColor:[UIColor clearColor]];
               agrementvaluetxt.font=[UIFont systemFontOfSize:14];
                   agrementvaluetxt.text=[taxdetailsdict objectForKey:@"agreementValue"];
               [_view3scrollview addSubview:agrementvaluetxt];
               
               hig =hig+screenRect.size.height*0.06;

       UILabel*  registrationlbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.50,screenRect.size.height*.05)];
               registrationlbl.textAlignment = NSTextAlignmentLeft;
               registrationlbl.text=@"Registration Charges";
               registrationlbl.textColor=[UIColor blackColor];
               [registrationlbl setBackgroundColor:[UIColor clearColor]];
               registrationlbl.font=[UIFont systemFontOfSize:14];
               [_view3scrollview addSubview:registrationlbl];
               
               registrationchartxt=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.60,hig,screenRect.size.width*.35,screenRect.size.height*.05)];
               registrationchartxt.textAlignment = NSTextAlignmentRight;
               registrationchartxt.textColor=[UIColor blackColor];
               [registrationchartxt setBackgroundColor:[UIColor clearColor]];
               registrationchartxt.font=[UIFont systemFontOfSize:14];
               [_view3scrollview addSubview:registrationchartxt];
               
               hig =hig+screenRect.size.height*0.06;
               
               _stampdutylbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.50,screenRect.size.height*.05)];
               _stampdutylbl.textAlignment = NSTextAlignmentLeft;
               _stampdutylbl.text=@"Stamp Duty";
               _stampdutylbl.textColor=[UIColor blackColor];
               [_stampdutylbl setBackgroundColor:[UIColor clearColor]];
               _stampdutylbl.font=[UIFont systemFontOfSize:15];
               [_view3scrollview addSubview:_stampdutylbl];
               
               stampdutytxt=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.60,hig,screenRect.size.width*.35,screenRect.size.height*.05)];
               stampdutytxt.textAlignment = NSTextAlignmentRight;
               stampdutytxt.textColor=[UIColor blackColor];
               [stampdutytxt setBackgroundColor:[UIColor clearColor]];
               stampdutytxt.font=[UIFont systemFontOfSize:14];
               [_view3scrollview addSubview:stampdutytxt];
               
               hig =hig+screenRect.size.height*0.06;
               
               _gstlbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.50,screenRect.size.height*.05)];
               _gstlbl.textAlignment = NSTextAlignmentLeft;
               _gstlbl.text=@"GST";
               _gstlbl.textColor=[UIColor blackColor];
               [_gstlbl setBackgroundColor:[UIColor clearColor]];
               _gstlbl.font=[UIFont systemFontOfSize:14];
               [_view3scrollview addSubview:_gstlbl];

               gstlbltxt=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.60,hig,screenRect.size.width*.35,screenRect.size.height*.05)];
               gstlbltxt.textAlignment = NSTextAlignmentRight;
               gstlbltxt.textColor=[UIColor blackColor];
               [gstlbltxt setBackgroundColor:[UIColor clearColor]];
               gstlbltxt.font=[UIFont systemFontOfSize:14];
               [_view3scrollview addSubview:gstlbltxt];
               
               hig =hig+screenRect.size.height*0.06;
               
               UILabel *legalanddoccharglbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.50,screenRect.size.height*.07)];
               legalanddoccharglbl.textAlignment = NSTextAlignmentLeft;
               legalanddoccharglbl.text=@"Legal and documentation Charges";
               legalanddoccharglbl.textColor=[UIColor blackColor];
               legalanddoccharglbl.lineBreakMode = NSLineBreakByWordWrapping;
               legalanddoccharglbl.numberOfLines = 0;
               [legalanddoccharglbl setBackgroundColor:[UIColor clearColor]];
               legalanddoccharglbl.font=[UIFont systemFontOfSize:14];
               [_view3scrollview addSubview:legalanddoccharglbl];
               
               legaldocchartxt=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.60,hig,screenRect.size.width*.35,screenRect.size.height*.07)];
               legaldocchartxt.textAlignment = NSTextAlignmentRight;
               legaldocchartxt.textColor=[UIColor blackColor];
               [legaldocchartxt setBackgroundColor:[UIColor clearColor]];
               legaldocchartxt.font=[UIFont systemFontOfSize:14];
               [_view3scrollview addSubview:legaldocchartxt];
               
               hig =hig+screenRect.size.height*0.08;
               
               UILabel *totalcostlbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.35,screenRect.size.height*.05)];
               totalcostlbl.textAlignment = NSTextAlignmentLeft;
               totalcostlbl.text=@"Total Cost";
               totalcostlbl.textColor=[UIColor redColor];
               [totalcostlbl setBackgroundColor:[UIColor clearColor]];
               totalcostlbl.font=[UIFont systemFontOfSize:14];
               [_view3scrollview addSubview:totalcostlbl];
               
               totalcosttxt=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.60,hig,screenRect.size.width*.35,screenRect.size.height*.05)];
               totalcosttxt.textAlignment = NSTextAlignmentRight;
               totalcosttxt.textColor=[UIColor redColor];
               [totalcosttxt setBackgroundColor:[UIColor clearColor]];
               totalcosttxt.font=[UIFont systemFontOfSize:14];
               [_view3scrollview addSubview:totalcosttxt];
               
               hig =hig+screenRect.size.height*0.06;
                   
                   if (_tableheadrarr.count>0) {
                       UILabel *paymentshceduklbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.90,screenRect.size.height*.07)];
                       paymentshceduklbl.textAlignment = NSTextAlignmentCenter;
                       paymentshceduklbl.text=@"Selected Payment schedule";
                       paymentshceduklbl.textColor=[UIColor whiteColor];
                       [paymentshceduklbl setBackgroundColor:[UIColor colorWithHexString:@"#2C60C2"]];
                       paymentshceduklbl.font=[UIFont systemFontOfSize:18];
                       [_view3scrollview addSubview:paymentshceduklbl];
                       
                       hig =hig+screenRect.size.height*0.10;
                       
                       [tableViewHome removeFromSuperview];
                       tableViewHome = [[UITableView alloc] init];
                       [tableViewHome setFrame:CGRectMake(0,hig, screenRect.size.width,(_tableheadrarr.count+1)*screenRect.size.height*0.07)];
                       tableViewHome.backgroundColor=[UIColor clearColor];
                       tableViewHome.delegate = self;
                       tableViewHome.dataSource = self;
                       //tableViewHome.separatorStyle=UITableViewCellSeparatorStyleNone;
                       [_view3scrollview addSubview:tableViewHome];
                   }
                   hig=hig+(_tableheadrarr.count+1)*screenRect.size.height*0.07+screenRect.size.height*0.05;
                registrationchartxt.text=[taxdetailsdict objectForKey:@"regvalue"];
                   stampdutytxt.text=[taxdetailsdict objectForKey:@"stamp_duty"];
                   gstlbltxt.text=[taxdetailsdict objectForKey:@"gst"];
                   legaldocchartxt.text=[taxdetailsdict objectForKey:@"doccharges"];
                   totalcosttxt.text=[taxdetailsdict objectForKey:@"total_cost"];
           }
               _stampdutylbl.text=[NSString stringWithFormat:@"Stamp Duty(%@%%)",[taxdetailsdict objectForKey:@"stamp_dutypercent"]];
               
               _gstlbl.text=[NSString stringWithFormat:@"GST(%@%%)",[taxdetailsdict objectForKey:@"gstpercent"]];
           
               if (loaddict.count>0) {
                   NSMutableDictionary *mutableDict = [loaddict mutableCopy];
                   
                   for (NSString *key in [loaddict allKeys]) {
                       if ([loaddict[key] isEqual:[NSNull null]]) {
                           mutableDict[key] = @"";
                       }
                   }
                   loaddict = [mutableDict copy];
                   
                   UILabel *paymentshceduklbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.90,screenRect.size.height*.07)];
                   paymentshceduklbl.textAlignment = NSTextAlignmentCenter;
                   paymentshceduklbl.text=@"Loan Details";
                   paymentshceduklbl.textColor=[UIColor whiteColor];
                   [paymentshceduklbl setBackgroundColor:[UIColor colorWithHexString:@"#2C60C2"]];
                   paymentshceduklbl.font=[UIFont systemFontOfSize:18];
                   [_view3scrollview addSubview:paymentshceduklbl];
                   
                   hig=hig+screenRect.size.height*0.10;
                   
                   UILabel *loandetailsbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.35,screenRect.size.height*.05)];
                   loandetailsbl.textAlignment = NSTextAlignmentLeft;
                   loandetailsbl.text=@"loan Details";
                   loandetailsbl.textColor=[UIColor blackColor];
                   loandetailsbl.lineBreakMode = NSLineBreakByWordWrapping;
                   loandetailsbl.numberOfLines = 0;
                   [loandetailsbl setBackgroundColor:[UIColor clearColor]];
                   loandetailsbl.font=[UIFont boldSystemFontOfSize:14];
                   [_view3scrollview addSubview:loandetailsbl];
                   
                   UILabel*   Particularslbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.60,hig,screenRect.size.width*.35,screenRect.size.height*.05)];
                   Particularslbl.text=@"Particulars";
                   Particularslbl.textAlignment = NSTextAlignmentRight;
                   Particularslbl.textColor=[UIColor blackColor];
                   [Particularslbl setBackgroundColor:[UIColor clearColor]];
                   Particularslbl.font=[UIFont boldSystemFontOfSize:14];
                   [_view3scrollview addSubview:Particularslbl];
                   
                   hig =hig+screenRect.size.height*0.06;
                   
                   UILabel *agementvaluelb=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.35,screenRect.size.height*.05)];
                   agementvaluelb.textAlignment = NSTextAlignmentLeft;
                   agementvaluelb.text=@"Agreement Value";
                   agementvaluelb.textColor=[UIColor blackColor];
                   agementvaluelb.lineBreakMode = NSLineBreakByWordWrapping;
                   agementvaluelb.numberOfLines = 0;
                   [agementvaluelb setBackgroundColor:[UIColor clearColor]];
                   agementvaluelb.font=[UIFont systemFontOfSize:14];
                   [_view3scrollview addSubview:agementvaluelb];
                   
                   UILabel*   agrementxtlbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.60,hig,screenRect.size.width*.35,screenRect.size.height*.05)];
                   agrementxtlbl.text=[loaddict objectForKey:@"agreement_value"];
                   agrementxtlbl.textAlignment = NSTextAlignmentRight;
                   agrementxtlbl.textColor=[UIColor blackColor];
                   [agrementxtlbl setBackgroundColor:[UIColor clearColor]];
                   agrementxtlbl.font=[UIFont systemFontOfSize:14];
                   [_view3scrollview addSubview:agrementxtlbl];
                   
                   hig =hig+screenRect.size.height*0.06;
                   
                   UILabel *loanlbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.35,screenRect.size.height*.05)];
                   loanlbl.textAlignment = NSTextAlignmentLeft;
                   loanlbl.text=@"Loan Amount";
                   loanlbl.textColor=[UIColor blackColor];
                   loanlbl.lineBreakMode = NSLineBreakByWordWrapping;
                   loanlbl.numberOfLines = 0;
                   [loanlbl setBackgroundColor:[UIColor clearColor]];
                   loanlbl.font=[UIFont systemFontOfSize:14];
                   [_view3scrollview addSubview:loanlbl];
                   
                   UILabel*   loanlbltxt=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.60,hig,screenRect.size.width*.35,screenRect.size.height*.05)];
                   loanlbltxt.text=[loaddict objectForKey:@"loanamount"];
                   loanlbltxt.textAlignment = NSTextAlignmentRight;
                   loanlbltxt.textColor=[UIColor blackColor];
                   [loanlbltxt setBackgroundColor:[UIColor clearColor]];
                   loanlbltxt.font=[UIFont systemFontOfSize:14];
                   [_view3scrollview addSubview:loanlbltxt];
                   
                   hig =hig+screenRect.size.height*0.06;
                   
                   UILabel *roilbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.35,screenRect.size.height*.07)];
                   roilbl.textAlignment = NSTextAlignmentLeft;
                   roilbl.text=@"ROI %";
                   roilbl.textColor=[UIColor blackColor];
                   roilbl.lineBreakMode = NSLineBreakByWordWrapping;
                   roilbl.numberOfLines = 0;
                   [roilbl setBackgroundColor:[UIColor clearColor]];
                   roilbl.font=[UIFont systemFontOfSize:14];
                   [_view3scrollview addSubview:roilbl];
                   
                   UILabel*   roilbltxt=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.60,hig,screenRect.size.width*.35,screenRect.size.height*.05)];
                   roilbltxt.text=[loaddict objectForKey:@"interest"];
                   roilbltxt.textAlignment = NSTextAlignmentRight;
                   roilbltxt.textColor=[UIColor blackColor];
                   [roilbltxt setBackgroundColor:[UIColor clearColor]];
                   roilbltxt.font=[UIFont systemFontOfSize:14];
                   [_view3scrollview addSubview:roilbltxt];
                   
                   hig =hig+screenRect.size.height*0.06;
                   
                   UILabel *tenurelbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.35,screenRect.size.height*.07)];
                   tenurelbl.textAlignment = NSTextAlignmentLeft;
                   tenurelbl.text=@"Tenure Months";
                   tenurelbl.textColor=[UIColor blackColor];
                   tenurelbl.lineBreakMode = NSLineBreakByWordWrapping;
                   tenurelbl.numberOfLines = 0;
                   [tenurelbl setBackgroundColor:[UIColor clearColor]];
                   tenurelbl.font=[UIFont systemFontOfSize:14];
                   [_view3scrollview addSubview:tenurelbl];
                   
                   UILabel*   tenurelbltxt=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.60,hig,screenRect.size.width*.35,screenRect.size.height*.05)];
                   tenurelbltxt.text=[NSString stringWithFormat:@"%ld",[[loaddict objectForKey:@"noofemi"]integerValue]];
                   ;
                   tenurelbltxt.textAlignment = NSTextAlignmentRight;
                   tenurelbltxt.textColor=[UIColor blackColor];
                   [tenurelbltxt setBackgroundColor:[UIColor clearColor]];
                   tenurelbltxt.font=[UIFont systemFontOfSize:14];
                   [_view3scrollview addSubview:tenurelbltxt];
                   
                   hig =hig+screenRect.size.height*0.06;
                   
                   UILabel *Emilbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.35,screenRect.size.height*.07)];
                   Emilbl.textAlignment = NSTextAlignmentLeft;
                   Emilbl.text=@"EMI";
                   Emilbl.textColor=[UIColor blackColor];
                   Emilbl.lineBreakMode = NSLineBreakByWordWrapping;
                   Emilbl.numberOfLines = 0;
                   [Emilbl setBackgroundColor:[UIColor clearColor]];
                   Emilbl.font=[UIFont systemFontOfSize:14];
                   [_view3scrollview addSubview:Emilbl];
                   
                   UILabel*   emilbltxt=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.60,hig,screenRect.size.width*.35,screenRect.size.height*.05)];
                   emilbltxt.text=[loaddict objectForKey:@"EMI"];
                   emilbltxt.textAlignment = NSTextAlignmentRight;
                   emilbltxt.textColor=[UIColor blackColor];
                   [emilbltxt setBackgroundColor:[UIColor clearColor]];
                   emilbltxt.font=[UIFont systemFontOfSize:14];
                   [_view3scrollview addSubview:emilbltxt];
                   
                   hig =hig+screenRect.size.height*0.06;
                   UILabel *taxemilbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.35,screenRect.size.height*.07)];
                   taxemilbl.textAlignment = NSTextAlignmentLeft;
                   taxemilbl.text=@"Tax EMI @12%";
                   taxemilbl.textColor=[UIColor blackColor];
                   taxemilbl.lineBreakMode = NSLineBreakByWordWrapping;
                   taxemilbl.numberOfLines = 0;
                   [taxemilbl setBackgroundColor:[UIColor clearColor]];
                   taxemilbl.font=[UIFont systemFontOfSize:14];
                   [_view3scrollview addSubview:taxemilbl];
                   
                   UILabel*   taxemilblrxt=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.60,hig,screenRect.size.width*.35,screenRect.size.height*.05)];
                   taxemilblrxt.text=[loaddict objectForKey:@"tax_on_emi"];
                   taxemilblrxt.textAlignment = NSTextAlignmentRight;
                   taxemilblrxt.textColor=[UIColor blackColor];
                   [taxemilblrxt setBackgroundColor:[UIColor clearColor]];
                   taxemilblrxt.font=[UIFont systemFontOfSize:14];
                   [_view3scrollview addSubview:taxemilblrxt];
                   
                   hig =hig+screenRect.size.height*0.06;
                   
                   UILabel *totalemi=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.35,screenRect.size.height*.07)];
                   totalemi.textAlignment = NSTextAlignmentLeft;
                   totalemi.text=@"Total EMI";
                   totalemi.textColor=[UIColor blackColor];
                   totalemi.lineBreakMode = NSLineBreakByWordWrapping;
                   totalemi.numberOfLines = 0;
                   [totalemi setBackgroundColor:[UIColor clearColor]];
                   totalemi.font=[UIFont systemFontOfSize:14];
                   [_view3scrollview addSubview:totalemi];
                   
                   UILabel*  totalemilbltxt=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.60,hig,screenRect.size.width*.35,screenRect.size.height*.05)];
                   totalemilbltxt.text=[loaddict objectForKey:@"total_emi"];
                   totalemilbltxt.textAlignment = NSTextAlignmentRight;
                   totalemilbltxt.textColor=[UIColor blackColor];
                   [totalemilbltxt setBackgroundColor:[UIColor clearColor]];
                   totalemilbltxt.font=[UIFont systemFontOfSize:14];
                   [_view3scrollview addSubview:totalemilbltxt];
                   hig =hig+screenRect.size.height*0.06;
               }
               _view3scrollview.contentSize=CGSizeMake(screenRect.size.width,hig);

               step1btn.selected=NO;
               step2btn.selected=NO;
               step3btn.selected=YES;
               step4btn.selected=NO;
               step5btn.selected=NO;
               
               _bottmborder1.hidden=YES;
               _bottmborder2.hidden=YES;
               _bottmborder3.hidden=NO;
               _bottmborder4.hidden=YES;
               _bottmborder5.hidden=YES;

               _view1.hidden=YES;
               _view2.hidden=YES;
               _view3.hidden=NO;
               _view4.hidden=YES;
               _view5.hidden=YES;
               
           } failure:^(NSURLSessionTask *operation, NSError *error) {
               NSLog(@"Error: %@", error);
               [indicator stopAnimating];
               UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
               [alert show];
           }];
       }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Please select scheme"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    if (sender.tag==4) {
        
        revisedagrementvaluetxt.text=agrementvaluetxt.text;
        if ([comefromstr isEqualToString:@"Visit"]) {
            custmobnotxt.text=[_dict objectForKey:@"customer_mobile_c"];
//            if (custmobnotxt.text.length>3) {
//                [self checkleads];
//            }
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
            [params setObject:@"getCustomerDetails"  forKey:@"requestType"];
            [params setObject:[_dict objectForKey:@"customer_mobile_c"]  forKey:@"mobileNo"];
            [params setObject:[_dict objectForKey:@"project_id"] forKey:@"projectId"];
            AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
         //   [serializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getbookingdata.php?",[prefs objectForKey:@"Link"]];
            [indicator startAnimating];
            
            [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                NSLog(@"JSON: %@", userDict);
                NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
                NSMutableDictionary* custmerdetailsdict=[dic objectForKey:@"custDetails"];
                custnametxt.text=[NSString stringWithFormat:@"%@ %@",[custmerdetailsdict objectForKey:@"first_name"],[custmerdetailsdict objectForKey:@"last_name"]];
                custemailtxt.text=[custmerdetailsdict objectForKey:@"email_address"];
                custaddrtxt.text=[custmerdetailsdict objectForKey:@"address"];
                sourcetxt.text=[custmerdetailsdict objectForKey:@"lead_source"];
                if (![sourcetxt.text isEqualToString:@""]) {
                    sourcetxt.enabled=NO;
                }
                [indicator stopAnimating];
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                [indicator stopAnimating];
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }];
        }
        step1btn.selected=NO;
        step2btn.selected=NO;
        step3btn.selected=NO;
        step4btn.selected=YES;
        step5btn.selected=NO;

        _bottmborder1.hidden=YES;
        _bottmborder2.hidden=YES;
        _bottmborder3.hidden=YES;
        _bottmborder4.hidden=NO;
        _bottmborder5.hidden=YES;

        _view1.hidden=YES;
        _view2.hidden=YES;
        _view3.hidden=YES;
        _view4.hidden=NO;
        _view5.hidden=YES;
    }
    if (sender.tag==5) {
       // NSLog(@"length=%lu",custmobnotxt.text.length);
        if (![custmobnotxt.text isEqualToString:@""]&& (custmobnotxt.text.length==10)) {
             if (![custnametxt.text isEqualToString:@""]) {
                   if (![custemailtxt.text isEqualToString:@""]||[custemailtxt.text isEqualToString:@" "]) {
                       if ([self validateEmailWithString]) {
                           if (![sourcetxt.text isEqualToString:@""]) {
                               step1btn.selected=NO;
                               step2btn.selected=NO;
                               step3btn.selected=NO;
                               step4btn.selected=NO;
                               step5btn.selected=YES;
                               
                               _bottmborder1.hidden=YES;
                               _bottmborder2.hidden=YES;
                               _bottmborder3.hidden=YES;
                               _bottmborder4.hidden=YES;
                               _bottmborder5.hidden=NO;
                               
                               _view1.hidden=YES;
                               _view2.hidden=YES;
                               _view3.hidden=YES;
                               _view4.hidden=YES;
                               _view5.hidden=NO;
                           }
                           else
                           {
                               UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Source is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
                      UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Email is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alert show];
                 }
             }
             else{
                  UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Name is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];
             }
        }
        else
        {
             UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Invalid mobile no." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    if (sender.tag==6)
    {
       // Cash
        if ([typeofpayment.text isEqualToString:@"Cash"]) {
            if (![handedovertotext.text isEqualToString:@""]) {
              if (![amounttxt.text isEqualToString:@""]) {
                  [self FinalsubmitBooking:@"tab"];
            }
                else
                {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Amount is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Enter Hand over to." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
      else  if ([typeofpayment.text isEqualToString:@"Card Swipe"]) {
            if (![_instrumentdatetxt.text isEqualToString:@""]) {
                if (![_instrumentno.text isEqualToString:@""]) {
                    if (![_lastfourdigitsofcardtxt.text isEqualToString:@""]) {
                        if (![amounttxt.text isEqualToString:@""]) {
                            [self FinalsubmitBooking:@"tab"];
                        }
                        else
                        {
                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Amount is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                        }
                    }
                    else
                    {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Enter last four digits of Acount no" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                }
                else
                {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Enter Instrument No." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Select Instrument date" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
         else  if ([typeofpayment.text isEqualToString:@"Cheque"])
         {
            NSMutableArray *checkquearr=[[NSMutableArray alloc]init];
             for (int i=0; i<noofcheque; i++) {
                 int   j=201;
                 NSMutableDictionary *chequedict=[[NSMutableDictionary alloc]init];
                 NSString *text = ((RPFloatingPlaceholderTextField*)[self.view viewWithTag:i*100+j]).text;
                 [chequedict setObject:text  forKey:@"instrument_no"];
                 j++;
                 if ([text isEqualToString:@""])
                 {
                     UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[NSString stringWithFormat:@"Instrument no is mandatory in cheque-%d",i+1] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alert show];
                     break;
                 }
                 NSString *text1 = ((RPFloatingPlaceholderTextField*)[self.view viewWithTag:i*100+j]).text;
                 [chequedict setObject:text1  forKey:@"instrument_date"];
                 j++;
                 if ([text1 isEqualToString:@""])
                 {
                     UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[NSString stringWithFormat:@"instrument date is mandatory in cheque-%d",i+1] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alert show];
                     break;
                 }
                 
                 NSString *tex2 = ((RPFloatingPlaceholderTextField*)[self.view viewWithTag:i*100+j]).text;
                 [chequedict setObject:tex2  forKey:@"bank_name"];
                 j++;
                 if ([tex2 isEqualToString:@""])
                 {
                     UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[NSString stringWithFormat:@"bank name is mandatory in cheque-%d",i+1] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alert show];
                     break;
                 }
                 
                 NSString *tex3 = ((RPFloatingPlaceholderTextField*)[self.view viewWithTag:i*100+j]).text;
                 [chequedict setObject:tex3  forKey:@"branch_name"];
                 j++;
                 if ([tex3 isEqualToString:@""])
                 {
                     UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[NSString stringWithFormat:@"Branch name is mandatory in cheque-%d",i+1] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alert show];
                     break;
                 }

                 NSString *tex4 = ((RPFloatingPlaceholderTextField*)[self.view viewWithTag:i*100+j]).text;
                 [chequedict setObject:tex4  forKey:@"amount"];
                 [checkquearr addObject:chequedict];
                 if ([tex4 isEqualToString:@""])
                 {
                     UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[NSString stringWithFormat:@"amount is mandatory in cheque-%d",i+1] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alert show];
                     break;
                 }
                 if (i==noofcheque-1) {
                     [self FinalsubmitBooking:@"tab"];
                 }
             }
         }
    }
//
}
-(void)FinalsubmitBooking:(NSString *)str
{
    NSMutableArray * imageDict=[[NSMutableArray alloc]init];
    for (int i=0; i<imagerarr.count; i++) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:[NSString stringWithFormat:@"%@_%@_ch%d",[_flatdetailsdict objectForKey:@"ip_proj_id"],_radiobtntxt,i+1]  forKey:@"name"];
        [dict setObject:[imagerarr objectAtIndex:i]  forKey:@"uploaded_file[]"];
        [imageDict addObject:dict];
    }
    
    if (bookingimage.image!=nil) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:[NSString stringWithFormat:@"%@_%@_bf",[_flatdetailsdict objectForKey:@"ip_proj_id"],_radiobtntxt]  forKey:@"name"];
        [dict setObject:bookingimage.image  forKey:@"uploaded_file[]"];
        [imageDict addObject:dict];
    }
    NSString * custtypestr=@"";
     NSString * salary_slip,*form_16,*bank_statement,*badge,*ipr,*employmentertificate,*proof_of_business,*shop_act,*investigation_report,*appointment_letter,*pd_assessment;
   {
        salary_slip=@"0";
        form_16=@"0";
        bank_statement=@"0";
        badge=@"0";
        ipr=@"0";
        employmentertificate=@"0";
        proof_of_business=@"0";
        shop_act=@"0";
        investigation_report=@"0";
        appointment_letter=@"0";
        pd_assessment=@"0";
    }
      if (Customertypetxt.text!=nil)
    {
        if ([Customertypetxt.text isEqualToString:@"Salary in bank"]) {
           custtypestr=@"SalaryBank";
            if (_checkbox1.selected)
                salary_slip=@"1";

            if (_checkbox2.selected) {
                form_16=@"1";
            }
            if (_checkbox3.selected) {
                bank_statement=@"1";
            }

            badge=@"0";
            if (_checkbox5.selected) {
                 ipr=@"1";
            }
            employmentertificate=@"0";
            proof_of_business=@"0";
            shop_act=@"0";
            investigation_report=@"0";
            if (_checkbox12.selected) {
                appointment_letter=@"1";
            }
            pd_assessment=@"0";
        }
        if ([Customertypetxt.text isEqualToString:@"Salary by  cash"]) {
           custtypestr=@"SalaryCash";
            if (_checkbox1.selected)
                salary_slip=@"1";

            form_16=@"0";
            if (_checkbox3.selected) {
                bank_statement=@"1";
            }
            badge=@"0";
            ipr=@"0";
            if (_checkbox6.selected) {
                employmentertificate=@"1";
            }
            proof_of_business=@"0";
            shop_act=@"0";
            if (_checkbox9.selected) {
                investigation_report=@"1";
            }
            appointment_letter=@"0";
            pd_assessment=@"0";
        }
        if ([Customertypetxt.text isEqualToString:@"Business transaction in bank"]) {
            custtypestr=@"BusinessBank";
            salary_slip=@"0";
            form_16=@"0";
            if (_checkbox3.selected) {
                bank_statement=@"1";
            }
            badge=@"0";
            if (_checkbox5.selected) {
                ipr=@"1";
            }
            employmentertificate=@"0";
            if (_checkbox7.selected) {
              proof_of_business=@"1";
            }
            if (_checkbox8.selected) {
                shop_act=@"1";
            }
            investigation_report=@"0";
            appointment_letter=@"0";
            pd_assessment=@"0";
        }
        if ([Customertypetxt.text isEqualToString:@"Business transaction in cash"]) {
            custtypestr=@"BusinessCash";
            salary_slip=@"0";
            form_16=@"0";
            bank_statement=@"0";
            if (_checkbox4.selected) {
                badge=@"1";
            }
            ipr=@"0";
            employmentertificate=@"0";
            if (_checkbox7.selected) {
                proof_of_business=@"1";
            }
            shop_act=@"0";
            investigation_report=@"0";
            appointment_letter=@"0";
            if (_checkbox10.selected) {
                pd_assessment=@"1";
            }
        }
    }
NSString * businesdecstr,*empdecdetailstr;
    if (businessdetailstxt.text!=nil) {
     if(businessdetailstxt.hidden==YES)
        {
            businesdecstr=@"";
            empdecdetailstr=@"";
        }
        else
        {
            if ([Customertypetxt.text isEqualToString:@"Salary by  cash"]) {
                empdecdetailstr=businessdetailstxt.text;
                businesdecstr=@"";
            }
            if ([Customertypetxt.text isEqualToString:@"Business transaction in cash"])
            {
                empdecdetailstr=@"";
                businesdecstr=businessdetailstxt.text;
            }
        }
    }
    else
    {
        businesdecstr=@"";
        empdecdetailstr=@"";
    }
        NSString *refstr=[NSString stringWithFormat:@"%@%@mob%@",[_flatdetailsdict objectForKey:@"ip_proj_id"],[_ipprojectdic objectForKey:@"name"],custmobnotxt.text];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *datestr = [formatter stringFromDate:[NSDate date]];

        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSMutableArray *checkquearr=[[NSMutableArray alloc]init];
        for (int i=0; i<noofcheque; i++) {
            int   j=201;
            NSMutableDictionary *chequedict=[[NSMutableDictionary alloc]init];
            NSString *text = ((RPFloatingPlaceholderTextField*)[self.view viewWithTag:i*100+j]).text;
            [chequedict setObject:text  forKey:@"instrument_no"];
            j++;

            NSString *text1 = ((RPFloatingPlaceholderTextField*)[self.view viewWithTag:i*100+j]).text;
            [chequedict setObject:text1  forKey:@"instrument_date"];
            j++;

            NSString *tex2 = ((RPFloatingPlaceholderTextField*)[self.view viewWithTag:i*100+j]).text;
            [chequedict setObject:tex2  forKey:@"bank_name"];
            j++;

            NSString *tex3 = ((RPFloatingPlaceholderTextField*)[self.view viewWithTag:i*100+j]).text;
            [chequedict setObject:tex3  forKey:@"branch_name"];
            j++;

            NSString *tex4 = ((RPFloatingPlaceholderTextField*)[self.view viewWithTag:i*100+j]).text;
            [chequedict setObject:tex4  forKey:@"amount"];
            [checkquearr addObject:chequedict];
        }
        NSMutableDictionary * data=[[NSMutableDictionary alloc]init];
        [data setObject:[prefs objectForKey:@"username"] forKey:@"username"];
        [data setObject:[prefs objectForKey:@"password"] forKey:@"password"];
        [data setObject:[prefs objectForKey:@"url"] forKey:@"url"];
    //   [data setObject:filesarr forKey:@"files[]"];

        NSMutableDictionary*  _submitdict=[[NSMutableDictionary alloc]init];

    [_submitdict setObject:custmobnotxt.text  forKey:@"mobile_no"];
        [_submitdict setObject:custnametxt.text  forKey:@"customer_name"];
        [_submitdict setObject:custemailtxt.text  forKey:@"email"];
        [_submitdict setObject:custaddrtxt.text  forKey:@"address"];
        [_submitdict setObject:sourcetxt.text  forKey:@"source"];
        [_submitdict setObject:descontvaluetxt.text  forKey:@"discount_value"];
        [_submitdict setObject:discountremarktxt.text  forKey:@"discount_remarks"];
        [_submitdict setObject:schemeidstr  forKey:@"scheme_id"];
        [_submitdict setObject:agrementvaluetxt.text  forKey:@"revised_agreement_value"];
        [_submitdict setObject:schemetxt.text  forKey:@"scheme_name"];
        [_submitdict setObject:@""  forKey:@"offers"];
        [_submitdict setObject:schemeidstr  forKey:@"scheme_id"];
        [_submitdict setObject:@"Booked"  forKey:@"booking_status"];
        [_submitdict setObject:@"" forKey:@"source_name"];
        [_submitdict setObject:@"" forKey:@"referral_customer_project"];
        [_submitdict setObject:@"" forKey:@"referral_customer_unit_no"];
        [_submitdict setObject:_projectidstr  forKey:@"project_id"];
        [_submitdict setObject:nametxt.text  forKey:@"project_name"];
        [_submitdict setObject:siteidstr forKey:@"building_id"];
        [_submitdict setObject:buildingtxt.text  forKey:@"building_name"];
        [_submitdict setObject:flooridstr  forKey:@"floor_id"];
        [_submitdict setObject:[_flatdetailsdict objectForKey:@"flat_no"] forKey:@"flat_no"];
        [_submitdict setObject:floorno  forKey:@"floor_number"];
        [_submitdict setObject:[_ipprojectdic objectForKey:@"id"]  forKey:@"unit_id"];
        [_submitdict setObject:[_ipprojectdic objectForKey:@"name"]  forKey:@"unit_number"];
        [_submitdict setObject:[_ipprojectdic objectForKey:@"premium"]  forKey:@"unit_type"];
        [_submitdict setObject:[_flatdetailsdict objectForKey:@"flat_type"]  forKey:@"flat_type"];
        [_submitdict setObject:[_flatdetailsdict objectForKey:@"carpet_area"]  forKey:@"carpet_area"];
        [_submitdict setObject:[_flatdetailsdict objectForKey:@"rera_ca"]  forKey:@"rera_ca"];
        [_submitdict setObject:[_flatdetailsdict objectForKey:@"rera_total"]  forKey:@"rera_total"];
        [_submitdict setObject:[_flatdetailsdict objectForKey:@"total_amount_cost"]  forKey:@"total_amount_cost"];
        [_submitdict setObject:[_flatdetailsdict objectForKey:@"ip_proj_id"]  forKey:@"ip_project_id"];
        [_submitdict setObject:typeofpayment.text  forKey:@"payment_type"];
        [_submitdict setObject:handedovertotext.text  forKey:@"cash_handed_over_to"];
        [_submitdict setObject:@""  forKey:@"bank_name"];
        [_submitdict setObject:@""  forKey:@"branch_name"];
        [_submitdict setObject:@""  forKey:@"transaction_id"];
        [_submitdict setObject:_instrumentdatetxt.text  forKey:@"instrument_date"];
        [_submitdict setObject:_instrumentno.text  forKey:@"instrument_no"];
        [_submitdict setObject:_lastfourdigitsofcardtxt.text  forKey:@"last_four_card_digits"];
        [_submitdict setObject:bankamountxt.text  forKey:@"booking_amount"];
        [_submitdict setObject:amounttxt.text  forKey:@"amount"];
        [_submitdict setObject:remainingtxt.text  forKey:@"remarks"];
        [_submitdict setObject: (cibiltext.text==nil) ? @"" : cibiltext.text  forKey:@"cibil_score"];
    [_submitdict setObject:salary_slip  forKey:@"salary_slip"];
    [_submitdict setObject:form_16  forKey:@"form_16"];
    [_submitdict setObject:bank_statement  forKey:@"bank_statement"];
    [_submitdict setObject:badge  forKey:@"badge"];
    [_submitdict setObject:ipr  forKey:@"ipr"];
    [_submitdict setObject:employmentertificate  forKey:@"employmentertificate"];
    [_submitdict setObject:employmentertificate  forKey:@"employmentertificate"];
    [_submitdict setObject:proof_of_business  forKey:@"proof_of_business"];
    [_submitdict setObject:investigation_report  forKey:@"investigation_report"];
    [_submitdict setObject:pd_assessment  forKey:@"appointment_letter"];
    [_submitdict setObject:shop_act  forKey:@"shop_act"];
    [_submitdict setObject:empdecdetailstr forKey:@"employer_details"];
    [_submitdict setObject: businesdecstr forKey:@"business_details"];
    [_submitdict setObject: (Customertypetxt.text==nil) ? @"" : custtypestr  forKey:@"customer_type"];
    [_submitdict setObject: bk_numstr forKey:@"ret_bknum"];

    if ([str isEqualToString:@"online"]) {
        [_submitdict setObject:datestr  forKey:@"instrument_date"];
        [_submitdict setObject:refstr  forKey:@"instrument_no"];
    }

        NSString * checkdetails;
        NSError *error;
        NSData *jsonData0 = [NSJSONSerialization dataWithJSONObject:checkquearr
                                                            options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                              error:&error];
        if (! jsonData0) {
        } else {
            checkdetails = [[NSString alloc] initWithData:jsonData0 encoding:NSUTF8StringEncoding];
           
        }
        [_submitdict setObject:checkdetails  forKey:@"cheques"];

        NSString * paymentdetailstr;
        NSData *jsonData1 = [NSJSONSerialization dataWithJSONObject:_pamentdetialsfinaldict
                                                            options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                              error:&error];
        if (! jsonData1) {
        } else {
            paymentdetailstr = [[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
          
        }

        [_submitdict setObject:paymentdetailstr  forKey:@"payment_schedule"];

        NSString *jsonString;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_submitdict
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        if (! jsonData) {
        } else {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

        }
        [data setObject:jsonString forKey:@"jsonParam"];

        [indicator startAnimating];
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@bookingoperationswithfiles.php?",[prefs objectForKey:@"Link"]];
//
//        [indicator startAnimating];
//
//        [manager POST:urlString parameters:data progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//            NSString *content = [[NSString alloc]  initWithBytes:[responseObject bytes]
//                                                          length:[responseObject length] encoding: NSUTF8StringEncoding];
//
//            NSLog(@"content %@",content);
//
//          //  NSLog(@"JSON: %@", userDict);
//            if ([[userDict objectForKey:@"Android"] isEqualToString:@"yes"]) {
//                MyBookingViewController *mainvc=[[MyBookingViewController alloc] initWithNibName:@"MyBookingViewController" bundle:nil];
//                [self.navigationController pushViewController:mainvc animated:YES];
//                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Booking done sucessfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//            }
//            else
//            {
//                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Booking faild" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//            }
//            [ indicator stopAnimating];
//
//        } failure:^(NSURLSessionTask *operation, NSError *error) {
//            NSLog(@"Error: %@", error);
//            [indicator stopAnimating];
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//            [indicator stopAnimating];
//        }];
    
    //nsurl
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@bookingoperationswithfiles.php",[prefs objectForKey:@"Link"]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] initWithURL:url] ;
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postbody = [NSMutableData data];
    NSString *postData = [self getHTTPBodyParamsFromDictionary:data boundary:boundary];
    [postbody appendData:[postData dataUsingEncoding:NSUTF8StringEncoding]];

    //    [imageDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    for(int i=0; i<imageDict.count; i++){
        NSString *key=[[[imageDict objectAtIndex:i] allKeys] objectAtIndex:1];
        NSString *name=[[imageDict objectAtIndex:i] objectForKey:@"name"];
        
        //        if ([key rangeOfString:@"pdf"].location != NSNotFound){
        //            [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        //            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.pdf\"\r\n",key,key] dataUsingEncoding:NSUTF8StringEncoding]];
        //            [postbody appendData:[@"Content-Type: application/pdf\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        //            [postbody appendData:[NSData dataWithData:[[imageDict objectAtIndex:i] valueForKey:key]]];
        //
        //        }else{
        [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //    NSLog(@"%@", [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filetype=\"image/jpeg\"; filename=\"%@\"\r\n", key,[NSString stringWithFormat:@"%@.jpg",name ]]);
        [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filetype=\"image/jpeg\"; filename=\"%@\"\r\n", key,[NSString stringWithFormat:@"%@.jpg",name ]] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        CGFloat compression = 0.9f;
        UIImage * image=[[imageDict objectAtIndex:i] valueForKey:key];
        
        NSData * imageData = UIImageJPEGRepresentation(image, 0.1);
        [postbody appendData:imageData];
        //}
    }
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postbody];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *returnData, NSError *error)
     {
         NSString * returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
         NSLog(@"Response in str = %@",returnString);
         NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:returnData options:0 error:nil];
         
                   //  NSLog(@"JSON: %@", userDict);
                     if ([[userDict objectForKey:@"Android"] isEqualToString:@"yes"]) {
                         MyBookingViewController *mainvc=[[MyBookingViewController alloc] initWithNibName:@"MyBookingViewController" bundle:nil];
                         dispatch_async(dispatch_get_main_queue(), ^{
                             UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Booking done sucessfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                             [alert show];
                             [self.navigationController pushViewController:mainvc animated:YES];
                             [ indicator stopAnimating];
                         });
                     }
                     else
                     {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Booking faild" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                             [ indicator stopAnimating];

                             [alert show];
                         });
                     }
  
     }];
}
-(NSString *) getHTTPBodyParamsFromDictionary: (NSDictionary* )params boundary:(NSString *)boundary
{
    NSMutableString *tempVal = [[NSMutableString alloc] init];
    for(NSString * key in params)
    {
        [tempVal appendFormat:@"\r\n--%@\r\n", boundary];
        [tempVal appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@",key,[params objectForKey:key]];
    }
    return [tempVal description];
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *rowItem;
    if (pickerView == sitenamepickerview)
    {
        rowItem = [sitenamearr objectAtIndex: row];
    }
    if (pickerView == projectpickerview)
    {
        rowItem = [projectnamearr objectAtIndex: row];
    }
    if (pickerView == schemepickerview)
    {
        rowItem = [schemearr objectAtIndex: row];
    }
    if (pickerView == typeofpaymentpicker)
    {
        rowItem = [Typeofpaymentarr objectAtIndex: row];
    }
    if (pickerView == customertypepicker)
    {
        rowItem = [customertypearr objectAtIndex: row];
    }
    if (pickerView == sourcepicker)
    {
        rowItem = [sourcearr objectAtIndex: row];
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
    if (pickerView ==sitenamepickerview                                         )
    {
        sitestr=[[NSString alloc]init];
        sitestr=[NSString stringWithFormat:@"%@",[sitenamearr objectAtIndex:[pickerView selectedRowInComponent:0]]];
 siteidstr=[NSString stringWithFormat:@"%@",[_siteidarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==projectpickerview                                         )
    {
        projectnamestr=[[NSString alloc]init];
        projectnamestr=[NSString stringWithFormat:@"%@",[projectnamearr objectAtIndex:[pickerView selectedRowInComponent:0]]];
        _projectidstr=[NSString stringWithFormat:@"%@",[_projectidarr objectAtIndex:[pickerView selectedRowInComponent:0]]];

    }
    if (pickerView ==schemepickerview                                         )
    {
        schemestr=[[NSString alloc]init];
        schemestr=[NSString stringWithFormat:@"%@",[schemearr objectAtIndex:[pickerView selectedRowInComponent:0]]];
        schemeidstr=[NSString stringWithFormat:@"%@",[_schemeidarr objectAtIndex:[pickerView selectedRowInComponent:0]]];

    }
    if (pickerView ==typeofpaymentpicker                                         )
    {
        typeofpaymentstr=[[NSString alloc]init];
        typeofpaymentstr=[NSString stringWithFormat:@"%@",[Typeofpaymentarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
        
    }
    if (pickerView ==customertypepicker                                         )
    {
        customertypestr=[[NSString alloc]init];
        customertypestr=[NSString stringWithFormat:@"%@",[customertypearr objectAtIndex:[pickerView selectedRowInComponent:0]]];
        
    }
    if (pickerView ==sourcepicker                                         )
    {
        sourcestr=[[NSString alloc]init];
        sourcestr=[NSString stringWithFormat:@"%@",[sourcearr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==countrpicker                                         )
    {
        countrstr=[[NSString alloc]init];
        countrstr=[NSString stringWithFormat:@"%@",[countryarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == sitenamepickerview)
    {
        return [sitenamearr objectAtIndex:row];
    }
    if (pickerView == projectpickerview)
    {
        return [projectnamearr objectAtIndex:row];
    }
    if (pickerView == schemepickerview)
    {
        return [schemearr objectAtIndex:row];
    }
    if (pickerView == typeofpaymentpicker)
    {
        return [Typeofpaymentarr objectAtIndex:row];
    }
    if (pickerView == customertypepicker)
    {
        return [customertypearr objectAtIndex:row];
    }
    if (pickerView == sourcepicker)
    {
        return [sourcearr objectAtIndex:row];
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

    sitenamepickerview.hidden=YES;
    sitenametoolbar.hidden=YES;
    projectnametoolbar.hidden=YES;
    projectpickerview.hidden=YES;
    schemepickerview.hidden=YES;
    schemetoolbar.hidden=YES;
    typeofpaymentpicker.hidden=YES;
    typeofpaymentoolbar.hidden=YES;
    customertypetoolbar.hidden=YES;
    customertypepicker.hidden=YES;
    [discountremarktxt resignFirstResponder];
    [descontvaluetxt resignFirstResponder];
    [bankamountxt resignFirstResponder];
    sourcepicker.hidden=YES;
    sourcetoolbar.hidden=YES;
    countrytoolbar.hidden=YES;
    countrpicker.hidden=YES;
    if (textField ==buildingtxt) {
        if (_buildingarr.count==0) {
            _buildingarr=nil;
            sitenamearr=nil;
            _siteidarr=nil;
        }
        else
        {
        sitenamearr=[[NSMutableArray alloc]init];
        _siteidarr=[[NSMutableArray alloc]init];
        for (int i=0; i<_buildingarr.count; i++) {
            NSDictionary* dict=[_buildingarr objectAtIndex:i];
            [sitenamearr addObject:[dict objectForKey:@"name"]];
            [_siteidarr addObject:[dict objectForKey:@"id"]];
        }
    }
        sitenamepickerview = [[UIPickerView alloc] init];
        [sitenamepickerview setDataSource: self];
        [sitenamepickerview setDelegate: self];
        sitenamepickerview.backgroundColor = [UIColor whiteColor];
        [sitenamepickerview setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        sitenamepickerview.showsSelectionIndicator = YES;
        [sitenamepickerview selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: sitenamepickerview];
        sitenamepickerview.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            sitenametoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            sitenametoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [sitenametoolbar setBarStyle:UIBarStyleBlackOpaque];
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
        
        sitenametoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:sitenametoolbar];
        
        sitenametoolbar.hidden=NO;
        [buildingtxt resignFirstResponder];
        return NO;
    }
    if (textField ==nametxt) {
        projectnamearr=[[NSMutableArray alloc]init];
        _projectidarr=[[NSMutableArray alloc]init];

        for (int i=0; i<projectarr.count; i++) {
            NSDictionary* dict=[projectarr objectAtIndex:i];
            [projectnamearr addObject:[dict objectForKey:@"name"]];
            [_projectidarr addObject:[dict objectForKey:@"id"]];
        }
        projectpickerview = [[UIPickerView alloc] init];
        [projectpickerview setDataSource: self];
        [projectpickerview setDelegate: self];
        projectpickerview.backgroundColor = [UIColor whiteColor];
        [projectpickerview setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        projectpickerview.showsSelectionIndicator = YES;
        [projectpickerview selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: projectpickerview];
        projectpickerview.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            projectnametoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            projectnametoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [projectnametoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed2)];
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
        
        projectnametoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:projectnametoolbar];
        
        projectnametoolbar.hidden=NO;
        [nametxt resignFirstResponder];
        return NO;
    }
    if (textField ==sourcetxt) {
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
        
        sourcetoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:sourcetoolbar];
        
        sourcetoolbar.hidden=NO;
        [sourcetxt resignFirstResponder];
        return NO;
    }
    if (textField ==schemetxt) {
        
        NSMutableArray * arr=[_flatdetailsdict objectForKey:@"schemes"];
        if (arr.count>0) {
            schemearr=[[NSMutableArray alloc]init];
            _schemeidarr=[[NSMutableArray alloc]init];
            for (int i=0; i<arr.count; i++) {
                NSDictionary* dict=[arr objectAtIndex:i];
                [schemearr addObject:[dict objectForKey:@"name"]];
                [_schemeidarr addObject:[dict objectForKey:@"id"]];
            }
        }
        else
        {
            schemearr=nil;
            _schemeidarr=nil;
        }
       
        schemepickerview = [[UIPickerView alloc] init];
        [schemepickerview setDataSource: self];
        [schemepickerview setDelegate: self];
        schemepickerview.backgroundColor = [UIColor whiteColor];
        [schemepickerview setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        schemepickerview.showsSelectionIndicator = YES;
        [schemepickerview selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: schemepickerview];
        schemepickerview.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            schemetoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            schemetoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [schemetoolbar setBarStyle:UIBarStyleBlackOpaque];
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
        
        schemetoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:schemetoolbar];
        schemetoolbar.hidden=NO;
        [schemetxt resignFirstResponder];
        return NO;
    }
    if (textField ==typeofpayment) {
        Typeofpaymentarr=[[NSMutableArray alloc]initWithObjects:@"Cheque",@"Cash",@"Card Swipe",@"Online", nil];
        typeofpaymentpicker = [[UIPickerView alloc] init];
        [typeofpaymentpicker setDataSource: self];
        [typeofpaymentpicker setDelegate: self];
        typeofpaymentpicker.backgroundColor = [UIColor whiteColor];
        [typeofpaymentpicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        typeofpaymentpicker.showsSelectionIndicator = YES;
        [typeofpaymentpicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: typeofpaymentpicker];
        typeofpaymentpicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            typeofpaymentoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            typeofpaymentoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [typeofpaymentoolbar setBarStyle:UIBarStyleBlackOpaque];
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
        
        typeofpaymentoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:typeofpaymentoolbar];
                typeofpaymentoolbar.hidden=NO;
        [typeofpayment resignFirstResponder];
        return NO;
    }
    if (textField ==Customertypetxt) {
        customertypearr=[[NSMutableArray alloc]initWithObjects:@"Salary in bank",@"Salary by  cash",@"Business transaction in bank",@"Business transaction in cash", nil];
        customertypepicker = [[UIPickerView alloc] init];
        [customertypepicker setDataSource: self];
        [customertypepicker setDelegate: self];
        customertypepicker.backgroundColor = [UIColor whiteColor];
        [customertypepicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        customertypepicker.showsSelectionIndicator = YES;
        [customertypepicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: customertypepicker];
        customertypepicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            customertypetoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            customertypetoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [customertypetoolbar setBarStyle:UIBarStyleBlackOpaque];
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
        
        customertypetoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:customertypetoolbar];
        customertypetoolbar.hidden=NO;
        [Customertypetxt resignFirstResponder];
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
    if ([pickerView isEqual: sitenamepickerview]) {
        return [sitenamearr count];
    }
    if ([pickerView isEqual: projectpickerview]) {
        return [projectnamearr count];
    }
    if ([pickerView isEqual: schemepickerview]) {
        return [schemearr count];
    }
    if ([pickerView isEqual: typeofpaymentpicker]) {
        return [Typeofpaymentarr count];
    }
    if ([pickerView isEqual: customertypepicker]) {
        return [customertypearr count];
    }
    if ([pickerView isEqual: customertypepicker]) {
        return [customertypearr count];
    }
    if ([pickerView isEqual: sourcepicker]) {
        return [sourcearr count];
    }
    if ([pickerView isEqual: countrpicker]) {
        return [countryarr count];
    }
    return 0;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(IBAction)doneBtnPressed1{
    sitenamepickerview.hidden=YES;
    sitenametoolbar.hidden=YES;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    if ([sitestr isEqualToString:@""] || sitestr==nil) {
        if (sitenamearr.count>0) {
            buildingtxt.text=[sitenamearr objectAtIndex:0];
             siteidstr=[_siteidarr objectAtIndex:0];
        }
    }
    else{
        buildingtxt.text=sitestr;
    }
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.headerReferenceSize = CGSizeZero;
        layout.footerReferenceSize = CGSizeZero;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;

    collectioonview=[[UICollectionView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.025, screenRect.size.height*0.21, screenRect.size.width*0.95,screenRect.size.height*0.60)
                                       collectionViewLayout:layout];
    [collectioonview setDataSource:self];
    [collectioonview setDelegate:self];
    collectioonview.scrollEnabled=YES;
    [collectioonview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    //  collectioonview.backgroundColor=[UIColor blackColor];
    collectioonview.backgroundColor=[UIColor whiteColor]  ;
    [collectioonview registerClass:[UICollectionReusableView class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [_view1 addSubview:collectioonview];
    [self getflowerunit:siteidstr];
}
-(IBAction)doneBtnPressed2{
    projectnametoolbar.hidden=YES;
    projectpickerview.hidden=YES;
    
    if ([projectnamestr isEqualToString:@""] || projectnamestr==nil) {
        if (projectnamearr.count>0) {
            nametxt.text=[projectnamearr objectAtIndex:0];
            _projectidstr=[_projectidarr objectAtIndex:0];
        }
    }
    else{
        nametxt.text=projectnamestr;
    }
    if ([comefromstr isEqualToString:@"booking"]) {
        _dict =[[NSMutableDictionary alloc]init];
        [_dict setObject: nametxt.text forKey:@"project_name"];
        [_dict setObject: _projectidstr forKey:@"project_id"];
        [self getbuilding];
    }
}
-(IBAction)doneBtnPressed3{
    schemepickerview.hidden=YES;
    schemetoolbar.hidden=YES;
    
    if ([schemestr isEqualToString:@""] || schemestr==nil) {
        if (projectnamearr.count>0) {
            schemetxt.text=[schemearr objectAtIndex:0];
            schemeidstr=[_schemeidarr objectAtIndex:0];
        }
    }
    else{
        schemetxt.text=schemestr;
    }
    NSMutableArray *schemearr=[_flatdetailsdict objectForKey:@"schemes"];
    for (int i=0; i<schemearr.count; i++) {
        NSDictionary *dict=[schemearr objectAtIndex:i];
        if ([schemestr isEqualToString:[dict objectForKey:@"name"]]) {
            _avaragevaluastr=[dict objectForKey:@"av"];
            totalagrlbl2.text=_avaragevaluastr;
            revisedagrttxt.text=_avaragevaluastr;
        }
        discountremarktxt.text=@"";
        descontvaluetxt.text=@"";

    }
}

-(IBAction)doneBtnPressed6{
    sourcetoolbar.hidden=YES;
    sourcepicker.hidden=YES;
    if ([sourcestr isEqualToString:@""] || sourcestr==nil) {
        if (sourcearr.count>0) {
            sourcetxt.text=[sourcearr objectAtIndex:0];
        }
    }
    else{
        sourcetxt.text=sourcestr;
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
-(IBAction)doneBtnPressed5{
    customertypetoolbar.hidden=YES;
    customertypepicker.hidden=YES;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if ([customertypestr isEqualToString:@""] || customertypestr==nil) {
        if (customertypearr.count>0) {
            Customertypetxt.text=[customertypearr objectAtIndex:0];
            customertypestr=[customertypearr objectAtIndex:0];
        }
    }
    else{
        Customertypetxt.text=customertypestr;
    }
    _checkbox1.selected=NO;
    _checkbox2.selected=NO;
    _checkbox3.selected=NO;
    _checkbox4.selected=NO;
    _checkbox5.selected=NO;
    _checkbox6.selected=NO;
    _checkbox7.selected=NO;
    _checkbox8.selected=NO;
    _checkbox9.selected=NO;
    _checkbox10.selected=NO;
    _checkbox11.selected=NO;
    _checkbox12.selected=NO;

    
    NSMutableArray *colors =[[NSMutableArray alloc]initWithObjects:[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor], nil];

    if ([customertypestr isEqualToString:@"Salary in bank"]) {
        _checkbox1.enabled=YES;
        _checkboxlbl1.textColor=[UIColor blackColor];
        [_checkbox1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _checkbox2.enabled=YES;
        _checkboxlbl2.textColor=[UIColor blackColor];
        [_checkbox2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _checkbox3.enabled=YES;
        _checkboxlbl3.textColor=[UIColor blackColor];
        [_checkbox3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        _checkbox4.enabled=NO;
        _checkboxlbl4.textColor=[UIColor lightGrayColor];
        [_checkbox4 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox5.enabled=YES;
        _checkboxlbl5.textColor=[UIColor blackColor];
        [_checkbox5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        _checkbox6.enabled=NO;
        _checkboxlbl6.textColor=[UIColor lightGrayColor];
        [_checkbox6 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox7.enabled=NO;
        _checkboxlbl7.textColor=[UIColor lightGrayColor];
        [_checkbox7 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox8.enabled=YES;
        _checkboxlbl8.textColor=[UIColor lightGrayColor];
        [_checkbox8 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox9.enabled=NO;
        _checkboxlbl9.textColor=[UIColor lightGrayColor];
        [_checkbox9 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox10.enabled=NO;
        _checkboxlbl10.textColor=[UIColor lightGrayColor];
        [_checkbox10 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox11.enabled=NO;
        _checkboxlbl11.textColor=[UIColor lightGrayColor];
        [_checkbox11 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox12.enabled=YES;
        [_checkbox12 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _checkboxlbl12.textColor=[UIColor blackColor];
        
        businessdetailstxt.hidden=YES;

    }
    if ([customertypestr isEqualToString:@"Salary by  cash"]) {
        _checkbox1.enabled=YES;
        [_checkbox1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _checkboxlbl1.textColor=[UIColor blackColor];
        
        _checkbox2.enabled=NO;
        [_checkbox2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _checkboxlbl2.textColor=[UIColor lightGrayColor];
        
        _checkbox3.enabled=YES;
        _checkboxlbl3.textColor=[UIColor blackColor];
        [_checkbox3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        _checkbox4.enabled=NO;
        _checkboxlbl4.textColor=[UIColor lightGrayColor];
        [_checkbox4 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox5.enabled=NO;
        _checkboxlbl5.textColor=[UIColor lightGrayColor];
        [_checkbox5 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox6.enabled=YES;
        _checkboxlbl6.textColor=[UIColor blackColor];
        [_checkbox6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        _checkbox7.enabled=NO;
        _checkboxlbl7.textColor=[UIColor lightGrayColor];
        [_checkbox7 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox8.enabled=NO;
        _checkboxlbl8.textColor=[UIColor lightGrayColor];
        [_checkbox8 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox9.enabled=YES;
        _checkboxlbl9.textColor=[UIColor blackColor];
        [_checkbox9 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        _checkbox10.enabled=NO;
        _checkboxlbl10.textColor=[UIColor lightGrayColor];
        [_checkbox10 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox11.enabled=NO;
        _checkboxlbl11.textColor=[UIColor lightGrayColor];
        [_checkbox11 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox12.enabled=NO;
        _checkboxlbl12.textColor=[UIColor lightGrayColor];
        [_checkbox12 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        businessdetailstxt.hidden=NO;
        businessdetailstxt.placeholder=@"Employer Detais";
        businessdetailstxt.text=@"";
    }
    if ([customertypestr isEqualToString:@"Business transaction in bank"]) {
        _checkbox1.enabled=NO;
        _checkboxlbl1.textColor=[UIColor lightGrayColor];
        [_checkbox1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox2.enabled=NO;
        _checkboxlbl2.textColor=[UIColor lightGrayColor];
        [_checkbox2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox3.enabled=YES;
        _checkboxlbl3.textColor=[UIColor blackColor];
        [_checkbox3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        _checkbox4.enabled=NO;
        _checkboxlbl4.textColor=[UIColor lightGrayColor];
        [_checkbox4 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox5.enabled=YES;
        _checkboxlbl5.textColor=[UIColor blackColor];
        [_checkbox5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        _checkbox6.enabled=NO;
        _checkboxlbl6.textColor=[UIColor lightGrayColor];
        [_checkbox6 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox7.enabled=YES;
        _checkboxlbl7.textColor=[UIColor blackColor];
        [_checkbox7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        _checkbox8.enabled=YES;
        _checkboxlbl8.textColor=[UIColor blackColor];
        [_checkbox8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        _checkbox9.enabled=NO;
        _checkboxlbl9.textColor=[UIColor lightGrayColor];
        [_checkbox9 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox10.enabled=NO;
        _checkboxlbl10.textColor=[UIColor lightGrayColor];
        [_checkbox10 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox11.enabled=NO;
        _checkboxlbl11.textColor=[UIColor lightGrayColor];
        [_checkbox11 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox12.enabled=NO;
        _checkboxlbl12.textColor=[UIColor lightGrayColor];
        [_checkbox12 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        businessdetailstxt.hidden=YES;
    }
    if ([customertypestr isEqualToString:@"Business transaction in cash"]) {
        _checkbox1.enabled=NO;
        _checkboxlbl1.textColor=[UIColor lightGrayColor];
        [_checkbox1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox2.enabled=NO;
        _checkboxlbl2.textColor=[UIColor lightGrayColor];
        [_checkbox2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox3.enabled=NO;
        _checkboxlbl3.textColor=[UIColor lightGrayColor];
        [_checkbox3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox4.enabled=YES;
        _checkboxlbl4.textColor=[UIColor blackColor];
        [_checkbox4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        _checkbox5.enabled=NO;
        _checkboxlbl5.textColor=[UIColor lightGrayColor];
        [_checkbox5 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox6.enabled=NO;
        _checkboxlbl6.textColor=[UIColor lightGrayColor];
        [_checkbox6 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox7.enabled=YES;
        _checkboxlbl7.textColor=[UIColor blackColor];
        [_checkbox7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        _checkbox8.enabled=NO;
        _checkboxlbl8.textColor=[UIColor lightGrayColor];
        [_checkbox8 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox9.enabled=NO;
        _checkboxlbl9.textColor=[UIColor lightGrayColor];
        [_checkbox9 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox10.enabled=YES;
        _checkboxlbl10.textColor=[UIColor blackColor];
        [_checkbox10 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        _checkbox11.enabled=NO;
        _checkboxlbl11.textColor=[UIColor lightGrayColor];
        [_checkbox11 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _checkbox12.enabled=NO;
        _checkboxlbl12.textColor=[UIColor lightGrayColor];
        [_checkbox12 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        businessdetailstxt.hidden=NO;
        businessdetailstxt.placeholder=@"Business Detais";
        businessdetailstxt.text=@"";
    }
}
-(void)selectcheckbox:(UIButton*)btn
{
    if (btn.selected) {
        btn.selected=NO;
    }
    else
        btn.selected=YES;
}
-(IBAction)doneBtnPressed4{
    typeofpaymentpicker.hidden=YES;
    typeofpaymentoolbar.hidden=YES;
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    if ([typeofpaymentstr isEqualToString:@""] || typeofpaymentstr==nil) {
        if (projectnamearr.count>0) {
            typeofpayment.text=[Typeofpaymentarr objectAtIndex:0];
        }
    }
    else{
        typeofpayment.text=typeofpaymentstr;
    }
    remainingtxt.text=@"";
    finalbookbtn.hidden=NO;
    
  if ([typeofpaymentstr isEqualToString:@"Cheque"]) {
      [checktableview removeFromSuperview];
      [handedovertotext removeFromSuperview];
      [amounttxt removeFromSuperview];
      addbtn.hidden=NO;
      captureimgbtn.hidden=NO;
      assignlbl.hidden=NO;
      [_instrumentdatetxt removeFromSuperview];
      [_instrumentno removeFromSuperview];
      [_lastfourdigitsofcardtxt removeFromSuperview];
      [paymentgateybtn removeFromSuperview];
      noofcheque=1;
      
      checktableview=[[UITableView alloc]init];
      handedovertotext=[[ACFloatingTextField alloc]init];
      amounttxt=[[ACFloatingTextField alloc]init];
      _instrumentdatetxt=[[ACFloatingTextField alloc]init];
      _instrumentno=[[ACFloatingTextField alloc]init];
      _lastfourdigitsofcardtxt=[[ACFloatingTextField alloc]init];
      handedovertotext=[[ACFloatingTextField alloc]init];

        checktableview = [[UITableView alloc] init];
    [checktableview setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.24,screenRect.size.width*0.90,screenRect.size.height*0.50)];
    checktableview.scrollEnabled=NO;
    checktableview.backgroundColor=[UIColor clearColor];
    checktableview.delegate = self;
    checktableview.dataSource = self;
    checktableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [view5scrollview addSubview:checktableview];
//
//    addbtn.frame=CGRectMake(screenRect.size.width*.10,screenRect.size.height*.73,screenRect.size.width*.80,screenRect.size.height*.07);
//    captureimgbtn.frame= CGRectMake(screenRect.size.width*.02,screenRect.size.height*.82,screenRect.size.width*.46,screenRect.size.height*.07);
//    capturebookingbtn.frame=CGRectMake(screenRect.size.width*.52,screenRect.size.height*.82,screenRect.size.width*.46,screenRect.size.height*.07);
//        chequeimage.frame=CGRectMake(screenRect.size.width*0.05,screenRect.size.height*.90, screenRect.size.width*0.40,screenRect.size.height*0.15);
//
//        bookingimage.frame=CGRectMake(screenRect.size.width*0.55,screenRect.size.height*.90, screenRect.size.width*0.40,screenRect.size.height*0.15);
//    rmarktxt.frame = CGRectMake(screenRect.size.width*0.05,screenRect.size.height*1.05,screenRect.size.width*0.90,screenRect.size.height*0.07);
//  remainingtxt.frame =CGRectMake(screenRect.size.width*0.05,screenRect.size.height*1.15,screenRect.size.width*0.90,screenRect.size.height*0.07);
//
//      view5scrollview.contentSize=CGSizeMake(screenRect.size.width,screenRect.size.height*1.30);
      addbtn.frame=CGRectMake(screenRect.size.width*0.05,noofcheque*screenRect.size.height*0.52+screenRect.size.height*0.25,screenRect.size.width*0.90,screenRect.size.height*0.05);
      captureimgbtn.frame=CGRectMake(screenRect.size.width*0.20,noofcheque*screenRect.size.height*0.52+screenRect.size.height*0.30,screenRect.size.width*0.60,screenRect.size.height*0.05);
      
      int hig=noofcheque*screenRect.size.height*0.52+screenRect.size.height*0.38;
      if (imagerarr.count>0) {
          chequeimagecollectionview.frame=CGRectMake(screenRect.size.width*0.14,hig,screenRect.size.width*0.76,screenRect.size.height*0.15);
          
          hig=hig+screenRect.size.height*0.17; capturebookingbtn.frame=CGRectMake(screenRect.size.width*0.20,hig,screenRect.size.width*0.6,screenRect.size.height*0.05);
          hig=hig+screenRect.size.height*0.08;
          
          if (bookingimage.image!=nil) { bookingimage.frame=CGRectMake(screenRect.size.width*0.30,hig,screenRect.size.width*0.40,screenRect.size.height*0.15);
              hig=hig+screenRect.size.height*0.17;
          }
      }
      else if(imagerarr.count==0)
      {
          capturebookingbtn.frame=CGRectMake(screenRect.size.width*0.20,hig,screenRect.size.width*0.60,screenRect.size.height*0.05);
          hig=hig+screenRect.size.height*0.08;
          
          if (bookingimage.image!=nil) { bookingimage.frame=CGRectMake(screenRect.size.width*0.30,hig,screenRect.size.width*0.40,screenRect.size.height*0.15);
              hig=hig+screenRect.size.height*0.17;
          }
      }
      
      rmarktxt.frame=CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
      
      hig=hig+screenRect.size.height*0.08; remainingtxt.frame=CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
      
      hig=hig+screenRect.size.height*0.08;
      view5scrollview.contentSize=CGSizeMake(screenRect.size.width,hig);
      
    }
    if ([typeofpaymentstr isEqualToString:@"Cash"]) {
        checktableview.hidden=YES;
        addbtn.hidden=YES;
        assignlbl.hidden=YES;
        [handedovertotext removeFromSuperview];
        [amounttxt removeFromSuperview];
        [_instrumentdatetxt removeFromSuperview];
        [_instrumentno removeFromSuperview];
        [_lastfourdigitsofcardtxt removeFromSuperview];
        [paymentgateybtn removeFromSuperview];
        handedovertotext=[[ACFloatingTextField alloc]init];
        chequeimage=nil;
        imagerarr=[[NSMutableArray alloc]init];
        [collectioonview reloadData];
        handedovertotext=[[ACFloatingTextField alloc]init];
        amounttxt=[[ACFloatingTextField alloc]init];
        _instrumentdatetxt=[[ACFloatingTextField alloc]init];
        _instrumentno=[[ACFloatingTextField alloc]init];
        _lastfourdigitsofcardtxt=[[ACFloatingTextField alloc]init];
        
   handedovertotext = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.25,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    handedovertotext.textAlignment=NSTextAlignmentLeft;
    handedovertotext.delegate = self;
    handedovertotext.textColor=[UIColor blackColor];
    handedovertotext.delegate=self;
    [handedovertotext setBackgroundColor:[UIColor clearColor]];
    handedovertotext.leftViewMode = UITextFieldViewModeAlways;
    [handedovertotext setKeyboardType:UIKeyboardTypeEmailAddress];
    handedovertotext.returnKeyType=UIReturnKeyDone;
    handedovertotext.selectedLineColor = [UIColor redColor];
    handedovertotext.selectedPlaceHolderColor = [UIColor redColor];
    handedovertotext.placeHolderColor = [UIColor grayColor];
    handedovertotext.placeholder=@"Hand over To*";
    handedovertotext.font = [UIFont systemFontOfSize:14];
    [view5scrollview addSubview:handedovertotext];
        
amounttxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.35,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    amounttxt.textAlignment=NSTextAlignmentLeft;
    amounttxt.delegate = self;
    amounttxt.textColor=[UIColor blackColor];
    amounttxt.delegate=self;
    [amounttxt setBackgroundColor:[UIColor clearColor]];
    amounttxt.leftViewMode = UITextFieldViewModeAlways;
    [amounttxt setKeyboardType:UIKeyboardTypeEmailAddress];
    amounttxt.returnKeyType=UIReturnKeyDone;
    amounttxt.selectedLineColor = [UIColor redColor];
    amounttxt.selectedPlaceHolderColor = [UIColor redColor];
    amounttxt.placeHolderColor = [UIColor grayColor];
    amounttxt.placeholder=@"Amount*";
        numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbarzip sizeToFit];
        amounttxt.inputAccessoryView = numberToolbarzip;
        amounttxt.leftViewMode = UITextFieldViewModeAlways;
        amounttxt.keyboardType = UIKeyboardTypeDecimalPad;
    amounttxt.font = [UIFont systemFontOfSize:14];
    [view5scrollview addSubview:amounttxt];
 captureimgbtn.frame=CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.45,screenRect.size.width*0.46,screenRect.size.height*0.07);
        captureimgbtn.hidden=YES;

capturebookingbtn.frame=CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.45,screenRect.size.width*0.60,screenRect.size.height*0.07);
        
        int hig=screenRect.size.height*0.55;
        if (bookingimage.image!=nil)
        {
      bookingimage.frame=CGRectMake(screenRect.size.width*0.30,hig, screenRect.size.width*0.40,screenRect.size.height*0.15);
            
            hig=hig+screenRect.size.height*0.17;
        }
    rmarktxt.frame =  CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
        hig=hig+screenRect.size.height*0.08;

  remainingtxt.frame = CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
        
        hig=hig+screenRect.size.height*0.10;
        view5scrollview.contentSize=CGSizeMake(screenRect.size.width,hig);
}
if ([typeofpaymentstr isEqualToString:@"Card Swipe"]) {
    checktableview.hidden=YES;
    addbtn.hidden=YES;
    assignlbl.hidden=YES;
    [handedovertotext removeFromSuperview];
    [amounttxt removeFromSuperview];
    [_instrumentdatetxt removeFromSuperview];
    [_instrumentno removeFromSuperview];
    [_lastfourdigitsofcardtxt removeFromSuperview];
    [paymentgateybtn removeFromSuperview];
    handedovertotext=[[ACFloatingTextField alloc]init];
    chequeimage=nil;
    imagerarr=[[NSMutableArray alloc]init];
    [collectioonview reloadData];

    
    handedovertotext=[[ACFloatingTextField alloc]init];
    amounttxt=[[ACFloatingTextField alloc]init];
    _instrumentdatetxt=[[ACFloatingTextField alloc]init];
    _instrumentno=[[ACFloatingTextField alloc]init];
    _lastfourdigitsofcardtxt=[[ACFloatingTextField alloc]init];

    _instrumentdatetxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.20,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    _instrumentdatetxt.textAlignment=NSTextAlignmentLeft;
    _instrumentdatetxt.delegate = self;
    _instrumentdatetxt.textColor=[UIColor blackColor];
    _instrumentdatetxt.delegate=self;
    [_instrumentdatetxt setBackgroundColor:[UIColor clearColor]];
    _instrumentdatetxt.leftViewMode = UITextFieldViewModeAlways;
    [_instrumentdatetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    _instrumentdatetxt.returnKeyType=UIReturnKeyDone;
    _instrumentdatetxt.selectedPlaceHolderColor = [UIColor redColor];
    _instrumentdatetxt.placeHolderColor = [UIColor grayColor];
    _instrumentdatetxt.placeholder=@"Instrument Date*";
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done"
                                                               style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad12:)]];
    [numberToolbarzip sizeToFit];
    _instrumentdatetxt.inputView =datePicker;
    _instrumentdatetxt.inputAccessoryView = numberToolbarzip;
    _instrumentdatetxt.font = [UIFont systemFontOfSize:14];
    [view5scrollview addSubview:_instrumentdatetxt];
    
    _instrumentno = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.30,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    _instrumentno.textAlignment=NSTextAlignmentLeft;
    _instrumentno.delegate = self;
    _instrumentno.textColor=[UIColor blackColor];
    _instrumentno.delegate=self;
    [_instrumentno setBackgroundColor:[UIColor clearColor]];
    _instrumentno.leftViewMode = UITextFieldViewModeAlways;
    [_instrumentno setKeyboardType:UIKeyboardTypeEmailAddress];
    _instrumentno.returnKeyType=UIReturnKeyDone;
    _instrumentno.selectedPlaceHolderColor = [UIColor redColor];
    _instrumentno.placeHolderColor = [UIColor grayColor];
    _instrumentno.placeholder=@"Instrument No.*";
    _instrumentno.font = [UIFont systemFontOfSize:14];
    [view5scrollview addSubview:_instrumentno];
    
    _lastfourdigitsofcardtxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.40,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    _lastfourdigitsofcardtxt.textAlignment=NSTextAlignmentLeft;
    _lastfourdigitsofcardtxt.delegate = self;
    _lastfourdigitsofcardtxt.textColor=[UIColor blackColor];
    _lastfourdigitsofcardtxt.delegate=self;
    [_lastfourdigitsofcardtxt setBackgroundColor:[UIColor clearColor]];
    _lastfourdigitsofcardtxt.leftViewMode = UITextFieldViewModeAlways;
    [_lastfourdigitsofcardtxt setKeyboardType:UIKeyboardTypeEmailAddress];
    _lastfourdigitsofcardtxt.returnKeyType=UIReturnKeyDone;
    _lastfourdigitsofcardtxt.selectedLineColor = [UIColor redColor];
    _lastfourdigitsofcardtxt.selectedPlaceHolderColor = [UIColor redColor];
    _lastfourdigitsofcardtxt.placeHolderColor = [UIColor grayColor];
    _lastfourdigitsofcardtxt.placeholder=@"Last four digits of Card No*";
    _lastfourdigitsofcardtxt.font = [UIFont systemFontOfSize:14];
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbarzip sizeToFit];
    _lastfourdigitsofcardtxt.inputAccessoryView = numberToolbarzip;
    _lastfourdigitsofcardtxt.leftViewMode = UITextFieldViewModeAlways;
    _lastfourdigitsofcardtxt.keyboardType = UIKeyboardTypeDecimalPad;
    [view5scrollview addSubview:_lastfourdigitsofcardtxt];

    captureimgbtn.hidden=YES;
    capturebookingbtn.frame=CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.50,screenRect.size.width*0.6,screenRect.size.height*0.07);

    int hig=screenRect.size.height*0.58;
    if (bookingimage.image!=nil)
    {
        bookingimage.frame=CGRectMake(screenRect.size.width*0.30,hig, screenRect.size.width*0.40,screenRect.size.height*0.15);
        
        hig=hig+screenRect.size.height*0.17;
    }
    amounttxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    amounttxt.textAlignment=NSTextAlignmentLeft;
    amounttxt.delegate = self;
    amounttxt.textColor=[UIColor blackColor];
    amounttxt.delegate=self;
    [amounttxt setBackgroundColor:[UIColor clearColor]];
    amounttxt.leftViewMode = UITextFieldViewModeAlways;
    [amounttxt setKeyboardType:UIKeyboardTypeEmailAddress];
    amounttxt.returnKeyType=UIReturnKeyDone;
    amounttxt.selectedLineColor = [UIColor redColor];
    amounttxt.selectedPlaceHolderColor = [UIColor redColor];
    amounttxt.placeHolderColor = [UIColor grayColor];
    amounttxt.placeholder=@"Amount*";
    amounttxt.font = [UIFont systemFontOfSize:14];
    [view5scrollview addSubview:amounttxt];
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbarzip sizeToFit];
    amounttxt.inputAccessoryView = numberToolbarzip;
    amounttxt.leftViewMode = UITextFieldViewModeAlways;
    amounttxt.keyboardType = UIKeyboardTypeDecimalPad;
    hig=hig+screenRect.size.height*0.08;

    rmarktxt.frame = CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
    hig=hig+screenRect.size.height*0.08;

    remainingtxt.frame =CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
    hig=hig+screenRect.size.height*0.08;


    view5scrollview.contentSize=CGSizeMake(screenRect.size.width,screenRect.size.height*1.07);
}
    if ([typeofpaymentstr isEqualToString:@"Online"]) {
        checktableview.hidden=YES;
        addbtn.hidden=YES;
        finalbookbtn.hidden=YES;
        assignlbl.hidden=YES;

        [handedovertotext removeFromSuperview];
        [amounttxt removeFromSuperview];
        [_instrumentdatetxt removeFromSuperview];
        [_instrumentno removeFromSuperview];
        [_lastfourdigitsofcardtxt removeFromSuperview];
        handedovertotext=[[ACFloatingTextField alloc]init];
        chequeimage=nil;
        imagerarr=[[NSMutableArray alloc]init];
        [collectioonview reloadData];
        
        _instrumentdatetxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.20,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        _instrumentdatetxt.textAlignment=NSTextAlignmentLeft;
        _instrumentdatetxt.delegate = self;
        _instrumentdatetxt.textColor=[UIColor blackColor];
        _instrumentdatetxt.delegate=self;
        [_instrumentdatetxt setBackgroundColor:[UIColor clearColor]];
        _instrumentdatetxt.leftViewMode = UITextFieldViewModeAlways;
        [_instrumentdatetxt setKeyboardType:UIKeyboardTypeEmailAddress];
        _instrumentdatetxt.returnKeyType=UIReturnKeyDone;
        _instrumentdatetxt.selectedPlaceHolderColor = [UIColor redColor];
        _instrumentdatetxt.placeHolderColor = [UIColor grayColor];
        _instrumentdatetxt.placeholder=@"Instrument Date*";
        _instrumentdatetxt.font = [UIFont systemFontOfSize:14];
     //   [view5scrollview addSubview:_instrumentdatetxt];
        
        _instrumentno = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.30,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        _instrumentno.textAlignment=NSTextAlignmentLeft;
        _instrumentno.delegate = self;
        _instrumentno.textColor=[UIColor blackColor];
        _instrumentno.delegate=self;
        [_instrumentno setBackgroundColor:[UIColor clearColor]];
        _instrumentno.leftViewMode = UITextFieldViewModeAlways;
        [_instrumentno setKeyboardType:UIKeyboardTypeEmailAddress];
        _instrumentno.returnKeyType=UIReturnKeyDone;
        _instrumentno.selectedPlaceHolderColor = [UIColor redColor];
        _instrumentno.placeHolderColor = [UIColor grayColor];
        _instrumentno.placeholder=@"Instrument No.*";
        _instrumentno.font = [UIFont systemFontOfSize:14];
     //   [view5scrollview addSubview:_instrumentno];
        
        _lastfourdigitsofcardtxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.20,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        _lastfourdigitsofcardtxt.textAlignment=NSTextAlignmentLeft;
        _lastfourdigitsofcardtxt.delegate = self;
        _lastfourdigitsofcardtxt.textColor=[UIColor blackColor];
        _lastfourdigitsofcardtxt.delegate=self;
        [_lastfourdigitsofcardtxt setBackgroundColor:[UIColor clearColor]];
        _lastfourdigitsofcardtxt.leftViewMode = UITextFieldViewModeAlways;
        [_lastfourdigitsofcardtxt setKeyboardType:UIKeyboardTypeEmailAddress];
        _lastfourdigitsofcardtxt.returnKeyType=UIReturnKeyDone;
        _lastfourdigitsofcardtxt.selectedLineColor = [UIColor redColor];
        _lastfourdigitsofcardtxt.selectedPlaceHolderColor = [UIColor redColor];
        _lastfourdigitsofcardtxt.placeHolderColor = [UIColor grayColor];
        _lastfourdigitsofcardtxt.placeholder=@"Last four digits of account no*";
        _lastfourdigitsofcardtxt.font = [UIFont systemFontOfSize:14];
        numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbarzip sizeToFit];
        _lastfourdigitsofcardtxt.inputAccessoryView = numberToolbarzip;
        _lastfourdigitsofcardtxt.leftViewMode = UITextFieldViewModeAlways;
        _lastfourdigitsofcardtxt.keyboardType = UIKeyboardTypeDecimalPad;
        [view5scrollview addSubview:_lastfourdigitsofcardtxt];
        captureimgbtn.frame=CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.50,screenRect.size.width*0.46,screenRect.size.height*0.07);
        captureimgbtn.hidden=YES;
        capturebookingbtn.frame=CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.30,screenRect.size.width*0.6,screenRect.size.height*0.07);
        
        int hig=screenRect.size.height*0.38;
        if (bookingimage.image!=nil)
        {
            bookingimage.frame=CGRectMake(screenRect.size.width*0.30,hig, screenRect.size.width*0.40,screenRect.size.height*0.15);
            
            hig=hig+screenRect.size.height*0.17;
        }
        amounttxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        amounttxt.textAlignment=NSTextAlignmentLeft;
        amounttxt.delegate = self;
        amounttxt.textColor=[UIColor blackColor];
        amounttxt.delegate=self;
        [amounttxt setBackgroundColor:[UIColor clearColor]];
        amounttxt.leftViewMode = UITextFieldViewModeAlways;
        [amounttxt setKeyboardType:UIKeyboardTypeEmailAddress];
        amounttxt.returnKeyType=UIReturnKeyDone;
        amounttxt.selectedLineColor = [UIColor redColor];
        amounttxt.selectedPlaceHolderColor = [UIColor redColor];
        amounttxt.placeHolderColor = [UIColor grayColor];
        amounttxt.placeholder=@"Amount*";
        amounttxt.font = [UIFont systemFontOfSize:14];
        [view5scrollview addSubview:amounttxt];
        numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbarzip sizeToFit];
        amounttxt.inputAccessoryView = numberToolbarzip;
        amounttxt.leftViewMode = UITextFieldViewModeAlways;
        amounttxt.keyboardType = UIKeyboardTypeDecimalPad;
        hig=hig+screenRect.size.height*0.08;

        rmarktxt.frame = CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
        hig=hig+screenRect.size.height*0.08;

        remainingtxt.frame =CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07);
        hig=hig+screenRect.size.height*0.10;

        paymentgateybtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,hig,screenRect.size.width*0.80,screenRect.size.height*0.07)];
        [paymentgateybtn setTitle:@"Proceed to online payment" forState:UIControlStateNormal];
        paymentgateybtn.font=[UIFont systemFontOfSize:14];
        [paymentgateybtn addTarget:self action:@selector(onlinepayment) forControlEvents:UIControlEventTouchUpInside];
        // [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
        paymentgateybtn.tag=4;
        [paymentgateybtn setBackgroundColor:[UIColor colorWithHexString:@"#F8F8F8"]];
        [paymentgateybtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [paymentgateybtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        paymentgateybtn.layer.borderColor = [UIColor grayColor].CGColor;
        paymentgateybtn.layer.borderWidth = 0.5;
        [view5scrollview addSubview:paymentgateybtn];
    
        hig=hig+screenRect.size.height*0.10;
        view5scrollview.contentSize=CGSizeMake(screenRect.size.width,hig);
        
}
  }
-(void)onlinepayment
{
    if (![_lastfourdigitsofcardtxt.text isEqualToString:@""]) {
        if (![amounttxt.text isEqualToString:@""]) {
            float price ,priceString;
            {
                priceString = [amounttxt.text floatValue];
                
                NSString *refstr=[NSString stringWithFormat:@"%@%@MOB%@",[_flatdetailsdict objectForKey:@"ip_proj_id"],[_ipprojectdic objectForKey:@"name"],custmobnotxt.text];
                
                price = (float)priceString * 1;
                //   price = 12.34;
                
                //Merchant has to configure the below code
                
                //  PaymentModeViewController *paymentView = [[PaymentModeViewController alloc]init];
//
//                PaymentModeViewController *paymentView=[[PaymentModeViewController alloc] initWithNibName:nil bundle:nil];
//                paymentView.ACC_ID = @"23429";       //Merchant has to configure the Account ID
//                paymentView.SECRET_KEY = @"7374316695fd7cc4f1e36aa3cee731f4";   //Merchant has to configure the Secret Key
//                paymentView.MODE = @"LIVE";     //Merchant has to configure the Mode either TEST or LIVE
//                paymentView.ALGORITHM = @"2";   //Merchant has to configure the Algorithm 0 for md5, 1 for sha1, 2 for sha512
//
//                paymentView.strSaleAmount=[NSString stringWithFormat:@"%.2f",price];
//                paymentView.reference_no=refstr; //Merchant has to change it dynamically
//
//                paymentView.descriptionString = @"Test Description";
//                paymentView.strCurrency =@"INR";
//                paymentView.strDisplayCurrency =@"USD";
//                paymentView.strDescription = @"Test Description";
//                paymentView.strBillingName = custnametxt.text;
//                paymentView.strBillingAddress =@"FC Rd. Pune";
//                paymentView.strBillingCity =@"Bill City";
//                paymentView.strBillingState = @"MH";
//                paymentView.strBillingPostal =@"625000";
//                paymentView.strBillingCountry = @"IND";
//                paymentView.strBillingEmail =custemailtxt.text;
//                paymentView.strBillingTelephone =custmobnotxt.text;
//
//                paymentView.strDeliveryName = @"";
//                paymentView.strDeliveryAddress = @"";
//                paymentView.strDeliveryCity = @"";
//                paymentView.strDeliveryState = @"";
//                paymentView.strDeliveryPostal =@"";
//                paymentView.strDeliveryCountry = @"";
//                paymentView.strDeliveryTelephone =@"";
//
//                //If you want to add any extra parameters dynamically you have to add the Key and value as we mentioned below
//                //[dynamicKeyValueDictionary setValue:@"savings" forKey:@"account_detail"];
//                //paymentView.dynamicKeyValueDictionary = dynamicKeyValueDictionary;
//                [self.navigationController pushViewController:paymentView animated:NO];
            }
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Amount is mandatory." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Enter last four digits of account no." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

}
-(void) triggerAction:(NSNotification *) notification
{
    [self FinalsubmitBooking:@"online"];
}
- (BOOL)validateEmailWithString
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:custemailtxt.text];
}

-(IBAction)cancelBtnpress{
    sitenamepickerview.hidden=YES;
    sitenametoolbar.hidden=YES;
    projectnametoolbar.hidden=YES;
    projectpickerview.hidden=YES;
    schemepickerview.hidden=YES;
    schemetoolbar.hidden=YES;
    typeofpaymentpicker.hidden=YES;
    typeofpaymentoolbar.hidden=YES;
    customertypetoolbar.hidden=YES;
    customertypepicker.hidden=YES;
    sourcepicker.hidden=YES;
    sourcetoolbar.hidden=YES;
    [datePicker removeFromSuperview];
    [numberToolbarzip removeFromSuperview];
    countrytoolbar.hidden=YES;
    countrpicker.hidden=YES;
}
-(void)checkleads
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *jsonDict=[[NSMutableDictionary alloc]init];
    [jsonDict setObject:@"25"forKey:@"ID"];
    NSMutableDictionary * data=[[NSMutableDictionary alloc]init];
    [data setObject:custmobnotxt.text forKey:@"phone_mobile"];
    
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
//        NSArray* words = [jsonString componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//        jsonString = [words componentsJoinedByString:@""];
//        jsonString=[jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
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

                custnametxt.text=[NSString stringWithFormat:@"%@ %@",[datadict objectForKey:@"first_name"],[datadict objectForKey:@"last_name"]];
                    sourcetxt.text= [datadict objectForKey:@"lead_source"] ;
                    custemailtxt.text=[datadict objectForKey:@"email_address"];
                    custaddrtxt.text=[datadict objectForKey:@"address"];
                }
                [indicator stopAnimating];
            }
        }
    }];
}
-(void)backbtn{
    if (count==5)
    {
        step1btn.selected=NO;
        step2btn.selected=NO;
        step3btn.selected=NO;
        step4btn.selected=YES;
        step5btn.selected=NO;
        
        _bottmborder1.hidden=YES;
        _bottmborder2.hidden=YES;
        _bottmborder3.hidden=YES;
        _bottmborder4.hidden=NO;
        _bottmborder5.hidden=YES;
        
        _view1.hidden=YES;
        _view2.hidden=YES;
        _view3.hidden=YES;
        _view4.hidden=NO;
        _view5.hidden=YES;
    }
   else if (count==4)
    {
        step1btn.selected=NO;
        step2btn.selected=NO;
        step3btn.selected=YES;
        step4btn.selected=NO;
        step5btn.selected=NO;
        
        _bottmborder1.hidden=YES;
        _bottmborder2.hidden=YES;
        _bottmborder3.hidden=NO;
        _bottmborder4.hidden=YES;
        _bottmborder5.hidden=YES;
        
        _view1.hidden=YES;
        _view2.hidden=YES;
        _view3.hidden=NO;
        _view4.hidden=YES;
        _view5.hidden=YES;
            }
    else if (count==3)
    {
        step1btn.selected=NO;
        step2btn.selected=YES;
        step3btn.selected=NO;
        step4btn.selected=NO;
        step5btn.selected=NO;
        
        _bottmborder1.hidden=YES;
        _bottmborder2.hidden=NO;
        _bottmborder3.hidden=YES;
        _bottmborder4.hidden=YES;
        _bottmborder5.hidden=YES;
        
        _view1.hidden=YES;
        _view2.hidden=NO;
        _view3.hidden=YES;
        _view4.hidden=YES;
        _view5.hidden=YES;
    }
    else if (count==2)
    {
        unitlbl.text=@"";

        schemetxt.text=@"";
        step1btn.selected=YES;
        step2btn.selected=NO;
        step3btn.selected=NO;
        step4btn.selected=NO;
        step5btn.selected=NO;
        
        _bottmborder1.hidden=NO;
        _bottmborder2.hidden=YES;
        _bottmborder3.hidden=YES;
        _bottmborder4.hidden=YES;
        _bottmborder5.hidden=YES;
        
        _view1.hidden=NO;
        _view2.hidden=YES;
        _view3.hidden=YES;
        _view4.hidden=YES;
        _view5.hidden=YES;
    }
    else if (count==1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    count--;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(RPFloatingPlaceholderTextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    //Keyboard becomes visible
        view5scrollview.frame = CGRectMake(view5scrollview.frame.origin.x,
                                      view5scrollview.frame.origin.y,
                                      view5scrollview.frame.size.width,
                                      view5scrollview.frame.size.height - 250 );
    if (textField==custaddrtxt) {
        [self animateTextField:textField up:YES]  ;

    }
    chequetag=textField.tag ;
    if ([textField.fieldIdentifier isEqualToString:@"chequeamount"]) {
        chequeamounttag=textField.tag;
    }
}
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    //keyboard will hide
        view5scrollview.frame = CGRectMake(view5scrollview.frame.origin.x,
                                      view5scrollview.frame.origin.y,
                                      view5scrollview.frame.size.width,
                                      view5scrollview.frame.size.height + 250 );
    if (textField==custaddrtxt) {
        [self animateTextField:textField up:NO] ;
    }
  
    if (textField==descontvaluetxt) {
        approvebtn.enabled=YES;

        NSLocale *locale = [NSLocale currentLocale];
        NSString *thousandSeparator = [locale objectForKey:NSLocaleGroupingSeparator];
        NSString *result = [_avaragevaluastr stringByReplacingOccurrencesOfString:thousandSeparator withString:@""];
     NSString * calculatedstr=[NSString stringWithFormat:@"%0.02f",[result floatValue]-[descontvaluetxt.text floatValue]];
        float num=[calculatedstr floatValue];
        float  pervalue=[result floatValue]*[[_flatdetailsdict objectForKey:@"discount_percentage"]floatValue]/100;
        if (pervalue<[descontvaluetxt.text floatValue]) {
           
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
            [params setObject:[prefs objectForKey:@"user_name"]  forKey:@"user_name"];
            [params setObject:nametxt.text  forKey:@"proj_name"];
            [params setObject:_radiobtntxt  forKey:@"unit_no"];
            [params setObject:descontvaluetxt.text forKey:@"discount_amt"];
            
            NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getdiscountcheck.php?",[prefs objectForKey:@"Link"]];
            
            [indicator startAnimating];
            [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                NSString *content = [[NSString alloc]  initWithBytes:[responseObject bytes] length:[responseObject length] encoding: NSUTF8StringEncoding];
                NSLog(@"content %@",content);
                //NSLog(@"JSON: %@", userDict);
                
                int status=[[userDict objectForKey:@"status"]intValue];
                if (status==0) {
                    approvebtn.enabled=NO;
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userDict objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    revisedagrttxt.text= totalagrlbl2.text;
                    descontvaluetxt.text=@"";
                    //
                }
                
                [indicator stopAnimating];
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                [indicator stopAnimating];
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }];

        }
        else
        {
            approvebtn.enabled=YES;
        NSNumberFormatter *formatter = [NSNumberFormatter new];
        [formatter setPositiveFormat:@"##,##,###"];
        formatter.maximumFractionDigits = 02;
         revisedagrttxt.text=[NSString stringWithFormat:@"%@",[formatter stringFromNumber:[NSNumber numberWithFloat:num]]];
        revisedagrttxt.text=[NSString stringWithFormat:@"%@",[formatter stringFromNumber:[NSNumber numberWithFloat:num]]];
        }
        
    }
    if (textField==amounttxt) {
        NSLocale *locale = [NSLocale currentLocale];
        NSString *thousandSeparator = [locale objectForKey:NSLocaleGroupingSeparator];
        NSString *result = [bankamountxt.text stringByReplacingOccurrencesOfString:thousandSeparator withString:@""];
        NSString * calculatedstr=[NSString stringWithFormat:@"%0.02f",[result floatValue]-[amounttxt.text floatValue]];
        float num=[calculatedstr floatValue];
       
        NSNumberFormatter *formatter = [NSNumberFormatter new];
        [formatter setPositiveFormat:@"##,##,###"];
        formatter.maximumFractionDigits = 02;
        remainingtxt.text=[NSString stringWithFormat:@"%@",[formatter stringFromNumber:[NSNumber numberWithFloat:num]]];
        
        float remainingamt=[result floatValue]-[amounttxt.text floatValue];
        if (remainingamt<0) {
            remainingtxt.text=@"0.00";
        }
    }
    if (textField==custmobnotxt) {
        [self checkleads];
    }
    if (textField==(RPFloatingPlaceholderTextField *)[self.view viewWithTag:chequeamounttag] ) {
        NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
        for (int i=0; i<_chequeamountarr.count; i++) {
            NSMutableDictionary * dict=[_chequeamountarr objectAtIndex:i];
            if ([[dict objectForKey:@"id"] isEqualToString:[NSString stringWithFormat:@"%i",chequeamounttag]]) {
                [_chequeamountarr removeObject:dict];
            }
        }
        [dict setObject:((UITextField*)[self.view viewWithTag:chequeamounttag]).text forKey:@"value"];
        [dict setObject: [NSString stringWithFormat:@"%i",chequeamounttag] forKey:@"id"];
        [_chequeamountarr addObject:dict];
        NSLog(@"%@",_chequeamountarr);
        float remaingamt=0.00;
        for (int i=0; i<_chequeamountarr.count; i++) {
            NSMutableDictionary * dict=[_chequeamountarr objectAtIndex:i];
            remaingamt=remaingamt+[[dict objectForKey:@"value"]floatValue];
        }
        NSLocale *locale = [NSLocale currentLocale];
        NSString *thousandSeparator = [locale objectForKey:NSLocaleGroupingSeparator];
        NSString *result = [bankamountxt.text stringByReplacingOccurrencesOfString:thousandSeparator withString:@""];
        float remainingamt=[result floatValue]-remaingamt;
        if (remainingamt<0) {
            remainingtxt.text=@"0.00";
        }
        else
        remainingtxt.text=[NSString stringWithFormat:@"%.02f",remainingamt];
    }
}
-(void)animateTextField:(RPFloatingPlaceholderTextField*)textField up:(BOOL)up
{
     const int movementDistance = -100; // tweak as needed
        const float movementDuration = -110; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==custmobnotxt)
    {
        if(textField.text.length >9 && range.length == 0)
        {
            return NO;
        }
    }
    return YES;
}
- (IBAction)showError:(id)sender {
    [remainingtxt showErrorWithText:@"this is error"];
}
- (IBAction)hideError:(id)sender {
    [remainingtxt hideError];
}
- (IBAction)changeLineColor:(id)sender {
    remainingtxt.lineColor = [UIColor yellowColor];
}
- (IBAction)changePlaceHolderColor:(id)sender {
    _textFieldUserName.placeHolderColor = [UIColor yellowColor];
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
