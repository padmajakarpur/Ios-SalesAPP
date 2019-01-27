//
//  Retention-ESCViewController.h
//  Sales App
//
//  Created by Infinitum on 22/05/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"
#import <ACFloatingTextField.h>
@interface Retention_ESCViewController : UIViewController
{
    int index;
}
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property(nonatomic,retain)NSString *comestr;
@property (retain, nonatomic) IBOutlet UIScrollView * teamtableview;
@property(nonatomic,retain)NSMutableArray *teamarr,*bookingarr,*totalarr;
@property(nonatomic,retain) CustomIOS7AlertView *TakePhotoView;
@property(nonatomic,retain) IBOutlet UIView *demoView;
@property(nonatomic,retain) ACFloatingTextField *remarktxt;
@property (retain, nonatomic) IBOutlet UISegmentedControl * segmentedControl;
@property (retain, nonatomic)  IBOutlet UITextField *searchtext;
@property (retain, nonatomic)  IBOutlet UIView * searchview;

@end
