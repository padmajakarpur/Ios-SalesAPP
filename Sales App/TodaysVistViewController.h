//
//  TodaysVistViewController.h
//  Sales App
//
//  Created by Infinitum on 12/06/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodaysVistViewController : UIViewController
@property (retain, nonatomic) IBOutlet  NSMutableArray *teamarr;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (retain, nonatomic) IBOutlet UIScrollView * teamtableview;

@end
