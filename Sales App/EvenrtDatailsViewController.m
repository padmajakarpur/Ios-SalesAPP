//
//  EvenrtDatailsViewController.m
//  Sales App
//
//  Created by Infinitum on 19/06/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "EvenrtDatailsViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
@interface EvenrtDatailsViewController ()

@end
@implementation EvenrtDatailsViewController
@synthesize dict,scrollview,bgview,demoView,unitnotxt,mobiletxt,emailtxt,nametxt,indicator,numberToolbarzip,projecttxt,downPicker,appDelegate,projectarr,nopartxt,alternatetxt;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    appDelegate=[[UIApplication sharedApplication] delegate];
    _projectidstr=[[NSString alloc]init];
    
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE314" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:horizontallbl];
    horizontallbl.text=@"Events Details";
    
    CGRect scrollViewFrame = CGRectMake(screenRect.size.width*.00,screenRect.size.height*0.10, screenRect.size.width,screenRect.size.height*0.90);
    scrollview = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
    scrollview.delegate = self;
    [self.view addSubview:scrollview];
    scrollview.backgroundColor=[UIColor clearColor];
    
    int hig=screenRect.size.height*0.05;
    UIFont *text1Font1 = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
    UIFont *text2Font2 = [UIFont fontWithName:@"OpenSans-Light" size:16];
    
    UILabel* eventcodelbl = [[UILabel alloc] init];
    [eventcodelbl setFrame:CGRectMake(screenRect.size.width*.10,hig, screenRect.size.width*.80,screenRect.size.height*0.04)];
    eventcodelbl.textAlignment = NSTextAlignmentLeft;
    eventcodelbl.backgroundColor=[UIColor clearColor];
    [eventcodelbl setTextColor: [UIColor blackColor]];
    eventcodelbl.font=[UIFont fontWithName:@"Open Sans" size:16.0f];
    [scrollview addSubview:eventcodelbl];
    NSString* positionstr09=@"Event Code: ";
    NSString* positionstr010=[NSString stringWithFormat:@"%@",[dict objectForKey:@"Event_code"]];
    NSMutableAttributedString *attributedString09 =
    [[NSMutableAttributedString alloc] initWithString:positionstr09 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSMutableAttributedString *attributedString010 =
    [[NSMutableAttributedString alloc] initWithString:positionstr010 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
    [attributedString09 appendAttributedString:attributedString010];
    eventcodelbl.attributedText = attributedString09;
    eventcodelbl.lineBreakMode = NSLineBreakByWordWrapping;
    eventcodelbl.numberOfLines = 0;
    
    hig=hig+screenRect.size.height*0.05;
    

    UILabel* typeclasslbl = [[UILabel alloc] init];
    [typeclasslbl setFrame:CGRectMake(screenRect.size.width*.10,hig, screenRect.size.width*.80,screenRect.size.height*0.04)];
    typeclasslbl.textAlignment = NSTextAlignmentLeft;
    typeclasslbl.backgroundColor=[UIColor clearColor];
    [typeclasslbl setTextColor: [UIColor blackColor]];
    typeclasslbl.font=[UIFont fontWithName:@"Open Sans" size:16.0f];
    [scrollview addSubview:typeclasslbl];
    NSString* positionstr9=@"Event Name: ";
    NSString* positionstr10=[NSString stringWithFormat:@"%@ ",[dict objectForKey:@"Event_name"]];
    NSMutableAttributedString *attributedString9 =
    [[NSMutableAttributedString alloc] initWithString:positionstr9 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSMutableAttributedString *attributedString10 =
    [[NSMutableAttributedString alloc] initWithString:positionstr10 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
    [attributedString9 appendAttributedString:attributedString10];
    typeclasslbl.attributedText = attributedString9;
    typeclasslbl.lineBreakMode = NSLineBreakByWordWrapping;
    typeclasslbl.numberOfLines = 0;
    
    hig=hig+screenRect.size.height*0.05;

    UILabel* eventdatelbl = [[UILabel alloc] init];
    [eventdatelbl setFrame:CGRectMake(screenRect.size.width*.10,hig, screenRect.size.width*.80,screenRect.size.height*0.04)];
    eventdatelbl.textAlignment = NSTextAlignmentLeft;
    eventdatelbl.backgroundColor=[UIColor clearColor];
    [eventdatelbl setTextColor: [UIColor blackColor]];
    eventdatelbl.font=[UIFont fontWithName:@"Open Sans" size:16.0f];
    [scrollview addSubview:eventdatelbl];
    NSString* positionstr7=@"Event Date: ";
    NSString* positionstr8=[NSString stringWithFormat:@"%@ ",[dict objectForKey:@"event_date"]];
    NSMutableAttributedString *attributedString7 =
    [[NSMutableAttributedString alloc] initWithString:positionstr7 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSMutableAttributedString *attributedString8 =
    [[NSMutableAttributedString alloc] initWithString:positionstr8 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
    [attributedString7 appendAttributedString:attributedString8];
    eventdatelbl.attributedText = attributedString7;
    eventdatelbl.lineBreakMode = NSLineBreakByWordWrapping;
    eventdatelbl.numberOfLines = 0;
    
    hig=hig+screenRect.size.height*0.05;

    UILabel* eventdurarionlbl = [[UILabel alloc] init];
    [eventdurarionlbl setFrame:CGRectMake(screenRect.size.width*.10,hig, screenRect.size.width*.90,screenRect.size.height*0.04)];
    eventdurarionlbl.textAlignment = NSTextAlignmentLeft;
    eventdurarionlbl.backgroundColor=[UIColor clearColor];
    [eventdurarionlbl setTextColor: [UIColor blackColor]];
    eventdurarionlbl.font=[UIFont fontWithName:@"Open Sans" size:16.0f];
    [scrollview addSubview:eventdurarionlbl];
    NSString* positionstr5=@"Event Duration: ";
    NSString* positionstr6=[NSString stringWithFormat:@"%@ ",[dict objectForKey:@"event_duration"]];
    NSMutableAttributedString *attributedString5 =
    [[NSMutableAttributedString alloc] initWithString:positionstr5 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSMutableAttributedString *attributedString6 =
    [[NSMutableAttributedString alloc] initWithString:positionstr6 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
    [attributedString5 appendAttributedString:attributedString6];
    eventdurarionlbl.attributedText = attributedString5;
    eventdurarionlbl.lineBreakMode = NSLineBreakByWordWrapping;
    eventdurarionlbl.numberOfLines = 0;

    hig=hig+screenRect.size.height*0.05;

    UILabel* slotslbl = [[UILabel alloc] init];
    [slotslbl setFrame:CGRectMake(screenRect.size.width*.10,hig, screenRect.size.width*.80,screenRect.size.height*0.04)];
    slotslbl.textAlignment = NSTextAlignmentLeft;
    slotslbl.backgroundColor=[UIColor clearColor];
    [slotslbl setTextColor: [UIColor blackColor]];
    slotslbl.font=[UIFont fontWithName:@"Open Sans" size:16.0f];
    [scrollview addSubview:slotslbl];
    NSString* positionstr3=@"Slots: ";
    NSString* positionstr4=[NSString stringWithFormat:@"%@(%@ avaible) ",[dict objectForKey:@"event_noofslots"],[dict objectForKey:@"event_avalibleslots"]];
    NSMutableAttributedString *attributedString3 =
    [[NSMutableAttributedString alloc] initWithString:positionstr3 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSMutableAttributedString *attributedString4 =
    [[NSMutableAttributedString alloc] initWithString:positionstr4 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
    [attributedString3 appendAttributedString:attributedString4];
    slotslbl.attributedText = attributedString3;
    slotslbl.lineBreakMode = NSLineBreakByWordWrapping;
    slotslbl.numberOfLines = 0;

    hig=hig+screenRect.size.height*0.05;


    UILabel* aboutmelbl = [[UILabel alloc] init];
      [aboutmelbl setFrame:CGRectMake(screenRect.size.width*.10,hig, screenRect.size.width*.80,screenRect.size.height*0.10)];
    aboutmelbl.textAlignment = NSTextAlignmentLeft;
    aboutmelbl.backgroundColor=[UIColor clearColor];
    [aboutmelbl setTextColor: [UIColor blackColor]];
    [scrollview addSubview:aboutmelbl];
    NSString* positionstr1=@"Event Details: ";
    NSString* positionstr2=[dict objectForKey:@"event_detevnt"];
    NSMutableAttributedString *attributedString1 =
    [[NSMutableAttributedString alloc] initWithString:positionstr1 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSMutableAttributedString *attributedString2 =
    [[NSMutableAttributedString alloc] initWithString:positionstr2 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
    [attributedString1 appendAttributedString:attributedString2];
    aboutmelbl.attributedText = attributedString1;
    aboutmelbl.lineBreakMode = NSLineBreakByWordWrapping;
    aboutmelbl.numberOfLines = 0;
    [aboutmelbl setFrame:CGRectMake(screenRect.size.width*.10,hig, screenRect.size.width*.78,aboutmelbl.frame.size.height)];
    [aboutmelbl sizeToFit];

    hig=hig+ aboutmelbl.frame.size.height+screenRect.size.height*0.01;

    UILabel* locationlbl = [[UILabel alloc] init];
    [locationlbl setFrame:CGRectMake(screenRect.size.width*.10,hig, screenRect.size.width*.80,screenRect.size.height*0.04)];
    locationlbl.textAlignment = NSTextAlignmentLeft;
    locationlbl.backgroundColor=[UIColor clearColor];
    [locationlbl setTextColor: [UIColor blackColor]];
    locationlbl.font=[UIFont fontWithName:@"Open Sans" size:16.0f];
    [scrollview addSubview:locationlbl];
    NSString* positionstr11=@"Location: ";
    NSString* positionstr12=[dict objectForKey:@"event_location"];
    NSMutableAttributedString *attributedString11 =
    [[NSMutableAttributedString alloc] initWithString:positionstr11 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSMutableAttributedString *attributedString12 =
    [[NSMutableAttributedString alloc] initWithString:positionstr12 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
    [attributedString11 appendAttributedString:attributedString12];
    locationlbl.attributedText = attributedString11;
    locationlbl.lineBreakMode = NSLineBreakByWordWrapping;
    locationlbl.numberOfLines = 0;

    hig=hig+screenRect.size.height*0.05;

    UILabel* timing = [[UILabel alloc] init];
    [timing setFrame:CGRectMake(screenRect.size.width*.10,hig, screenRect.size.width*.80,screenRect.size.height*0.04)];
    timing.textAlignment = NSTextAlignmentLeft;
    timing.backgroundColor=[UIColor clearColor];
    [timing setTextColor: [UIColor blackColor]];
    timing.font=[UIFont fontWithName:@"Open Sans" size:16.0f];
    [scrollview addSubview:timing];
    NSString* positionstr13=@"From Time: ";
    NSString* positionstr14=[NSString stringWithFormat:@"%@",[dict objectForKey:@"event_ftime"]];
    NSMutableAttributedString *attributedString13 =
    [[NSMutableAttributedString alloc] initWithString:positionstr13 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSMutableAttributedString *attributedString14 =
    [[NSMutableAttributedString alloc] initWithString:positionstr14 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
    [attributedString13 appendAttributedString:attributedString14];
    timing.attributedText = attributedString13;
    timing.lineBreakMode = NSLineBreakByWordWrapping;
    timing.numberOfLines = 0;

    hig=hig+screenRect.size.height*0.05;
    
    UILabel* timing2 = [[UILabel alloc] init];
    [timing2 setFrame:CGRectMake(screenRect.size.width*.10,hig, screenRect.size.width*.80,screenRect.size.height*0.04)];
    timing2.textAlignment = NSTextAlignmentLeft;
    timing2.backgroundColor=[UIColor clearColor];
    [timing2 setTextColor: [UIColor blackColor]];
    timing2.font=[UIFont fontWithName:@"Open Sans" size:16.0f];
    [scrollview addSubview:timing2];
    NSString* positionstr15=@"To Time: ";
    NSString* positionstr16=[NSString stringWithFormat:@"%@",[dict objectForKey:@"event_ttime"]];
    NSMutableAttributedString *attributedString15 =
    [[NSMutableAttributedString alloc] initWithString:positionstr15 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSMutableAttributedString *attributedString16 =
    [[NSMutableAttributedString alloc] initWithString:positionstr16 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
    [attributedString15 appendAttributedString:attributedString16];
    timing2.attributedText = attributedString15;
    timing2.lineBreakMode = NSLineBreakByWordWrapping;
    timing2.numberOfLines = 0;
    
//    hig=hig+screenRect.size.height*0.04;
//
//    UILabel* statuslbl = [[UILabel alloc] init];
//    [statuslbl setFrame:CGRectMake(screenRect.size.width*.05,hig, screenRect.size.width*.90,screenRect.size.height*0.04)];
//    statuslbl.textAlignment = NSTextAlignmentLeft;
//    statuslbl.backgroundColor=[UIColor clearColor];
//    [statuslbl setTextColor: [UIColor blackColor]];
//    statuslbl.font=[UIFont fontWithName:@"Open Sans" size:16.0f];
//    [scrollview addSubview:statuslbl];
//    NSString* positionstr15=@"Status:-";
//    NSString* positionstr16=[dict objectForKey:@"event_status"];
//    NSMutableAttributedString *attributedString15 =
//    [[NSMutableAttributedString alloc] initWithString:positionstr15 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
//    NSMutableAttributedString *attributedString16 =
//    [[NSMutableAttributedString alloc] initWithString:positionstr16 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor grayColor]}];
//    [attributedString15 appendAttributedString:attributedString16];
//    statuslbl.attributedText = attributedString15;
//    statuslbl.lineBreakMode = NSLineBreakByWordWrapping;
//    statuslbl.numberOfLines = 0;

    hig=hig+screenRect.size.height*0.10;
    
    UIButton *Createvoucherbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.20,hig,screenRect.size.width*0.60,screenRect.size.height*0.06)];
    Createvoucherbtn.layer.cornerRadius = 4.0f;
    [Createvoucherbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
    [Createvoucherbtn addTarget:self action:@selector(book) forControlEvents:UIControlEventTouchUpInside];
    [Createvoucherbtn setTitle:@"Book" forState:UIControlStateNormal];
    [Createvoucherbtn setBackgroundColor:[UIColor colorWithHexString:@"#4861AC"]] ;
    [scrollview addSubview:Createvoucherbtn];
    
    hig=hig+screenRect.size.height*0.10;
 }
-(BOOL)textFieldShouldReturn:(ACFloatingTextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getproject];
   
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
            [self getproject];
        }];
    }
}
-(void)book
{
    bgview=[[UIView alloc]initWithFrame:self.view.frame];
    bgview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [self.view addSubview:bgview];
    int heig=0;
    heig=150;
    
    [demoView removeFromSuperview];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    demoView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width/2-150, screenRect.size.height/2-250, 300,450)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=4.0f;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];

    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    [topButton setTitle:@"Book" forState:UIControlStateNormal];
    [topButton setFont:[UIFont boldSystemFontOfSize:16]];
    topButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [topButton setBackgroundColor:[UIColor colorWithHexString:@"#E8E8E8"]];
    [demoView addSubview:topButton];
    
    projecttxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,50,280,40)];
    projecttxt.textAlignment=NSTextAlignmentLeft;
    projecttxt.delegate = self;
    projecttxt.textColor=[UIColor blackColor];
    [projecttxt setBackgroundColor:[UIColor clearColor]];
    projecttxt.leftViewMode = UITextFieldViewModeAlways;
    [projecttxt setKeyboardType:UIKeyboardTypeEmailAddress];
    projecttxt.returnKeyType=UIReturnKeyDone;
    projecttxt.selectedLineColor = [UIColor redColor];
    projecttxt.selectedPlaceHolderColor = [UIColor redColor];
    projecttxt.placeHolderColor = [UIColor grayColor];
    projecttxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:projecttxt];
    
    projectarr=[[NSMutableArray alloc]init];
    for (int i=0; i<appDelegate.projectarr.count; i++) {
        NSDictionary* dict=[appDelegate.projectarr objectAtIndex:i];
        [projectarr addObject:[dict objectForKey:@"name"]];
    }
    downPicker = [[DownPicker alloc] initWithTextField:projecttxt withData:projectarr];
    [downPicker setPlaceholderWhileSelecting:@"Project*"];
    [downPicker showArrowImage:YES];
    projecttxt.placeholder=@"Project*";
    
    unitnotxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,100,280,40)];
    unitnotxt.textAlignment=NSTextAlignmentLeft;
    unitnotxt.delegate = self;
    unitnotxt.textColor=[UIColor blackColor];
    [unitnotxt setBackgroundColor:[UIColor clearColor]];
    unitnotxt.leftViewMode = UITextFieldViewModeAlways;
    [unitnotxt setKeyboardType:UIKeyboardTypeEmailAddress];
    unitnotxt.returnKeyType=UIReturnKeyDone;
    unitnotxt.selectedLineColor = [UIColor redColor];
    unitnotxt.selectedPlaceHolderColor = [UIColor redColor];
    unitnotxt.placeHolderColor = [UIColor grayColor];
    unitnotxt.placeholder=@"Unit no*";
    unitnotxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:unitnotxt];

    nametxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,150,280,40)];
    nametxt.textAlignment=NSTextAlignmentLeft;
    nametxt.delegate = self;
    nametxt.textColor=[UIColor blackColor];
    [nametxt setBackgroundColor:[UIColor clearColor]];
    nametxt.leftViewMode = UITextFieldViewModeAlways;
    [nametxt setKeyboardType:UIKeyboardTypeEmailAddress];
    nametxt.returnKeyType=UIReturnKeyDone;
    nametxt.selectedLineColor = [UIColor redColor];
    nametxt.selectedPlaceHolderColor = [UIColor redColor];
    nametxt.placeHolderColor = [UIColor grayColor];
    nametxt.placeholder=@"Customer Name*";
    nametxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:nametxt];
    
    emailtxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,200,280,40)];
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
    emailtxt.placeholder=@"Email*";
    emailtxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:emailtxt];
    
    mobiletxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,250,280,40)];
    mobiletxt.textAlignment=NSTextAlignmentLeft;
    mobiletxt.delegate = self;
    mobiletxt.textColor=[UIColor blackColor];
    [mobiletxt setBackgroundColor:[UIColor clearColor]];
    mobiletxt.leftViewMode = UITextFieldViewModeAlways;
    [mobiletxt setKeyboardType:UIKeyboardTypeEmailAddress];
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
    [demoView addSubview:mobiletxt];
    

    
    nopartxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,350,280,40)];
    nopartxt.textAlignment=NSTextAlignmentLeft;
    nopartxt.delegate = self;
    nopartxt.textColor=[UIColor blackColor];
    [nopartxt setBackgroundColor:[UIColor clearColor]];
    nopartxt.leftViewMode = UITextFieldViewModeAlways;
    [nopartxt setKeyboardType:UIKeyboardTypeEmailAddress];
    nopartxt.returnKeyType=UIReturnKeyDone;
    nopartxt.selectedLineColor = [UIColor redColor];
    nopartxt.selectedPlaceHolderColor = [UIColor redColor];
    nopartxt.placeHolderColor = [UIColor grayColor];
    nopartxt.placeholder=@"No of participants*";
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbarzip sizeToFit];
    nopartxt.inputAccessoryView = numberToolbarzip;
    nopartxt.leftViewMode = UITextFieldViewModeAlways;
    nopartxt.keyboardType = UIKeyboardTypeNumberPad;
    nopartxt.font = [UIFont systemFontOfSize:14];
    nopartxt.text=@"1";
    [demoView addSubview:nopartxt];
    
    
    alternatetxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,300,280,40)];
    alternatetxt.textAlignment=NSTextAlignmentLeft;
    alternatetxt.delegate = self;
    alternatetxt.textColor=[UIColor blackColor];
    [alternatetxt setBackgroundColor:[UIColor clearColor]];
    alternatetxt.leftViewMode = UITextFieldViewModeAlways;
    [alternatetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    alternatetxt.returnKeyType=UIReturnKeyDone;
    alternatetxt.selectedLineColor = [UIColor redColor];
    alternatetxt.selectedPlaceHolderColor = [UIColor redColor];
    alternatetxt.placeHolderColor = [UIColor grayColor];
    alternatetxt.placeholder=@"Alternate Mobile";
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbarzip sizeToFit];
    alternatetxt.inputAccessoryView = numberToolbarzip;
    alternatetxt.leftViewMode = UITextFieldViewModeAlways;
    alternatetxt.keyboardType = UIKeyboardTypeNumberPad;
    alternatetxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:alternatetxt];

    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(23,400,125,40)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(closeAlert:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.font=[UIFont systemFontOfSize:14];
    // [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
    cancelBtn.tag=5;
    [cancelBtn setBackgroundColor:[UIColor colorWithHexString:@"#F8F8F8"]];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    cancelBtn.layer.borderColor = [UIColor grayColor].CGColor;
    cancelBtn.layer.borderWidth = 0.5;
    [demoView addSubview:cancelBtn];
    
    UIButton *savebtn=[[UIButton alloc] initWithFrame:CGRectMake(152,400,125,40)];
    [savebtn setTitle:@"Book" forState:UIControlStateNormal];
    [savebtn addTarget:self
                action:@selector(save)
      forControlEvents:UIControlEventTouchUpInside];
    savebtn.font=[UIFont systemFontOfSize:14];
    // [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
    [savebtn setBackgroundColor:[UIColor colorWithHexString:@"#F8F8F8"]];
    [savebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [savebtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    savebtn.layer.borderColor = [UIColor grayColor].CGColor;
    savebtn.layer.borderWidth = 0.5;
    [demoView addSubview:savebtn];
    
    CATransition *transition1 = [CATransition animation];
    transition1.duration = 0.5;
    transition1.type = kCATransitionPush;
    transition1.subtype = kCATransitionFromLeft;
    [transition1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [demoView.layer addAnimation:transition1 forKey:nil];
    [self.view addSubview:demoView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)closeAlert:(id)sender{
    CATransition *transition1 = [CATransition animation];
    transition1.duration = 0.5;
    transition1.type = kCATransitionPush;
    transition1.subtype = kCATransitionFromLeft;
    [transition1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [demoView.layer addAnimation:transition1 forKey:nil];
    demoView.hidden=YES;
    [bgview removeFromSuperview];
    [mobiletxt resignFirstResponder];
    [emailtxt resignFirstResponder];
    [nametxt resignFirstResponder];
    [unitnotxt resignFirstResponder];
}
- (BOOL)validateEmailWithString
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailtxt.text];
}
-(void)save
{
    
    if (![projecttxt.text isEqualToString:@""]) {
       if (![unitnotxt.text isEqualToString:@""]) {
    if (![nametxt.text isEqualToString:@""]) {
        if (![emailtxt.text isEqualToString:@""]&&[self validateEmailWithString]) {
            if (![mobiletxt.text isEqualToString:@""]&&mobiletxt.text.length==10) {
                if (![nopartxt.text isEqualToString:@""]&&![nopartxt.text isEqualToString:@"0"]) {
                    
                    if ([[dict objectForKey:@"event_avalibleslots"]integerValue]>=[nopartxt.text integerValue]) {
                        
                CGRect screenRect = [[UIScreen mainScreen] bounds];
                UIActivityIndicatorView* acttyindicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                acttyindicator.frame =CGRectMake(0,0 ,screenRect.size.width,screenRect.size.height*0.80);
                //     acttyindicator.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.5];
                acttyindicator.color=[UIColor blackColor];
                [self.view addSubview:acttyindicator];
                [acttyindicator bringSubviewToFront:demoView];
                
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
                [params setObject:nametxt.text  forKey:@"custname"];
                [params setObject:mobiletxt.text  forKey:@"mobileno"];
                [params setObject:emailtxt.text  forKey:@"emailid"];
                [params setObject:unitnotxt.text  forKey:@"unitno"];
                [params setObject:@"Savecustomerevent"  forKey:@"requestType"];
                [params setObject:[dict objectForKey:@"Event_ID"]  forKey:@"eventid"];
                [params setObject:projecttxt.text  forKey:@"projname"];
                [params setObject:nopartxt.text  forKey:@"no_part"];
                [params setObject:alternatetxt.text  forKey:@"alter_no"];

                NSString*    urlString = [[NSString alloc]initWithFormat:@"%@savecustomerevents.php?",[prefs objectForKey:@"Link"]];
                [acttyindicator startAnimating];
                [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                    
                    NSMutableDictionary*   userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    NSString * returnString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    NSLog(@"Response in str = %@",returnString);
                 //   NSLog(@"JSON: %@", userDict);
 
                    if ([[userDict objectForKey:@"status"]intValue ]==1) {
                        [self closeAlert:0];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userDict objectForKey:@"msg"]delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [acttyindicator stopAnimating];

                } failure:^(NSURLSessionTask *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    [acttyindicator stopAnimating];
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }];
                }else
                {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[NSString stringWithFormat:@"Only %@ slots are avaible",[dict objectForKey:@"event_avalibleslots"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                }
                else
                {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Invalid no of participants."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Invalid mobile no"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Invalid email "delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Invalid customer name"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
       }else
       {
           UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Enter unit no."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
           [alert show];
       }
    }else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Please Select Project"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
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
    if (textField==alternatetxt)
    {
        if(textField.text.length >9 && range.length == 0)
        {
            return NO;
        }
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField

{
    if (textField==nopartxt||textField==alternatetxt)
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==nopartxt||textField==alternatetxt)
   [self animateTextField:textField up:NO];

    if (textField==unitnotxt) {
        [self getcustdata];
    }
}
-(void)getcustdata
{
    for (int i=0; i<appDelegate.projectarr.count; i++) {
        NSDictionary* dict=[appDelegate.projectarr objectAtIndex:i];
        if ([projecttxt.text isEqualToString:[dict objectForKey:@"name"]]) {
            _projectidstr=[dict objectForKey:@"id"];
        }
    }
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:unitnotxt.text  forKey:@"unit_no"];
    [params setObject:_projectidstr  forKey:@"pid"];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getproject1.php?",[prefs objectForKey:@"Link"]];
    [indicator startAnimating];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", userDict);
        if ([[[userDict objectForKey:@"Android"]objectForKey:@"leads"] isEqual:[NSNull null]]) {
            
        }
        else
        {
        nametxt.text=[[[[userDict objectForKey:@"Android"]objectForKey:@"leads"]objectAtIndex:0]objectForKey:@"fullname"];
        mobiletxt.text=[[[[userDict objectForKey:@"Android"]objectForKey:@"leads"]objectAtIndex:0]objectForKey:@"phone_mobile"];
        }

     NSMutableArray*   leadarr =[[userDict objectForKey:@"Android"] objectForKey:@"leads"];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -130; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)doneWithNumberPad{
    [mobiletxt resignFirstResponder];
    [nopartxt resignFirstResponder];
    [alternatetxt resignFirstResponder];
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
