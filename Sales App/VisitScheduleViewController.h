//
//  VisitScheduleViewController.h
//  Sales App
//
//  Created by Infinitum on 09/05/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisitScheduleViewController : UIViewController
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (retain, nonatomic) IBOutlet  NSMutableArray *leadsarr;
@end
