//
//  MyBookingViewController.h
//  Sales App
//
//  Created by Infinitum on 07/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface MyBookingViewController : UIViewController
{
    NSArray*   imagearr;
}
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
//@property(nonatomic,retain)AppDelegate * appDelegate;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (retain, nonatomic) IBOutlet NSMutableArray *bookingarr,*totalarr;
@property (retain, nonatomic) IBOutlet NSString * comestr;
@property (retain, nonatomic)  IBOutlet UITextField *searchtext;
@property (retain, nonatomic)  IBOutlet UIView * searchview;

@end
