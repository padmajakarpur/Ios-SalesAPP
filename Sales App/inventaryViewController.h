//
//  inventaryViewController.h
//  Sales App
//
//  Created by Infinitum on 13/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ACFloatingTextField.h>
#import "CustomIOS7AlertView.h"
#import "AppDelegate.h"

@interface inventaryViewController : UIViewController
@property(nonatomic,retain) ACFloatingTextField *projectxt,*protypetxt,*sizetxt,*valuetxt,*buildingtxt;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UICollectionView *collectioonview;
@property(nonatomic,retain) CustomIOS7AlertView *TakePhotoView;
@property(nonatomic,retain) UIToolbar *buildingtoolbar;
@property(nonatomic,retain)NSMutableArray *buildingidarr,*buildingarr,*floorarr,*forwardarr,*totalarr;
@property(nonatomic,retain)NSString *buildingidstr,*buildingstr;
@property(nonatomic,retain) IBOutlet UIPickerView *buildingpicker;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain) UIToolbar*numberToolbarzip;
@property(nonatomic,retain) UIView *filterview;
@property(nonatomic,retain)AppDelegate * appDelegate;
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property (retain, nonatomic)  IBOutlet UITextField *searchtext;
@property (retain, nonatomic)  IBOutlet UIView * searchview;

@end
