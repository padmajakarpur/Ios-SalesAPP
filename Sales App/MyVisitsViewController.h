//
//  MyVisitsViewController.h
//  Sales App
//
//  Created by Infinitum on 01/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface MyVisitsViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (retain, nonatomic)  IBOutlet UIView * searchview;
@property (retain, nonatomic)  IBOutlet UITextField *searchtext;
@property (retain, nonatomic)  IBOutlet NSMutableArray * visitarr,*totalarr;
@end

