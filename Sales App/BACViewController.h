//
//  BACViewController.h
//  Sales App
//
//  Created by Infinitum on 09/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ACFloatingTextField.h>
#import "CustomIOS7AlertView.h"

@interface BACViewController : UIViewController
{
    int index;
}
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property(nonatomic,retain) IBOutlet UIView * bgview,*demoView;
@property(nonatomic,retain) ACFloatingTextField *projectstxt,*remarktxt;
@property(nonatomic,retain) UIToolbar *projectoolbar;
@property(nonatomic,retain)NSMutableArray *projectarr,*teamarr;
@property(nonatomic,retain)NSString *projectstr,*comestr;
@property(nonatomic,retain) IBOutlet UIPickerView *projectpicker;
@property(nonatomic,retain) CustomIOS7AlertView *TakePhotoView;
@property (retain, nonatomic) IBOutlet NSMutableArray *bookingarr,*totalarr;
@property (retain, nonatomic) IBOutlet UIScrollView * teamtableview;
@property (retain, nonatomic) IBOutlet UISegmentedControl * segmentedControl;
@property (retain, nonatomic)  IBOutlet UITextField *searchtext;
@property (retain, nonatomic)  IBOutlet UIView * searchview;

@end
