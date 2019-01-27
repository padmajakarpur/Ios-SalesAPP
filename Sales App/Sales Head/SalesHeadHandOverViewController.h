//
//  SalesHeadHandOverViewController.h
//  Sales App
//
//  Created by Infinitum on 16/05/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UITextField_AutoSuggestion/UITextField+AutoSuggestion.h>

@interface SalesHeadHandOverViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property(nonatomic,retain) IBOutlet UITextField *curtemtext,*handovertxt;
@property(nonatomic,retain) IBOutlet NSMutableArray *assignarr,*assignidarr;

@end
