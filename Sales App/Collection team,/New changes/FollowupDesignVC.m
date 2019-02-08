
#import "FollowupDesignVC.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
#import <AFNetworking.h>

@interface FollowupDesignVC (){
    CGRect screenRect;
}

@end

@implementation FollowupDesignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    screenRect = [[UIScreen mainScreen] bounds];
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.70,screenRect.size.height*0.07)]; //64
   // horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Follow up";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    
    SWRevealViewController *revealController = [self revealViewController];
    //    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE5D2" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];
    
    _lblTodayFolloCnt.layer.masksToBounds = YES;
    _lblTodayFolloCnt.layer.cornerRadius = 15;
    
    _lblFutureFolloCnt.layer.masksToBounds = YES;
    _lblFutureFolloCnt.layer.cornerRadius = 15;
    
    _lblMissedFolloCnt.layer.masksToBounds = YES;
    _lblMissedFolloCnt.layer.cornerRadius = 15;
    
    [self getcount];
}

- (IBAction)btnTodaysFollowupClicked:(id)sender {
    FollowUpViewController *mainvc=[[FollowUpViewController alloc] initWithNibName:@"FollowUpViewController" bundle:nil];
     mainvc.comestr=@"followup";
    mainvc.followupType = @"getsynctodayfollowup.php";
    [self.navigationController pushViewController:mainvc animated:YES];
}
- (IBAction)btnMissedFollowupClicked:(id)sender {
    FollowUpViewController *mainvc=[[FollowUpViewController alloc] initWithNibName:@"FollowUpViewController" bundle:nil];
    mainvc.comestr=@"followup";
    mainvc.followupType = @"getsynctmissfollowup.php";
    [self.navigationController pushViewController:mainvc animated:YES];
}
- (IBAction)btnFutureFollowupClicked:(id)sender {
    FollowUpViewController *mainvc=[[FollowUpViewController alloc] initWithNibName:@"FollowUpViewController" bundle:nil];
    mainvc.comestr=@"followup";
    mainvc.followupType = @"getsynctfuturefollowup.php";
    [self.navigationController pushViewController:mainvc animated:YES];
}

-(void)getcount
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"userid"];

    [params setObject:[prefs objectForKey:@"url"] forKey:@"url"];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getCounts.php?",[prefs objectForKey:@"Link"]];

    //[indicator startAnimating];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];

        NSLog(@"JSON: %@", userDict);
        NSMutableDictionary* dic =[userDict objectForKey:@"counts"];
        NSMutableDictionary *mutableDict = [dic mutableCopy];
        for (NSString *key in [dic allKeys]) {
            if ([dic[key] isEqual:[NSNull null]]) {
                mutableDict[key] = @"0";
            }
        }

        dic = [mutableDict copy];
        if (![[dic objectForKey:@"ffollowup"]isEqualToString:@"0"] &&[dic objectForKey:@"ffollowup"]!=nil) {
            _lblFutureFolloCnt.text=[dic objectForKey:@"ffollowup"];
            _lblFutureFolloCnt.hidden=NO;
//           if (abs([[dic objectForKey:@"bookings"] intValue])> 99) {
//
//               CGSize stringsize = [[dic objectForKey:@"bookings"] sizeWithFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];
//
//                bookingcountlbl.frame =CGRectMake(screenRect.size.width*0.54,hight,stringsize.width+ screenRect.size.width*0.03,screenRect.size.width*0.08);
        
        }else{
            _lblFutureFolloCnt.hidden=YES;
       }

        if (![[dic objectForKey:@"mfollowup"]isEqualToString:@"0"] &&[dic objectForKey:@"mfollowup"]!=nil) {
            _lblMissedFolloCnt.text=[dic objectForKey:@"mfollowup"];
            _lblMissedFolloCnt.hidden=NO;
//            if (abs([[dic objectForKey:@"visits"] intValue])> 99) {
//
//                CGSize stringsize = [[dic objectForKey:@"visits"] sizeWithFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];
//
//                visitscountlbl.frame =CGRectMake(screenRect.size.width*0.24,hight,stringsize.width+ screenRect.size.width*0.03,screenRect.size.width*0.08);
        
        }else{
                        _lblMissedFolloCnt.hidden=YES;
        }
        
       if (![[dic objectForKey:@"tfollowup"]isEqualToString:@"0"] &&[dic objectForKey:@"tfollowup"]!=nil) {
            _lblTodayFolloCnt.text=[dic objectForKey:@"tfollowup"];
           self->_lblTodayFolloCnt.hidden=NO;

//            if (abs([[dic objectForKey:@"followups"] intValue])> 99) {
//                CGSize stringsize = [[dic objectForKey:@"followups"] sizeWithFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];
            
//                followupslbl.frame =CGRectMake(screenRect.size.width*0.87,hight,stringsize.width+ screenRect.size.width*0.03,screenRect.size.width*0.08);
       
       }else{
           self->_lblTodayFolloCnt.hidden=YES;
       }
        
       // }
       // hight=hight+screenRect.size.height*0.17;
        
//        if (![[dic objectForKey:@"bac"]isEqualToString:@"0"] &&[dic objectForKey:@"bac"]!=nil) {
//            baccountlbl.text=[dic objectForKey:@"bac"];
//            baccountlbl.hidden=NO;
//            if (abs([[dic objectForKey:@"bac"] intValue])> 99) {
//                CGSize stringsize = [[dic objectForKey:@"bac"] sizeWithFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];
//
//                baccountlbl.frame =CGRectMake(screenRect.size.width*0.24,hight,screenRect.size.width*0.08,screenRect.size.width*0.08);
//            }
//        }
//
//        if (![[dic objectForKey:@"rox"]isEqualToString:@"0"] &&[dic objectForKey:@"rox"]!=nil) {
//            roxcountlbl.text=[dic objectForKey:@"rox"];
//            roxcountlbl.hidden=NO;
//            if (abs([[dic objectForKey:@"rox"] intValue])> 99) {
//                CGSize stringsize = [[dic objectForKey:@"rox"] sizeWithFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];
//
//                roxcountlbl.frame=CGRectMake(screenRect.size.width*0.55,hight,stringsize.width+ screenRect.size.width*0.03,screenRect.size.width*0.08);
//            }
//        }
//        hight=hight+screenRect.size.height*0.17;
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
       // [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

@end
