
/*
 
 Copyright (c) 2013 Joan Lluch <joan.lluch@sweetwilliamsl.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 Original code:
 Copyright (c) 2011, Philip Kluz (Philip.Kluz@zuui.org)
 
 */
#import "RearViewController.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
#import "MainViewController.h"
#import "ViewController.h"
#import "MainNavigationController.h"
//#import "UIImage+FontAwesome.h"
//#import "NSString+FontAwesome.h"
//#import "AsyncImageView.h"
@interface RearViewController()

@end

@implementation RearViewController

@synthesize rearTableView = _rearTableView;
@synthesize appDelegate,usernameLabel,rolelbl;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBarHidden=YES;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    UIView* gradview=[[UIView alloc]init];
    [self.view addSubview:gradview];
    
    int width=screenRect.size.width*0.80/3;
    UIImageView *studentProfile=[[UIImageView alloc] initWithFrame:CGRectMake(width,screenRect.size.height*.05,screenRect.size.width*.80/3,screenRect.size.width*.80/3)];
    [studentProfile setBackgroundColor:[UIColor lightGrayColor]];
    studentProfile.layer.cornerRadius = width/2;
    studentProfile.clipsToBounds=YES;
    studentProfile.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:studentProfile];
    studentProfile.image=[UIImage imageNamed:@"account_circle.png"];
    
    //    if (![[prefs objectForKey:@"imgurl"] isEqual:@""]) {
    //
    //        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //        [activityIndicator setCenter: studentProfile.center];
    //        [activityIndicator startAnimating];
    //        [self.view addSubview:activityIndicator];
    //
    //
    //        dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    //        dispatch_async(q, ^{
    //            /* Fetch the image from the server... */
    //            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[prefs objectForKey:@"imgurl"]]];
    //            UIImage *img = [[UIImage alloc] initWithData:data];
    //            dispatch_async(dispatch_get_main_queue(), ^{
    //                /* This is the main thread again, where we set the tableView's image to
    //                 be what we just fetched. */
    //                [activityIndicator removeFromSuperview];
    //                studentProfile.image = img;
    //            });
    //        });
    //
    //  }
    
    //    [studentProfile loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://tuskerconsulting.com/ws_schoolerp/images/%@",[prefs objectForKey:@"image"]]]];
    //
    
    usernameLabel =[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.80/4,screenRect.size.height*0.05+screenRect.size.width*.80/3+05,screenRect.size.width*.80/2, screenRect.size.height*0.07)];
    usernameLabel.textAlignment = NSTextAlignmentCenter;
    usernameLabel.lineBreakMode = NSLineBreakByCharWrapping;
    usernameLabel.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.06];
    [usernameLabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:usernameLabel];
    usernameLabel.text=[prefs objectForKey:@"user_name"];
    
    //    NSString* positionstr1=@"";
    //    NSString* positionstr2=[prefs objectForKey:@"name"];
    //    NSMutableAttributedString *attributedString1 =
    //    [[NSMutableAttributedString alloc] initWithString:positionstr1 attributes:@{NSFontAttributeName : text1Font3,NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //    NSMutableAttributedString *attributedString3 =
    //    [[NSMutableAttributedString alloc] initWithString:positionstr2 attributes:@{NSFontAttributeName : text2Font4,NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //    [attributedString1 appendAttributedString:attributedString3];
    ////
    //
    //    rolelbl =[[UILabel alloc]initWithFrame:CGRectMake(10,screenRect.size.height*0.10+screenRect.size.width*.80/3+10,200, screenRect.size.height*0.07)];
    //    rolelbl.textAlignment = NSTextAlignmentCenter;
    //    rolelbl.lineBreakMode = NSLineBreakByWordWrapping;
    //    rolelbl.numberOfLines = 0;
    //    rolelbl.textAlignment = NSTextAlignmentLeft;
    //    [self.view addSubview:rolelbl];
    //   // rolelbl.text=[prefs objectForKey:@"name"];
    //    [rolelbl setAttributedText:attributedString1];
    
    [_rearTableView setFrame:CGRectMake(0,screenRect.size.height*0.12+screenRect.size.width*.80/3+10, screenRect.size.width+300,screenRect.size.height)];
    _rearTableView.scrollEnabled=YES;
    _rearTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.rearTableView.backgroundColor=[UIColor whiteColor];
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        NSLog(@"device is ipad"); /* Device is iPad */
    }
    [_rearTableView setFrame:CGRectMake(0,screenRect.size.height*0.12+screenRect.size.width*.80/3+10, screenRect.size.width+300,screenRect.size.height-screenRect.size.height*0.12+screenRect.size.width*.80/3+10)];
        _rearTableView.scrollEnabled=YES;

   // }
    
    //    UIFont *customFontdregs = [UIFont fontWithName:@"Open Sans" size:15];
    //    UIButton *loginBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*.05+width+10,(width+(width/2))-10,screenRect.size.height*.04)];
    //    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    //   // [loginBtn setTitle:@"Login" forState:UIControlStateNormal];
    //    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [loginBtn.titleLabel setFont:customFontdregs];
    //    loginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //    [self.view addSubview:loginBtn];
    
    //    UILabel*  lineLabel =[[UILabel alloc]initWithFrame:CGRectMake((width+(width/2)),screenRect.size.height*.05+width+10,1, screenRect.size.height*.04)];
    //    lineLabel.textAlignment = NSTextAlignmentCenter;
    //    [lineLabel setBackgroundColor:[UIColor grayColor]];
    //    [self.view addSubview:lineLabel];
    
    //    UIButton *singupBtn=[[UIButton alloc]initWithFrame:CGRectMake((width+(width/2))+10,screenRect.size.height*.05+width+10,width+(width/2),screenRect.size.height*.04)];
    //    [singupBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    //  //  [singupBtn setTitle:@"Sign Up" forState:UIControlStateNormal];
    //    [singupBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [singupBtn.titleLabel setFont:customFontdregs];
    //    singupBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //    [self.view addSubview:singupBtn];
    
    NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSLog(@"appVersionString:-%@",appVersionString);
    
    //   [self.view addSubview:versionLbl];
}
-(void)loginAction{
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=10;
    MainNavigationController *navController = [[MainNavigationController alloc] initWithRootViewController:mainvc];
    navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
}
-(void)registerAction{
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=11;
    MainNavigationController *navController = [[MainNavigationController alloc] initWithRootViewController:mainvc];
    navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
- (BOOL)shouldAutorotate
{
    return YES;
}

#pragma marl - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
 if ([appDelegate.rolestr isEqualToString:@"SalesHead"]||[appDelegate.rolestr isEqualToString:@"Front Office Executives"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Front Office Admin"])
    return 2;
    
 if ([[prefs objectForKey:@"role_name"] isEqualToString:@"Collection Team"])
     return 5;
    
    else
        return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    cell.textLabel.textColor=[UIColor whiteColor];
    
//    if (indexPath.row==0) {
//        UILabel *line=[[UILabel alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,1)];
//        line.backgroundColor=[UIColor lightGrayColor];
//        [cell.contentView addSubview:line];
//    }
    
    UILabel *pictureLbl=[[UILabel alloc]initWithFrame:CGRectMake(15,10,30,30)];
    pictureLbl.textColor=[UIColor whiteColor];
    pictureLbl.layer.cornerRadius=07;
    pictureLbl.layer.masksToBounds=YES;
    pictureLbl.textAlignment = NSTextAlignmentCenter;
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:20];
    pictureLbl.font =customFontdregs;
    
    UILabel *menuItemTextLabel=[[UILabel alloc] initWithFrame:CGRectMake(60, 5, 250, 45)];
    menuItemTextLabel.font = [UIFont fontWithName:@"Open Sans" size:16];
    menuItemTextLabel.textColor=[UIColor blackColor];
    cell.backgroundColor=[UIColor clearColor];
    
     if ([[prefs objectForKey:@"role_name"] isEqualToString:@"Head"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Front Office Executives"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Front Office Admin"])
    {
        if (row == 0)
        {
            pictureLbl.backgroundColor=[UIColor colorWithHexString:@"#66023c"];
            pictureLbl.text = @"\uE88A";
            menuItemTextLabel.text = @"Home";
        }
        if (row == 1)
        {
            pictureLbl.backgroundColor=[UIColor colorWithHexString:@"#ea5959"];
            pictureLbl.text = @"\uE8AC";
            menuItemTextLabel.text = @"Sign Out";
        }
    }
  else  if ([[prefs objectForKey:@"role_name"] isEqualToString:@"Collection Team"]) {
        if (row == 0)
        {
            pictureLbl.backgroundColor=[UIColor colorWithHexString:@"#66023c"];
            pictureLbl.text = @"\uE88A";
            menuItemTextLabel.text = @"Home";
        }
        if (row == 1)
        {
            pictureLbl.backgroundColor=[UIColor colorWithHexString:@"#00ccff"];
            pictureLbl.text = @"\uE8E1";
            menuItemTextLabel.text = @"Customer List";
        }
        if (row == 2)
        {
            pictureLbl.backgroundColor=[UIColor colorWithHexString:@"#ffc057"];
            pictureLbl.text = @"\uE8F8";
            menuItemTextLabel.text = @"Todays Followup";
        }
        if (row == 3)
        {
            pictureLbl.backgroundColor=[UIColor colorWithHexString:@"#9966cc"];
            pictureLbl.text = @"\uE02F";
            menuItemTextLabel.text = @"Missed Followup";
        }
       
        if (row == 4)
        {
            pictureLbl.backgroundColor=[UIColor colorWithHexString:@"#ea5959"];
            pictureLbl.text = @"\uE8AC";
            menuItemTextLabel.text = @"Sign Out";
        }
    }
    else
    {
    if (row == 0)
    {
        pictureLbl.backgroundColor=[UIColor colorWithHexString:@"#66023c"];
        pictureLbl.text = @"\uE88A";
        menuItemTextLabel.text = @"Home";
    }
    if (row == 1)
    {
        pictureLbl.backgroundColor=[UIColor colorWithHexString:@"#00ccff"];
        pictureLbl.text = @"\uE8E1";
        menuItemTextLabel.text = @"My Leads";
    }
    if (row == 2)
    {
        pictureLbl.backgroundColor=[UIColor colorWithHexString:@"#ffc057"];
        pictureLbl.text = @"\uE8F8";
        menuItemTextLabel.text = @"My Visits";
    }
    if (row == 3)
    {
        pictureLbl.backgroundColor=[UIColor colorWithHexString:@"#9966cc"];
        pictureLbl.text = @"\uE02F";
        menuItemTextLabel.text = @"My Bookings";
    }
    if (row == 4)
    {
        pictureLbl.backgroundColor=[UIColor colorWithHexString:@"#00cccc"];
        pictureLbl.text = @"\uE80D";
        menuItemTextLabel.text = @"Marketing Material";
    }
    if (row == 5)
    {
        pictureLbl.backgroundColor=[UIColor colorWithHexString:@"#ea5959"];
        pictureLbl.text = @"\uE8AC";
        menuItemTextLabel.text = @"Sign Out";
    }
    }
    [cell.contentView addSubview:menuItemTextLabel];
    [cell.contentView addSubview:pictureLbl];
    //    cell.selectionStyle = UITableViewCellSelectionStyleGray;
//    UILabel *line=[[UILabel alloc] initWithFrame:CGRectMake(0,49,self.view.bounds.size.width,1)];
 //   line.backgroundColor=[UIColor lightGrayColor];
    //  cell.contentView.backgroundColor=[UIColor whiteColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell.contentView addSubview:line];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    if (indexPath.row==5) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Are you sure do you want to logout?" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        alert.tag=indexPath.row;
        alert.delegate=self;
        [alert show];
    }
    else
    {
        NSInteger row = indexPath.row;
        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        appDelegate.index=(int)row;
        MainNavigationController *navController = [[MainNavigationController alloc] initWithRootViewController:mainvc];
        navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
    }
}
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==1){
        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        appDelegate.index=alertView.tag;
        MainNavigationController *navController = [[MainNavigationController alloc] initWithRootViewController:mainvc];
        navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
    [_rearTableView reloadData];
}

@end

