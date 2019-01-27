//
//  EventsViewController.h
//  Sales App
//
//  Created by Infinitum on 19/06/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsViewController : UIViewController
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain) IBOutlet NSMutableArray *teamarr;
@property(nonatomic,retain) IBOutlet NSString *typestr;

@end
