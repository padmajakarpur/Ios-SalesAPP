//
//  RemainingViewController.m
//  Sales App
//
//  Created by Infinitum on 31/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "RemainingViewController.h"
#import "UIColor+Expanded.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ViewimageViewController.h"
@interface RemainingViewController ()

@end

@implementation RemainingViewController
@synthesize collectioonview,imagearray,namestr,prosjectstr,img,tableViewHome;
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
    
    UILabel *broucherlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.07)];
    broucherlbl.font=[UIFont boldSystemFontOfSize:17];
    broucherlbl.text=namestr;
    [broucherlbl setTextColor:[UIColor whiteColor]];
    broucherlbl.backgroundColor=[UIColor colorWithHexString:@"#004c00"];
    broucherlbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:broucherlbl];
    
   
    
    if ([namestr isEqualToString:@"NEWS LETTER"]) {
      UIImageView*  imageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.30)];
        [self.view addSubview:imageview];
        imageview.image=img;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.headerReferenceSize = CGSizeZero;
        layout.footerReferenceSize = CGSizeZero;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        collectioonview=[[UICollectionView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0, screenRect.size.height*0.17, screenRect.size.width,screenRect.size.height*0.83)
                                           collectionViewLayout:layout];
        [collectioonview setDataSource:self];
        [collectioonview setDelegate:self];
        collectioonview.scrollEnabled=YES;
        [collectioonview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        //  [collectioonview registerClass:[UICollectionReusableView class]
        //     forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        collectioonview.backgroundColor=[UIColor clearColor];
        [self.view addSubview:collectioonview];
    broucherlbl.frame=CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.40,screenRect.size.width,screenRect.size.height*0.07);
        
        collectioonview.frame=CGRectMake(screenRect.size.width*0.0, screenRect.size.height*0.47, screenRect.size.width,screenRect.size.height*0.51);
    }
    
    else
    {
        tableViewHome = [[UITableView alloc] init];
        [tableViewHome setFrame:CGRectMake(screenRect.size.width*0.03,screenRect.size.height*.18, screenRect.size.width*.94,screenRect.size.height*.82)];
        tableViewHome.backgroundColor=[UIColor clearColor];
        tableViewHome.delegate = self;
        tableViewHome.dataSource = self;
        tableViewHome.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableViewHome];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return imagearray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    UIFont * font1 =[UIFont fontWithName:@"Open Sans" size:screenRect.size.width*.04];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.frame = CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.0,screenRect.size.width*0.60,screenRect.size.height*0.25);
        [cell.contentView addSubview:indicator];
        [indicator startAnimating];
        
        UIImageView  * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.0,screenRect.size.width*0.60,screenRect.size.height*0.25)];
        [cell.contentView addSubview:imageview];
        
        [imageview sd_setImageWithURL:[NSURL URLWithString:[imagearray objectAtIndex:indexPath.row]]
                     placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                [indicator removeFromSuperview];
                            }];
        
        imageview.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
        
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.contentMode= UIViewContentModeLeft;
        
        cell.backgroundColor = [UIColor clearColor];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewimageViewController *mainvc=[[ViewimageViewController alloc] initWithNibName:@"ViewimageViewController" bundle:nil];
    mainvc.urlstr=[imagearray objectAtIndex:indexPath.row];
    [self.navigationController presentViewController:mainvc animated:YES completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height*0.27;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return imagearray.count;
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

        NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];;
        if ([namestr isEqualToString:@"NEWS LETTER"]) {
            dict=[imagearray objectAtIndex:indexPath.row];
            
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.005,screenRect.size.height*0.001,screenRect.size.width*0.495,screenRect.size.height*0.198)];
            view.backgroundColor=[UIColor whiteColor];
            [cell.contentView addSubview:view];
            
            UIImageView  * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.07,screenRect.size.width*0.30,screenRect.size.height*0.06)];
            [cell.contentView addSubview:imageview];
            imageview.image=[UIImage imageNamed:@"Xrbia Logo.png"];
            imageview.backgroundColor=[UIColor whiteColor];
            imageview.userInteractionEnabled=YES;
            cell.contentView.backgroundColor=[UIColor redColor];
            
            UIImageView  * youtubeimg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.05,screenRect.size.width*0.10,screenRect.size.height*0.05)];
            [cell.contentView addSubview:youtubeimg];
            youtubeimg.userInteractionEnabled=YES;
            youtubeimg.contentMode=UIViewContentModeScaleAspectFill;
            youtubeimg.image=[UIImage imageNamed:@"if_youtube_317714 (1).png"];
            youtubeimg.backgroundColor=[UIColor whiteColor];
            
            UILabel *broucherlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.005,screenRect.size.height*0.15,screenRect.size.width*0.495,screenRect.size.height*0.05)];
            broucherlbl.font=[UIFont boldSystemFontOfSize:17];
            broucherlbl.text=[dict objectForKey:@"month"];
            [broucherlbl setTextColor:[UIColor whiteColor]];
            broucherlbl.backgroundColor=[UIColor lightGrayColor];
            broucherlbl.userInteractionEnabled=YES;
            broucherlbl.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:broucherlbl];
        }
        else
        {
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            indicator.frame = CGRectMake(screenRect.size.width*0.01,screenRect.size.height*0.0,screenRect.size.width*0.48,screenRect.size.height*0.20);
            [cell.contentView addSubview:indicator];
            [indicator startAnimating];
            
            UIImageView  * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.01,screenRect.size.height*0.0,screenRect.size.width*0.48,screenRect.size.height*0.20)];
            [cell.contentView addSubview:imageview];
            
            [imageview sd_setImageWithURL:[NSURL URLWithString:[imagearray objectAtIndex:indexPath.row]]
                         placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                    [indicator removeFromSuperview];
                                }];
            
            imageview.backgroundColor=[UIColor clearColor];
            cell.contentView.backgroundColor=[UIColor clearColor];
        }
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView* )collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath* )indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return CGSizeMake(screenRect.size.width*.50, screenRect.size.height*0.20);
}
-(void)collectionView:(UICollectionView* )collectionView didSelectItemAtIndexPath:(NSIndexPath* )indexPath
{
    if ([namestr isEqualToString:@"NEWS LETTER"]) {
      NSMutableDictionary*  dict=[imagearray objectAtIndex:indexPath.row];
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [[UIApplication sharedApplication] openURL:[ NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@",[dict objectForKey:@"url"]]] options:@{} completionHandler:NULL];
        }
    }
    else{
    ViewimageViewController *mainvc=[[ViewimageViewController alloc] initWithNibName:@"ViewimageViewController" bundle:nil];
    mainvc.urlstr=[imagearray objectAtIndex:indexPath.row];
    [self.navigationController presentViewController:mainvc animated:YES completion:nil];
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
