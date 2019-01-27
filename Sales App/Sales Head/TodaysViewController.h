//
//  TodaysViewController.h
//  Sales App
//
//  Created by Infinitum on 07/06/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodaysViewController : UIViewController
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain) IBOutlet NSMutableArray *teamarr;
@property(nonatomic,retain) IBOutlet UISegmentedControl*segmentedControl;
@property(nonatomic,retain) IBOutlet NSString *typestr;

@end
