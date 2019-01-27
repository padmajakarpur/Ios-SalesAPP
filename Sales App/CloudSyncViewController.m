//
//  CloudSyncViewController.m
//  Sales App
//
//  Created by Infinitum on 16/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "CloudSyncViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
#import "HomeViewController.h"
@interface CloudSyncViewController ()

@end

@implementation CloudSyncViewController
@synthesize appDelegate,indicator;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    appDelegate=[[UIApplication sharedApplication] delegate];

    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];
    
    //  [self generatenavigation];
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE88A" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];
    
    UIButton *Createvoucherbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.61,screenRect.size.width*0.80,screenRect.size.height*0.07)];
    Createvoucherbtn.layer.cornerRadius = 4.0f;
    [Createvoucherbtn setClipsToBounds:YES];
    [Createvoucherbtn setTitle:@"Cloud Sync" forState:UIControlStateNormal];
    [Createvoucherbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Createvoucherbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    Createvoucherbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [Createvoucherbtn addTarget:self action:@selector(sync) forControlEvents:UIControlEventTouchUpInside];
    [Createvoucherbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.05]];
    [Createvoucherbtn setBackgroundColor:[UIColor blueColor]] ;
    [self.view addSubview:Createvoucherbtn];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    horizontallbl.text=@"Cloud Sync.";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:horizontallbl];
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(screenRect.size.width *0.35, screenRect.size.height *0.40, screenRect.size.width *0.30,screenRect.size.width *0.30);
    indicator.color=[UIColor whiteColor];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    indicator.layer.cornerRadius=15.0f;    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back
{
    HomeViewController *mainvc=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:mainvc animated:YES];
    
}
-(void)sync
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (appDelegate.syncleadarr.count>0) {
    NSMutableDictionary * data=[[NSMutableDictionary alloc]init];
    [data setObject:[prefs objectForKey:@"username"] forKey:@"username"];
    [data setObject:[prefs objectForKey:@"password"] forKey:@"password"];
    [data setObject:[prefs objectForKey:@"user_id"]  forKey:@"usersimplecrmId"];
         [data setObject:[prefs objectForKey:@"url"] forKey:@"url"];
    [data setObject:@"Leads"  forKey:@"module_name"];

    NSMutableDictionary *jsonDict=[[NSMutableDictionary alloc]init];
    [jsonDict setObject:@"25"forKey:@"ID"];
    NSMutableArray *arr =[appDelegate.syncleadarr mutableCopy];
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
      
            for (int i=0; i<arr.count; i++) {
             
                    if ([recordarr containsObject:[[arr objectAtIndex:i] objectForKey:@"mobile_id_c" ]])
                    {
                        [appDelegate.syncleadarr removeObject:[arr objectAtIndex:i]];
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Sync. Sucessfully Done."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                
  //              }
                else
                {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Sync. failed."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
        
        [ indicator stopAnimating];

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [indicator stopAnimating];
    }];
    }
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
