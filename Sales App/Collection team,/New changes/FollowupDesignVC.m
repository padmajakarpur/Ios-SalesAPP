
#import "FollowupDesignVC.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"

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


@end
