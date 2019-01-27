//
//  PerformanceViewController.h
//  Sales App
//
//  Created by Infinitum on 21/04/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerformanceViewController : UIViewController
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain) IBOutlet UIScrollView *teamtableview;
@property(nonatomic,retain) IBOutlet NSMutableArray *teamarr;
@end
