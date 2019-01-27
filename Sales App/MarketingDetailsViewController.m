//
//  MarketingDetailsViewController.m
//  Sales App
//
//  Created by Infinitum on 30/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "MarketingDetailsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
#import "BroucherViewController.h"
#import "RemainingViewController.h"
@interface MarketingDetailsViewController ()

@end

@implementation MarketingDetailsViewController
@synthesize dict,collectioonview,indicator,imagearr,tittlearr,resuldict,imageview;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#d3d3d3"];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:30];
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE314" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"";
    [horizontallbl setTextColor:[UIColor blackColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    
  imageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.01,screenRect.size.height*0.10,screenRect.size.width*0.98,screenRect.size.height*0.30)];
    [self.view addSubview:imageview];
       NSString *decoded = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)[dict objectForKey:@"Image"], CFSTR(""), kCFStringEncodingUTF8);
    [imageview sd_setImageWithURL:[NSURL URLWithString:decoded]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    UILabel *linelbl1 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.35,screenRect.size.width*0.70,screenRect.size.height*0.05)];
    linelbl1.font=[UIFont boldSystemFontOfSize:16];
    linelbl1.text=[dict objectForKey:@"name"];
    [linelbl1 setTextColor:[UIColor whiteColor]];
    linelbl1.backgroundColor=[UIColor clearColor];
    linelbl1.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:linelbl1];
    
    UIImageView * logoview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.40,screenRect.size.width*0.60,screenRect.size.height*0.09)];
    [self.view addSubview:logoview];
    NSString *decoded1 = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)[dict objectForKey:@"Logo"], CFSTR(""), kCFStringEncodingUTF8);

    [logoview sd_setImageWithURL:[NSURL URLWithString:decoded1]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    logoview.contentMode=UIViewContentModeScaleAspectFit;
    
    imagearr=[[NSMutableArray alloc]initWithObjects:@"brochure Icon.png",@"price list_1_Icon.png",@"location map Icon.png",@"unit plan Icon.png",@"floor plan Icon.png",@"master plan icon.png",@"news letter_1_Icon.png",@"media icon.png",@"customer testimonial Icon.png", nil];
    tittlearr=[[NSMutableArray alloc]initWithObjects:@"BROCHURE",@"PRICE LIST",@"LOCATION MAP",@"UNIT PLAN",@"FLOOR PLAN",@"MASTER PLAN",@"NEWS LETTER",@"MEDIA",@"CUSTUMER TESTIMONIALS", nil];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeZero;
    layout.footerReferenceSize = CGSizeZero;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    collectioonview=[[UICollectionView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0, screenRect.size.height*0.49, screenRect.size.width,screenRect.size.height*0.51)
                                       collectionViewLayout:layout];
    [collectioonview setDataSource:self];
    [collectioonview setDelegate:self];
    collectioonview.scrollEnabled=YES;
    [collectioonview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
//    [collectioonview registerClass:[UICollectionReusableView class]
//        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    collectioonview.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:collectioonview];
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(screenRect.size.width *0.35, screenRect.size.height *0.40, screenRect.size.width *0.30,screenRect.size.width *0.30);
    indicator.color=[UIColor whiteColor];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    indicator.layer.cornerRadius=15.0f;

}
-(void)viewWillAppear:(BOOL)animated
{
    if (resuldict.count==0) {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString*   urlString =[NSString stringWithFormat:@"http://13.126.129.245/xrbia_portal/public/api/cp/marketing/%@",[dict objectForKey:@"id"]];
        //    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [indicator startAnimating];
        [manager GET:urlString parameters:@"" progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSLog(@"JSON: %@", userDict);
            resuldict=[userDict objectForKey:@"result"];
            [indicator stopAnimating];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return imagearr.count;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    return CGSizeMake(screenRect.size.width*0.025,screenRect.size.width*0.025);
//
//}

- (UICollectionViewCell *)collectionView:(UICollectionView* )collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    ;

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.005,screenRect.size.height*0.004,screenRect.size.width*0.323,screenRect.size.height*0.166)];
    view1.backgroundColor=[UIColor whiteColor];
    [cell.contentView addSubview:view1];
    
    
 UIImageView*  imageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.02,screenRect.size.width*0.213,screenRect.size.height*0.08)];
    [view1 addSubview:imageview];
    imageview.image=[UIImage imageNamed:[imagearr objectAtIndex:indexPath.row]];
    imageview.contentMode=UIViewContentModeScaleAspectFit;

    //
    UILabel *linelbl1 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.01,screenRect.size.height*0.10,screenRect.size.width*0.313,screenRect.size.height*0.066)];
    linelbl1.font=[UIFont systemFontOfSize:12];
    linelbl1.text=[tittlearr objectAtIndex:indexPath.row];
    [linelbl1 setTextColor:[UIColor blackColor]];
    linelbl1.textAlignment = NSTextAlignmentCenter;
    linelbl1.lineBreakMode = NSLineBreakByWordWrapping;
    linelbl1.numberOfLines = 0;
    [view1 addSubview:linelbl1];
    
    cell.contentView.backgroundColor=[UIColor clearColor];
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView* )collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath* )indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return CGSizeMake(screenRect.size.width*.333, screenRect.size.height*0.17);
}

-(void)collectionView:(UICollectionView* )collectionView didSelectItemAtIndexPath:(NSIndexPath* )indexPath
{
    
    if (indexPath.row==0) {
        BroucherViewController *mainvc=[[BroucherViewController alloc] initWithNibName:@"BroucherViewController" bundle:nil];
        mainvc.image=imageview.image;
        mainvc.responsedict=[resuldict objectForKey:@"Brochure"];
        mainvc.namestr=[dict objectForKey:@"name"];
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    else{
    NSMutableArray * arr=[[NSMutableArray alloc]init];
    if (indexPath.row==1)
        arr=[resuldict objectForKey:@"Price_List"];
    if (indexPath.row==2)
        arr=[resuldict objectForKey:@"Location_Map"];
    if (indexPath.row==3)
        arr=[resuldict objectForKey:@"Unit_Plan"];
    if (indexPath.row==4)
        arr=[resuldict objectForKey:@"Floor_Plan"];
    if (indexPath.row==5)
        arr=[resuldict objectForKey:@"Master_Plan"];
    if (indexPath.row==6)
        arr=[resuldict objectForKey:@"News_Letter"];
    if (indexPath.row==7)
        arr=[resuldict objectForKey:@"Media"];
    if (indexPath.row==8)
        arr=[resuldict objectForKey:@"Customer_Testimonial"];
    
    if (arr.count>0) {
        RemainingViewController *mainvc=[[RemainingViewController alloc] initWithNibName:@"RemainingViewController" bundle:nil];
        mainvc.imagearray=[arr mutableCopy];
        if (indexPath.row==6) {
            mainvc.img=imageview.image;
            mainvc.prosjectstr=[dict objectForKey:@"name"];
        }
        mainvc.namestr=[tittlearr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:[NSString stringWithFormat:@"Sorry there is no %@ avaible for this project",[tittlearr objectAtIndex:indexPath.row]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    }
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back
{
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
