//
//  MarketingMaterialViewController.m
//  Sales App
//
//  Created by Infinitum on 30/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "MarketingMaterialViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MarketingDetailsViewController.h"
#import "SWRevealViewController.h"

@interface MarketingMaterialViewController ()

@end

@implementation MarketingMaterialViewController
@synthesize indicator,resultarr,collectioonview;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    resultarr=[[NSMutableArray alloc]init];
    
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#d3d3d3"];
    
    SWRevealViewController *revealController = [self revealViewController];
    //    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];

    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE5D2" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];;
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"All Projects";
    [horizontallbl setTextColor:[UIColor blackColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeZero;
    layout.footerReferenceSize = CGSizeZero;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    collectioonview=[[UICollectionView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0, screenRect.size.height*0.11, screenRect.size.width,screenRect.size.height*0.89)
                                       collectionViewLayout:layout];
    [collectioonview setDataSource:self];
    [collectioonview setDelegate:self];
    collectioonview.scrollEnabled=YES;
    [collectioonview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [collectioonview registerClass:[UICollectionReusableView class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    collectioonview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:collectioonview];
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(screenRect.size.width *0.35, screenRect.size.height *0.40, screenRect.size.width *0.30,screenRect.size.width *0.30);
    indicator.color=[UIColor whiteColor];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    indicator.layer.cornerRadius=15.0f;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return resultarr.count;
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
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSMutableDictionary *dict=[resultarr objectAtIndex:indexPath.row];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }

    UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.01,screenRect.size.height*0.0,screenRect.size.width*0.48,screenRect.size.height*0.20)];
    [cell.contentView addSubview:imageview];

    UIActivityIndicatorView *activityindicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityindicator.frame = CGRectMake(screenRect.size.width*0.01,screenRect.size.height*0.0,screenRect.size.width*0.48,screenRect.size.height*0.20);
    [cell.contentView addSubview:activityindicator];
    [activityindicator startAnimating];
    NSString *decoded = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)[dict objectForKey:@"Image"], CFSTR(""), kCFStringEncodingUTF8);

    [imageview sd_setImageWithURL:[NSURL URLWithString:decoded]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            [activityindicator removeFromSuperview];
                        }];
    
    NSString *decoded1 = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)[dict objectForKey:@"Logo"], CFSTR(""), kCFStringEncodingUTF8);
    
    UIImageView * logoview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.01,screenRect.size.height*0.0,screenRect.size.width*0.30,screenRect.size.height*0.06)];
    [cell.contentView addSubview:logoview];
    [logoview sd_setImageWithURL:[NSURL URLWithString:decoded1]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    logoview.contentMode=UIViewContentModeScaleAspectFit;
    logoview.backgroundColor=[UIColor whiteColor];

//    UILabel *linelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.0,screenRect.size.width*0.20,screenRect.size.height*0.07)];
//    linelbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
//    linelbl2.text=[NSString stringWithFormat:@"Floor %ld",(long)indexPath.row];
//    [linelbl2 setTextColor:[UIColor blackColor]];
//    linelbl2.backgroundColor=[UIColor clearColor];
//    linelbl2.textAlignment = NSTextAlignmentCenter;
//    [cell.contentView addSubview:linelbl2];
//    linelbl2.layer.borderColor = [UIColor blackColor].CGColor;
//    linelbl2.layer.borderWidth = 1.0;

    UILabel *linelbl1 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.16,screenRect.size.width*0.40,screenRect.size.height*0.04)];
    linelbl1.font=[UIFont systemFontOfSize:14];
    linelbl1.text=[dict objectForKey:@"name"];
    [linelbl1 setTextColor:[UIColor whiteColor]];
    linelbl1.backgroundColor=[UIColor clearColor];
    linelbl1.textAlignment = NSTextAlignmentLeft;
    [cell.contentView addSubview:linelbl1];
    
    cell.contentView.backgroundColor=[UIColor clearColor];
    return cell;
}
- (CGSize)collectionView:(UICollectionView* )collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath* )indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return CGSizeMake(screenRect.size.width*.50, screenRect.size.height*0.205);
}
-(void)collectionView:(UICollectionView* )collectionView didSelectItemAtIndexPath:(NSIndexPath* )indexPath
{
    MarketingDetailsViewController *mainvc=[[MarketingDetailsViewController alloc] initWithNibName:@"MarketingDetailsViewController" bundle:nil];
    mainvc.dict=[resultarr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:mainvc animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    if (resultarr.count==0) {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //    NSString*   urlString = @"http://13.126.129.245/xrbia_portal/public/api/cp/marketing";
        NSString*   urlString = @"http://13.126.129.245/xrbia/index.php?";
       //
            NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:[prefs objectForKey:@"username"]  forKey:@"username"];
        [params setObject:@"getMarketingMaterial"  forKey:@"entryPoint"];
        [params setObject:[prefs objectForKey:@"password"]  forKey:@"password"];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [indicator startAnimating];
        [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSLog(@"JSON: %@", userDict);
            
            NSMutableArray *temparr=[[userDict objectForKey:@"Android"] objectForKey:@"Projects"];
            for (int i=0; i<temparr.count;i++ ) {
                NSDictionary *dict=[temparr objectAtIndex:i];
                if (dict.count==4) {
                    [resultarr addObject:dict];
                }
            }
            [indicator stopAnimating];
            [collectioonview reloadData];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
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
