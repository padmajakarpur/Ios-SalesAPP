//
//  MainViewController.m
//  CommunicationApp
//
//  Created by mansoor shaikh on 13/04/14.
//  Copyright (c) 2014 MobiWebCode. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "RearViewController.h"
#import "ViewController.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "MyBookingViewController.h"
#import "MyLeadsViewController.h"
#import "CloudSyncViewController.h"
#import "MarketingMaterialViewController.h"
#import "MyVisitsViewController.h"
#import "SalesHeadViewController.h"
#import "ColletionTeamViewController.h"
#import "NewCasesvViewController.h"
@interface MainViewController ()<SWRevealViewControllerDelegate>

@end
@implementation MainViewController
@synthesize viewController = _viewController;
@synthesize appDelegate,index;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - SWRevealViewDelegate

#define LogDelegates 0
- (NSString*)stringFromFrontViewPosition:(FrontViewPosition)position
{
    NSString *str = nil;
    if ( position == FrontViewPositionLeftSideMostRemoved ) str = @"FrontViewPositionLeftSideMostRemoved";
    if ( position == FrontViewPositionLeftSideMost) str = @"FrontViewPositionLeftSideMost";
    if ( position == FrontViewPositionLeftSide) str = @"FrontViewPositionLeftSide";
    if ( position == FrontViewPositionLeft ) str = @"FrontViewPositionLeft";
    if ( position == FrontViewPositionRight ) str = @"FrontViewPositionRight";
    if ( position == FrontViewPositionRightMost ) str = @"FrontViewPositionRightMost";
    if ( position == FrontViewPositionRightMostRemoved ) str = @"FrontViewPositionRightMostRemoved";
    return str;
}
- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}
- (void)revealController:(SWRevealViewController *)revealController animateToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealControllerPanGestureBegan:(SWRevealViewController *)revealController;
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
}

- (void)revealControllerPanGestureEnded:(SWRevealViewController *)revealController;
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
}

- (void)revealController:(SWRevealViewController *)revealController panGestureBeganFromLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController panGestureMovedToLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController panGestureEndedToLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController willAddViewController:(UIViewController *)viewController forOperation:(SWRevealControllerOperation)operation animated:(BOOL)animated
{
    NSLog( @"%@: %@, %d", NSStringFromSelector(_cmd), viewController, operation);
}

- (void)revealController:(SWRevealViewController *)revealController didAddViewController:(UIViewController *)viewController forOperation:(SWRevealControllerOperation)operation animated:(BOOL)animated
{
    NSLog( @"%@: %@, %d", NSStringFromSelector(_cmd), viewController, operation);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    RearViewController *rearViewController = [[RearViewController alloc] init];
    UINavigationController *frontNavigationController;
    
    if ([[prefs objectForKey:@"role_name"] isEqualToString:@"Head"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Front Office Executives"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Front Office Admin"])
    {
    SalesHeadViewController *home=[[SalesHeadViewController alloc]initWithNibName:@"SalesHeadViewController" bundle:nil];
        LoginViewController *lohin=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        if(appDelegate.index==0)
        {
            frontNavigationController = [[UINavigationController alloc] initWithRootViewController:home];
        }
        
        else  if(appDelegate.index==1)
        {
//            appDelegate.rolestr=@"";
//            NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//            [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];

            frontNavigationController = [[UINavigationController alloc] initWithRootViewController:lohin];
            [prefs setObject:@"" forKey:@"user_id"];
        }
    }
  else  if ([[prefs objectForKey:@"role_name"] isEqualToString:@"Collection Team"]) {
        ColletionTeamViewController *home1=[[ColletionTeamViewController alloc]initWithNibName:@"ColletionTeamViewController" bundle:nil];
          NewCasesvViewController *custlist=[[NewCasesvViewController alloc]initWithNibName:@"NewCasesvViewController" bundle:nil];
        LoginViewController *lohin=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        
           if(appDelegate.index==0)
               frontNavigationController = [[UINavigationController alloc] initWithRootViewController:home1];
        
        if(appDelegate.index==1)
        {
            appDelegate.comestr=@"Customer List";
            frontNavigationController = [[UINavigationController alloc] initWithRootViewController:custlist];
        }
        if(appDelegate.index==2)
        {
            appDelegate.comestr=@"Todays Followup";
            frontNavigationController = [[UINavigationController alloc] initWithRootViewController:custlist];
        }
        if(appDelegate.index==3)
        {
            appDelegate.comestr=@"Missed Followup";
            frontNavigationController = [[UINavigationController alloc] initWithRootViewController:custlist];
        }
        if(appDelegate.index==4)
        {
            frontNavigationController = [[UINavigationController alloc] initWithRootViewController:lohin];
            [prefs setObject:@"" forKey:@"user_id"];

        }
    }
    else
    {
        HomeViewController *home=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
        LoginViewController *lohin=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        MyLeadsViewController *leads=[[MyLeadsViewController alloc]initWithNibName:@"MyLeadsViewController" bundle:nil];
        MyBookingViewController *mybooking=[[MyBookingViewController alloc]initWithNibName:@"MyBookingViewController" bundle:nil];
        CloudSyncViewController *sync=[[CloudSyncViewController alloc]initWithNibName:@"CloudSyncViewController" bundle:nil];
        MarketingMaterialViewController *market=[[MarketingMaterialViewController alloc]initWithNibName:@"MarketingMaterialViewController" bundle:nil];
        MyVisitsViewController *visit=[[MyVisitsViewController alloc]initWithNibName:@"MyVisitsViewController" bundle:nil];
        
        if(appDelegate.index==0)
            frontNavigationController = [[UINavigationController alloc] initWithRootViewController:home];
        
        else  if(appDelegate.index==1)
            frontNavigationController = [[UINavigationController alloc] initWithRootViewController:leads];
        
        else  if(appDelegate.index==2)
            frontNavigationController = [[UINavigationController alloc] initWithRootViewController:visit];
        
        else if(appDelegate.index==3)
            frontNavigationController = [[UINavigationController alloc] initWithRootViewController:mybooking];
        
        else if(appDelegate.index==4)
            frontNavigationController = [[UINavigationController alloc] initWithRootViewController:market];
        
//        else if(appDelegate.index==5)
//            frontNavigationController = [[UINavigationController alloc] initWithRootViewController:sync];
        
        else if(appDelegate.index==5)
        {
            frontNavigationController = [[UINavigationController alloc] initWithRootViewController:lohin];
                 [prefs setObject:@"" forKey:@"user_id"];

        }
        else
        {
            frontNavigationController = [[UINavigationController alloc] initWithRootViewController:home];
        }
    }
     UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    revealController.delegate = self;
    self.viewController = revealController;
    [[[UIApplication sharedApplication] delegate] window].rootViewController = self.viewController;
}
//- (void)alertView:(UIAlertView *)alertView
//clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == [alertView cancelButtonIndex]){
//        //cancel clicked ...do your action
//    }else{
//        //reset clicked
//        LoginViewController *lohin=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
//        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//        UINavigationController *frontNavigationController;
//        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:lohin];
//     [prefs setObject:@"" forKey:@"user_id"];
//    }
//}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
   
        if (buttonIndex ==1){
          
        }
    
}
- (BOOL)shouldAutorotate
{
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
