//
//  ProspectViewController.m
//  Sales App
//
//  Created by Infinitum on 28/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "ProspectViewController.h"
#import "UIColor+Expanded.h"
#import "MyBookingViewController.h"
#import "MyLeadsViewController.h"
#import "MyVisitsViewController.h"
#import "OCRViewController.h"
#import "BACViewController.h"
@interface ProspectViewController ()

@end

@implementation ProspectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];

//    {
//        // Do any additional setup after loading the view from its nib.
//        [[self navigationController] setNavigationBarHidden:YES animated:YES];
//
//        UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
//        [self.view addSubview:navigationView];
//        navigationView.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
//
//        UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:30];
//        UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
//        [navigationbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//        [navigationbtn setTitle:@"\uE314" forState:UIControlStateNormal];
//        [navigationbtn setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
//        [navigationbtn.titleLabel setFont:customFontdregs];
//        [navigationbtn setBackgroundColor:[UIColor clearColor]];
//        [self.view addSubview:navigationbtn];
//
//        UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
//        //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
//        horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
//        horizontallbl.text=@"Xrbia";
//        [horizontallbl setTextColor:[UIColor blackColor]];
//        horizontallbl.textAlignment = NSTextAlignmentCenter;
//        [navigationView addSubview:horizontallbl];
//
//        UIImageView *dashbgimageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.10, screenRect.size.width,screenRect.size.height*0.90)];
//        dashbgimageview.image=[UIImage imageNamed:@"Vangani Ele.png"];
//        dashbgimageview.clipsToBounds=YES;
//        dashbgimageview.contentMode = UIViewContentModeScaleAspectFill;
//        [self.view addSubview:dashbgimageview];
//
//        UIImageView *partiallimageview=[[UIImageView alloc]initWithFrame:dashbgimageview.frame];
//        //  partiallimageview.backgroundColor=[UIColor colorWithHexString:@"#FFA500"];
//        partiallimageview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
//        [self.view addSubview:partiallimageview];
//
//        UIButton *prospectbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.12,screenRect.size.width*0.28,screenRect.size.width*0.28)];
//        prospectbtn.layer.cornerRadius = screenRect.size.width*0.14;
//        [prospectbtn setClipsToBounds:YES];
//        [prospectbtn setTitle:@"Prospect" forState:UIControlStateNormal];
//        [prospectbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [prospectbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//        //  [prospectbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:prospectbtn];
//        [prospectbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
//        [prospectbtn setBackgroundColor:[UIColor whiteColor]] ;
//
//        UIButton *followupbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.55,screenRect.size.height*0.12,screenRect.size.width*0.28,screenRect.size.width*0.28)];
//        followupbtn.layer.cornerRadius = screenRect.size.width*0.14;
//        [followupbtn setClipsToBounds:YES];
//        [followupbtn setTitle:@"Follow Up" forState:UIControlStateNormal];
//        [followupbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [followupbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//        //  [followupbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:followupbtn];
//        [followupbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
//        [followupbtn setBackgroundColor:[UIColor whiteColor]] ;
//
//        UIButton *Bacbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.32,screenRect.size.width*0.28,screenRect.size.width*0.28)];
//        Bacbtn.layer.cornerRadius = screenRect.size.width*0.14;
//        [Bacbtn setClipsToBounds:YES];
//        [Bacbtn setTitle:@"BAC" forState:UIControlStateNormal];
//        [Bacbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [Bacbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//        // [prospectbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:Bacbtn];
//        [Bacbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
//        [Bacbtn setBackgroundColor:[UIColor whiteColor]] ;
//
//        UIButton *OCRbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.55,screenRect.size.height*0.32,screenRect.size.width*0.28,screenRect.size.width*0.28)];
//        OCRbtn.layer.cornerRadius = screenRect.size.width*0.14;
//        [OCRbtn setClipsToBounds:YES];
//        [OCRbtn setTitle:@"OCR" forState:UIControlStateNormal];
//        [OCRbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [OCRbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//        //  [OCRbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:OCRbtn];
//        [OCRbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
//        [OCRbtn setBackgroundColor:[UIColor whiteColor]] ;
//
//        UIButton *ROXbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.52,screenRect.size.width*0.28,screenRect.size.width*0.28)];
//        ROXbtn.layer.cornerRadius = screenRect.size.width*0.14;
//        [ROXbtn setClipsToBounds:YES];
//        [ROXbtn setTitle:@"ROX" forState:UIControlStateNormal];
//        [ROXbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [ROXbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//        // [prospectbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:ROXbtn];
//        [ROXbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
//        [ROXbtn setBackgroundColor:[UIColor whiteColor]] ;
//
//        UIButton *sdbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.55,screenRect.size.height*0.52,screenRect.size.width*0.28,screenRect.size.width*0.28)];
//        sdbtn.layer.cornerRadius = screenRect.size.width*0.14;
//        [sdbtn setClipsToBounds:YES];
//        [sdbtn setTitle:@"SD" forState:UIControlStateNormal];
//        [sdbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [sdbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//        //  [OCRbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:sdbtn];
//        [sdbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
//        [sdbtn setBackgroundColor:[UIColor whiteColor]] ;
//
//        UIButton *inventarybtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.72,screenRect.size.width*0.28,screenRect.size.width*0.28)];
//        inventarybtn.layer.cornerRadius = screenRect.size.width*0.14;
//        [inventarybtn setClipsToBounds:YES];
//        [inventarybtn setTitle:@"Inventory" forState:UIControlStateNormal];
//        [inventarybtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [inventarybtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//        // [prospectbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:inventarybtn];
//        [inventarybtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
//        [inventarybtn setBackgroundColor:[UIColor whiteColor]] ;
//
//        UIButton *marketingbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.55,screenRect.size.height*0.72,screenRect.size.width*0.28,screenRect.size.width*0.28)];
//        marketingbtn.layer.cornerRadius = screenRect.size.width*0.14;
//        [marketingbtn setClipsToBounds:YES];
//        marketingbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        [marketingbtn setTitle:@"Marketing\nMaterial" forState:UIControlStateNormal];
//        [marketingbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [marketingbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//        [marketingbtn.titleLabel setTextAlignment: NSTextAlignmentCenter];
//
//        //  [OCRbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:marketingbtn];
//        [marketingbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
//        [marketingbtn setBackgroundColor:[UIColor whiteColor]] ;
//
//        UIButton *fbbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.06,screenRect.size.height*0.92,screenRect.size.width*0.12,screenRect.size.width*0.12)];
//        fbbtn.layer.cornerRadius = screenRect.size.width*0.06;
//        //  [OCRbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:fbbtn];
//        fbbtn.backgroundColor=[UIColor whiteColor];
//        [[fbbtn imageView] setContentMode: UIViewContentModeCenter];
//        [fbbtn setImage:[UIImage imageNamed:@"facebook-app-symbol.png"] forState:UIControlStateNormal];
//
//        UIButton *twitterbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.92,screenRect.size.width*0.12,screenRect.size.width*0.12)];
//        twitterbtn.layer.cornerRadius = screenRect.size.width*0.06;
//        //  [OCRbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:twitterbtn];
//        twitterbtn.backgroundColor=[UIColor whiteColor];
//        [[twitterbtn imageView] setContentMode: UIViewContentModeCenter];
//        [twitterbtn setImage:[UIImage imageNamed:@"twitter-logo-silhouette.png"] forState:UIControlStateNormal];
//
//        UIButton *googlebtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.44,screenRect.size.height*0.92,screenRect.size.width*0.12,screenRect.size.width*0.12)];
//        googlebtn.layer.cornerRadius = screenRect.size.width*0.06;
//        //  [OCRbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:googlebtn];
//        googlebtn.backgroundColor=[UIColor whiteColor];
//        [[googlebtn imageView] setContentMode: UIViewContentModeCenter];
//        [googlebtn setImage:[UIImage imageNamed:@"google-plus-logo.png"] forState:UIControlStateNormal];
//
//        UIButton *youtubebtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.63,screenRect.size.height*0.92,screenRect.size.width*0.12,screenRect.size.width*0.12)];
//        youtubebtn.layer.cornerRadius = screenRect.size.width*0.06;
//        //  [OCRbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:youtubebtn];
//        youtubebtn.backgroundColor=[UIColor whiteColor];
//        [[youtubebtn imageView] setContentMode: UIViewContentModeCenter];
//        [youtubebtn setImage:[UIImage imageNamed:@"youtube.png"] forState:UIControlStateNormal];
//
//        UIButton *linlin=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.82   ,screenRect.size.height*0.92,screenRect.size.width*0.12,screenRect.size.width*0.12)];
//        linlin.layer.cornerRadius = screenRect.size.width*0.06;
//        //  [OCRbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:linlin];
//        linlin.backgroundColor=[UIColor whiteColor];
//        [[linlin imageView] setContentMode: UIViewContentModeCenter];
//        [linlin setImage:[UIImage imageNamed:@"linkedin-logo.png"] forState:UIControlStateNormal];
//
//        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
//            prospectbtn.frame=CGRectMake(screenRect.size.width*0.19,screenRect.size.height*0.12,screenRect.size.width*0.24,screenRect.size.width*0.24);
//            prospectbtn.layer.cornerRadius = screenRect.size.width*0.12;
//            followupbtn.frame=CGRectMake(screenRect.size.width*0.57,screenRect.size.height*0.12,screenRect.size.width*0.24,screenRect.size.width*0.24);
//            followupbtn.layer.cornerRadius = screenRect.size.width*0.12;
//            Bacbtn.frame=CGRectMake(screenRect.size.width*0.19,screenRect.size.height*0.32,screenRect.size.width*0.24,screenRect.size.width*0.24);
//            Bacbtn.layer.cornerRadius = screenRect.size.width*0.12;
//            OCRbtn.frame=CGRectMake(screenRect.size.width*0.57,screenRect.size.height*0.32,screenRect.size.width*0.24,screenRect.size.width*0.24);
//            OCRbtn.layer.cornerRadius = screenRect.size.width*0.12;
//            ROXbtn.frame=CGRectMake(screenRect.size.width*0.19,screenRect.size.height*0.52,screenRect.size.width*0.24,screenRect.size.width*0.24);
//            ROXbtn.layer.cornerRadius = screenRect.size.width*0.12;
//            sdbtn.frame=CGRectMake(screenRect.size.width*0.57,screenRect.size.height*0.52,screenRect.size.width*0.24,screenRect.size.width*0.24);
//            sdbtn.layer.cornerRadius = screenRect.size.width*0.12;
//
//            inventarybtn.frame=CGRectMake(screenRect.size.width*0.19,screenRect.size.height*0.72,screenRect.size.width*0.24,screenRect.size.width*0.24);
//            inventarybtn.layer.cornerRadius = screenRect.size.width*0.12;
//            marketingbtn.frame=CGRectMake(screenRect.size.width*0.57,screenRect.size.height*0.72,screenRect.size.width*0.24,screenRect.size.width*0.24);
//            marketingbtn.layer.cornerRadius = screenRect.size.width*0.12;
//            fbbtn.frame=CGRectMake(screenRect.size.width*0.12,screenRect.size.height*0.92,screenRect.size.width*0.09,screenRect.size.width*0.09);
//            fbbtn.layer.cornerRadius = screenRect.size.width*0.045;
//            twitterbtn.frame=CGRectMake(screenRect.size.width*0.29,screenRect.size.height*0.92,screenRect.size.width*0.09,screenRect.size.width*0.09);
//            twitterbtn.layer.cornerRadius = screenRect.size.width*0.045;
//            googlebtn.frame=CGRectMake(screenRect.size.width*0.46,screenRect.size.height*0.92,screenRect.size.width*0.09,screenRect.size.width*0.09);
//            googlebtn.layer.cornerRadius = screenRect.size.width*0.045;
//            youtubebtn.frame=CGRectMake(screenRect.size.width*0.63,screenRect.size.height*0.92,screenRect.size.width*0.09,screenRect.size.width*0.09);
//            youtubebtn.layer.cornerRadius = screenRect.size.width*0.045;
//            linlin.frame=CGRectMake(screenRect.size.width*0.80,screenRect.size.height*0.92,screenRect.size.width*0.09,screenRect.size.width*0.09);
//            linlin.layer.cornerRadius = screenRect.size.width*0.045;
//
//        }
//    }
    
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
            //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
            horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
            horizontallbl.text=@"Collection";
            [horizontallbl setTextColor:[UIColor blackColor]];
            horizontallbl.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:horizontallbl];

    //    UIImageView *partiallimageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height)];
//    partiallimageview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
//    [self.view addSubview:partiallimageview];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:30];
            UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
            [navigationbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
            [navigationbtn setTitle:@"\uE314" forState:UIControlStateNormal];
            [navigationbtn setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
            [navigationbtn.titleLabel setFont:customFontdregs];
            [navigationbtn setBackgroundColor:[UIColor clearColor]];
            [self.view addSubview:navigationbtn];
    
    UIImageView *dashbgimageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.10, screenRect.size.width,screenRect.size.height*0.90)];
            dashbgimageview.image=[UIImage imageNamed:@"Vangani Ele.png"];
            dashbgimageview.clipsToBounds=YES;
            dashbgimageview.contentMode = UIViewContentModeScaleAspectFill;
            [self.view addSubview:dashbgimageview];
    
            UIImageView *partiallimageview=[[UIImageView alloc]initWithFrame:dashbgimageview.frame];
            //  partiallimageview.backgroundColor=[UIColor colorWithHexString:@"#FFA500"];
            partiallimageview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
            [self.view addSubview:partiallimageview];
    
    UIButton *bookinbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.36,screenRect.size.height*0.15,screenRect.size.width*0.28,screenRect.size.width*0.28)];
    bookinbtn.layer.cornerRadius = screenRect.size.width*0.14;
    [bookinbtn setClipsToBounds:YES];
    [bookinbtn setTitle:@"BAC" forState:UIControlStateNormal];
    [bookinbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bookinbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [bookinbtn addTarget:self action:@selector(visits) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bookinbtn];
    [bookinbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
    [bookinbtn setBackgroundColor:[UIColor whiteColor]] ;
    
    int hig=screenRect.size.height*.20+screenRect.size.width*0.28;
    
    UIButton *visitsbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.36,hig,screenRect.size.width*0.28,screenRect.size.width*0.28)];
    visitsbtn.layer.cornerRadius = screenRect.size.width*0.14;
    [visitsbtn setClipsToBounds:YES];
    [visitsbtn setTitle:@"OCR" forState:UIControlStateNormal];
    [visitsbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [visitsbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [visitsbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:visitsbtn];
    visitsbtn.tag=4;
    [visitsbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
    [visitsbtn setBackgroundColor:[UIColor whiteColor]] ;
    
    hig=hig+screenRect.size.height*.05+screenRect.size.width*0.28;
    UIButton *bookingbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.36,hig,screenRect.size.width*0.28,screenRect.size.width*0.28)];
    bookingbtn.layer.cornerRadius = screenRect.size.width*0.14;
    [bookingbtn setClipsToBounds:YES];
    [bookingbtn setTitle:@"SD" forState:UIControlStateNormal];
    [bookingbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bookingbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [bookingbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bookingbtn];
    bookingbtn.tag=6;
    [bookingbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
    [bookingbtn setBackgroundColor:[UIColor whiteColor]];
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)prospect:(UIButton *)btn
{
//            OCRViewController *mainvc=[[OCRViewController alloc] initWithNibName:@"OCRViewController" bundle:nil];
//            mainvc.tag=btn.tag;
//            [self.navigationController pushViewController:mainvc animated:YES];
}
-(void)visits
{
    BACViewController *mainvc=[[BACViewController alloc] initWithNibName:@"BACViewController" bundle:nil];
    [self.navigationController pushViewController:mainvc animated:YES];
}
-(void)booking
{
    MyBookingViewController *mainvc=[[MyBookingViewController alloc] initWithNibName:@"MyBookingViewController" bundle:nil];
    [self.navigationController pushViewController:mainvc animated:YES];}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
