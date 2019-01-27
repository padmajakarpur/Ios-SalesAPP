//
//  LeadViewController.m
//  Sales App
//
//  Created by Infinitum on 14/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "LeadViewController.h"
#import "UIColor+Expanded.h"
@interface LeadViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,retain)IBOutlet MXSegmentedPager *insidepager;

@end
@implementation LeadViewController
@synthesize mxpager,documentbaseview,tasktableview,addbtn,bgview,demoView,tasktxt,scheduleontxt,indicator,dict;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];

     UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.0,screenRect.size.width,screenRect.size.height*0.35)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#ED2026"];
    
    UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.20,screenRect.size.height*.03,screenRect.size.width*.64,screenRect.size.height*.07)];
    titlelable.textAlignment = NSTextAlignmentLeft;
    titlelable.text=@"Leads";
    titlelable.textColor=[UIColor whiteColor];
    [titlelable setBackgroundColor:[UIColor clearColor]];
    titlelable.font=[UIFont fontWithName:@"Open Sans" size:22];
    [navigationView addSubview:titlelable];
    
    UIButton*  backBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.03,screenRect.size.width*0.20,screenRect.size.height*.07)];
    //  [backBtn setTitle:@"\uE5C4" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backbtn) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"arrow_back_white.png"] forState:UIControlStateNormal];
    [navigationView addSubview:backBtn];
    
    UIImageView *dashbgimageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.03,screenRect.size.height*0.13, screenRect.size.height*0.15,screenRect.size.height*0.15)];
    dashbgimageview.image=[UIImage imageNamed:@"account_circle.png"];
    dashbgimageview.contentMode = UIViewContentModeScaleAspectFit;
    dashbgimageview.backgroundColor=[UIColor lightGrayColor];
    dashbgimageview.layer.cornerRadius=screenRect.size.height*0.075;
    dashbgimageview.clipsToBounds=YES;
    [dashbgimageview.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [dashbgimageview.layer setBorderWidth: 3.0];
    [navigationView addSubview:dashbgimageview];
    
    UILabel *namelbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05+screenRect.size.height*0.17,screenRect.size.height*.11,screenRect.size.width*.64,screenRect.size.height*.07)];
    namelbl.textAlignment = NSTextAlignmentLeft;
    namelbl.text=[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"first_name"],[dict objectForKey:@"last_name"]];
    ;
    namelbl.textColor=[UIColor whiteColor];
    [namelbl setBackgroundColor:[UIColor clearColor]];
    namelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.06];
    [navigationView addSubview:namelbl];
    
    UIButton *savebtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.05+screenRect.size.height*0.15,screenRect.size.height*0.18,screenRect.size.width*0.10,screenRect.size.height*.05)];
    [savebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    savebtn.layer.masksToBounds=YES;
    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    savebtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [savebtn setTitle:@"\uE0B0" forState:UIControlStateNormal];
    [navigationView addSubview:savebtn];
    
    UIButton *phonebtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.05+screenRect.size.height*0.15+screenRect.size.width*0.10,screenRect.size.height*.18,screenRect.size.width*.64,screenRect.size.height*.05)];
    [phonebtn2 setBackgroundColor:[UIColor clearColor]];
    [phonebtn2 addTarget:self action:@selector(openurl:) forControlEvents:UIControlEventTouchUpInside];
    phonebtn2.tag=10;
    [phonebtn2 setTitle:[dict objectForKey:@"phone_mobile"]forState:UIControlStateNormal];
    [phonebtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    phonebtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIFont* font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    phonebtn2.titleLabel.font=font;
    [navigationView addSubview:phonebtn2];
    
    UIButton *emailbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.05+screenRect.size.height*0.15,screenRect.size.height*0.23,screenRect.size.width*0.10,screenRect.size.height*.05)];
    emailbtn.layer.masksToBounds=YES;
    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    emailbtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [emailbtn setTitle:@"\uE0BE" forState:UIControlStateNormal];
    [navigationView addSubview:emailbtn];
    
    UIButton *emaillbl=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.05+screenRect.size.height*0.15+screenRect.size.width*0.10,screenRect.size.height*0.23,screenRect.size.width*.64,screenRect.size.height*.05)];
    [emaillbl setBackgroundColor:[UIColor clearColor]];
    [emaillbl addTarget:self action:@selector(openurl:) forControlEvents:UIControlEventTouchUpInside];
    emaillbl.tag=11;
    [emaillbl setTitle:[dict objectForKey:@"email_address"] forState:UIControlStateNormal];
    [emailbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    emaillbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    emaillbl.titleLabel.font=font;
    [navigationView addSubview:emaillbl];
    
    tittlearr=[NSMutableArray arrayWithObjects:@"Basic Info",@"Documents",@"History", nil];
    headerarr=[NSMutableArray arrayWithObjects:@"Project Name",@"Mobile",@"Work Phone",@"Home Phone",@"Email Address",@"Alternate Email",@"Prospect Status",@"Visit Stage",@"Prospect Source", @"Prospect source", @"Assigned To", @"Address", @"Street", @"City",@"State", @"Postal Code", @"Country", @"Sales Action",@"Location Preference",@"Other Project Of Interest",@"Schedule On", nil];

    textarr=[NSMutableArray arrayWithObjects:[dict objectForKey:@"project_name"] ,[dict objectForKey:@"phone_mobile"],[dict objectForKey:@"phone_office"],[dict objectForKey:@"phone_home"],[dict objectForKey:@"email_address"],@"alt email", [dict objectForKey:@"leadStatus"],[dict objectForKey:@"lead_stage_c"],@"",@"",@"Sales_xrbia 1",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"l",nil];

    insidetittlearr=[NSMutableArray arrayWithObjects:@"Photos",@"Documents", nil];

    mxpager=[[MXSegmentedPager alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.30,screenRect.size.width,screenRect.size.height*0.70)];
    [self.view addSubview:mxpager];
    
    mxpager.delegate=self;
    mxpager.dataSource=self;
    mxpager.backgroundColor=[UIColor whiteColor];
    mxpager.segmentedControlPosition=MXSegmentedControlPositionTop;
    mxpager.contentMode=UIViewContentModeTop;
    mxpager.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    mxpager.segmentedControl.selectionIndicatorColor = [UIColor orangeColor];
    mxpager.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    mxpager.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    mxpager.tag=50;
    mxpager.segmentedControl.titleTextAttributes=@{NSFontAttributeName: [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : [UIColor whiteColor]};
    mxpager.segmentedControl.backgroundColor=[UIColor colorWithHexString:@"#ED2026"];
    [mxpager.pager registerClass:[UITextView class] forPageReuseIdentifier:@"TextPage"];
    //    mxpager.tintColor=[UIColor redColor];
    //    mxpager.parallaxHeader.view = self.navigationView;
    //    mxpager.parallaxHeader.height = screenRect.size.height*0.30;
    //    mxpager.parallaxHeader.mode = MXParallaxHeaderModeFill;
    //    mxpager.parallaxHeader.minimumHeight = screenRect.size.height*0.10;
    
    documentbaseview=[[UIView alloc]init];
    documentbaseview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    
    UIButton *photosbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.0,screenRect.size.height*0.0,screenRect.size.width*.396,screenRect.size.height*.07)];
    [photosbtn setBackgroundColor:[UIColor whiteColor]];
   // [photosbtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [photosbtn setTitle:@"Photos" forState:UIControlStateNormal];
    [photosbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    photosbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    photosbtn.titleLabel.font=font;
    UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, photosbtn.frame.size.height - 1.0f, photosbtn.frame.size.width, 1)];
    bottomBorder.backgroundColor = [UIColor orangeColor];
    [documentbaseview addSubview:photosbtn];
    [photosbtn addSubview:bottomBorder];

    UIButton *docbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.404,screenRect.size.height*0.0,screenRect.size.width*.392,screenRect.size.height*.07)];
    [docbtn setBackgroundColor:[UIColor whiteColor]];
  //  [docbtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [docbtn setTitle:@"Documents" forState:UIControlStateNormal];
    [docbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    docbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    docbtn.titleLabel.font=font;
    [documentbaseview addSubview:docbtn];
    
    UIButton *attachbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.80,screenRect.size.height*0.0,screenRect.size.width*.20,screenRect.size.height*.07)];
    [attachbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [attachbtn setBackgroundColor:[UIColor whiteColor]];
    attachbtn.layer.masksToBounds=YES;
    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    attachbtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [attachbtn setTitle:@"\uE226" forState:UIControlStateNormal];
    [documentbaseview addSubview:attachbtn];
    
   addbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.75,screenRect.size.height*0.85,screenRect.size.width*0.15,screenRect.size.width*0.15)];
    addbtn.layer.cornerRadius = screenRect.size.width*0.075;
    [addbtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    addbtn.backgroundColor=[UIColor colorWithHexString:@"#6164FF"];
    addbtn.font=[UIFont fontWithName:@"MaterialIcons-Regular" size:screenRect.size.width*0.12];
    [addbtn setTitle:@"\uE145" forState:UIControlStateNormal];
    [addbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:addbtn];
    addbtn.hidden=YES;
    
    addbtn.imageView.layer.cornerRadius = 7.0f;
    addbtn.layer.shadowRadius = 3.0f;
    addbtn.layer.shadowColor = [UIColor blackColor].CGColor;
    addbtn.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    addbtn.layer.shadowOpacity = 0.5f;
    addbtn.layer.masksToBounds = NO;
}
-(void) add
{
    bgview=[[UIView alloc]initWithFrame:self.view.frame];
    bgview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [self.view addSubview:bgview];
    int heig=0;
    heig=150;
    
    [demoView removeFromSuperview];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    demoView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width/2-150, screenRect.size.height/2-150, 300,230)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    [topButton setTitle:@"Update Prospect Status" forState:UIControlStateNormal];
    [topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    topButton.layer.cornerRadius=1.0;
    topButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    [topButton setBackgroundColor:[UIColor colorWithHexString:@"35a6e6"]];
    [topButton setFont:[UIFont boldSystemFontOfSize:16]];
    [topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [demoView addSubview:topButton];
    
    tasktxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,55,280,50)];
    tasktxt.textAlignment=NSTextAlignmentLeft;
    tasktxt.delegate = self;
    tasktxt.textColor=[UIColor blackColor];
    [tasktxt setBackgroundColor:[UIColor clearColor]];
    tasktxt.leftViewMode = UITextFieldViewModeAlways;
    [tasktxt setKeyboardType:UIKeyboardTypeEmailAddress];
    tasktxt.returnKeyType=UIReturnKeyDone;
    tasktxt.selectedLineColor = [UIColor redColor];
    tasktxt.selectedPlaceHolderColor = [UIColor redColor];
    tasktxt.placeHolderColor = [UIColor grayColor];
    tasktxt.placeholder=@"Task";
    tasktxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:tasktxt];
    
    scheduleontxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,105,280,50)];
    scheduleontxt.textAlignment=NSTextAlignmentLeft;
    scheduleontxt.delegate = self;
    scheduleontxt.textColor=[UIColor blackColor];
    [scheduleontxt setBackgroundColor:[UIColor clearColor]];
    scheduleontxt.leftViewMode = UITextFieldViewModeAlways;
    [scheduleontxt setKeyboardType:UIKeyboardTypeEmailAddress];
    scheduleontxt.returnKeyType=UIReturnKeyDone;
    scheduleontxt.selectedLineColor = [UIColor redColor];
    scheduleontxt.selectedPlaceHolderColor = [UIColor redColor];
    scheduleontxt.placeHolderColor = [UIColor grayColor];
    scheduleontxt.placeholder=@"Schedule On";
    scheduleontxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:scheduleontxt];

    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(23,170,125,40)];
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
    
    UIButton *savebtn=[[UIButton alloc] initWithFrame:CGRectMake(152,170,125,40)];
    [savebtn setTitle:@"Create" forState:UIControlStateNormal];
    [savebtn addTarget:self
                action:@selector(closeAlert:)
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

-(void)closeAlert:(id)sender{
    CATransition *transition1 = [CATransition animation];
    transition1.duration = 0.5;
    transition1.type = kCATransitionPush;
    transition1.subtype = kCATransitionFromLeft;
    [transition1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [demoView.layer addAnimation:transition1 forKey:nil];
    demoView.hidden=YES;
    [bgview removeFromSuperview];
}
- (CGFloat)heightForSegmentedControlInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return 40.f;
}

- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didSelectViewWithTitle:(NSString *)title {
    NSLog(@"%@ page selected.", title);
    if ([title isEqualToString:@"Task"])
    {
        addbtn.hidden=NO;
    }
    else
    {
        addbtn.hidden=YES;
    }

}
- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didScrollWithParallaxHeader:(MXParallaxHeader *)parallaxHeader {
    NSLog(@"progress %f", parallaxHeader.progress);
}

- (NSInteger)numberOfPagesInSegmentedPager:(MXSegmentedPager *)segmentedPager {
        return tittlearr.count;
}
- (NSString *)segmentedPager:(MXSegmentedPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index {
    return [tittlearr objectAtIndex:index];
    
}
- (UIView *)segmentedPager:(MXSegmentedPager *)segmentedPager viewForPageAtIndex:(NSInteger)index {
    
    tableindex=index;
    if (index==0) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tag=tableindex;
    }
//    if (index==1) {
//        tasktableview = [[UITableView alloc] init];
//        tasktableview.delegate = self;
//        tasktableview.dataSource = self;
//        tasktableview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
//        tasktableview.separatorStyle=UITableViewCellSeparatorStyleNone;
//        tasktableview.tag=tableindex;
//        return tasktableview;
//    }
//    
    if (index==1) {
        return documentbaseview;
    }
    
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==0) {
        return headerarr.count;
    }
    if (tableView.tag==1) {
        return 1;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
    
    if (tableView.tag==0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.94,screenRect.size.height*0.10)];
        headerView.backgroundColor=[UIColor whiteColor];
        
//        UIButton*  drawerbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.37,screenRect.size.height*0.0,screenRect.size.width*0.20,screenRect.size.height*.05)];
//        drawerbtn.font=[UIFont systemFontOfSize:screenRect.size.width*0.35];
//        [drawerbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        drawerbtn.backgroundColor=[UIColor orangeColor];
//        [headerView addSubview:drawerbtn];
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.01,headerView.frame.size.width*0.90,screenRect.size.height*0.04)];
        Srnolbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
        Srnolbl.textAlignment = NSTextAlignmentLeft;
        Srnolbl.text =[headerarr objectAtIndex:indexPath.row];
        Srnolbl.backgroundColor = [UIColor clearColor];
        Srnolbl.textColor=[UIColor grayColor];
        [headerView addSubview:Srnolbl];
        
        UILabel*  textlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.05,headerView.frame.size.width*0.90,screenRect.size.height*0.05)];
        textlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.05];
        textlbl.textAlignment = NSTextAlignmentLeft;
        textlbl.text =[textarr objectAtIndex:indexPath.row];
        textlbl.backgroundColor = [UIColor clearColor];
        textlbl.textColor=[UIColor colorWithHexString:@"#00cca3"];
        textlbl.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:textlbl];
        [cell.contentView addSubview:headerView];
        
        if ([[headerarr objectAtIndex:indexPath.row] isEqualToString:@"Prospect Source"]||[[headerarr objectAtIndex:indexPath.row] isEqualToString:@"Address"]||[[headerarr objectAtIndex:indexPath.row] isEqualToString:@"Sales Action"]) {
            
            Srnolbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.05];
 Srnolbl.frame=CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.04,headerView.frame.size.width*0.90,screenRect.size.height*0.05);
            Srnolbl.textColor=[UIColor blueColor];
            textlbl.hidden=YES;
        }

        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.contentMode= UIViewContentModeLeft;
        
        cell.backgroundColor = [UIColor clearColor];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if (tableView==tasktableview) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.01,screenRect.size.width*0.96,screenRect.size.height*0.10)];
        headerView.backgroundColor=[UIColor whiteColor];
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.0,screenRect.size.width*0.90,screenRect.size.height*0.05)];
        Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.05];
        Srnolbl.textAlignment = NSTextAlignmentLeft;
        Srnolbl.text =@"Call to Customer";
        Srnolbl.backgroundColor = [UIColor clearColor];
        Srnolbl.textColor=[UIColor blackColor];
        [headerView addSubview:Srnolbl];
        
        UILabel*  textlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.05,screenRect.size.width*0.90,screenRect.size.height*0.05)];
        textlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.05];
        textlbl.textAlignment = NSTextAlignmentLeft;
        textlbl.text =@"Scheduled Date:Feb,2018 11:05 AM";
        textlbl.backgroundColor = [UIColor clearColor];
        textlbl.textColor=[UIColor blackColor];
        textlbl.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:textlbl];
        [cell.contentView addSubview:headerView];
    }
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
    if (tableView.tag==0) {
        return screenRect.size.height*0.11;
    }
    if (tableView.tag==1) {
        return screenRect.size.height*0.11;
    }
    return screenRect.size.height*0.11;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backbtn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)openurl:(UIButton*)btn
{
    if (btn.tag==11)
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@",btn.titleLabel.text]]];
else if(btn.tag==10)
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",btn.titleLabel.text]]];

}
-(BOOL)textFieldShouldReturn:(ACFloatingTextField *)textField
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
