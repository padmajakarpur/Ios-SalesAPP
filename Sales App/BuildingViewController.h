//
//  BuildingViewController.h
//  Sales App
//
//  Created by Infinitum on 26/04/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ACFloatingTextField.h>
@interface BuildingViewController : UIViewController
@property(nonatomic,retain) ACFloatingTextField *buildingtxt;
@property (retain, nonatomic) IBOutlet UICollectionView *collectioonview;
@property(nonatomic,retain) UIToolbar *buildingtoolbar;
@property(nonatomic,retain)NSMutableArray *buildingidarr,*buildingarr,*floorarr;
@property(nonatomic,retain)NSString *buildingidstr,*buildingstr,*projectidstr;
@property(nonatomic,retain) IBOutlet UIPickerView *buildingpicker;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (retain, nonatomic) IBOutlet UILabel* unitlbl;
@end
