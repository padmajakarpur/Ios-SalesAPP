//
//  DiscountApprovalViewController.h
//  Sales App
//
//  Created by Infinitum on 15/06/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ACFloatingTextField.h>
#import "AppDelegate.h"

@interface DiscountApprovalViewController : UIViewController
@property (strong, nonatomic)IBOutlet NSMutableDictionary *dict,*unitdetails;
@property (strong, nonatomic)IBOutlet NSString* comestr;
@property (strong, nonatomic)IBOutlet ACFloatingTextField  *projectxt,*fromunittxt,*tounitxt,*toprojectxt,*disamountxt,*reasontxt,*shiftingreasontxt,*toschemetxt,*discremark,*buildingtxt,*floortxt;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain) UIToolbar *projectoolbar,*schemetoolbar,*buildingtoolbar,*floortoolbar,*unitoolbar;
@property(nonatomic,retain)NSMutableArray *projectarr,*projectidarr,*projectipadr,*schemearr,*agrvaluearr,*buildingarr,*sitenamearr,*siteidarr,*floornamearray,*flooridarr,*floorarr,*unitsarr,*unitidarr,*listarr;
@property(nonatomic,retain)NSString *projectstr,*projectidstr,*ipprojectidstr,*agrvalustr,*schemestr,*buildingstr,*buildingidstr,*floorstr,*flooidstr,*unitstr;
@property(nonatomic,retain) IBOutlet UIPickerView *projectpicker,*schemepicker,*buildingpicker,*floorpicker,*unitpicker;
@property(nonatomic,retain)AppDelegate * appDelegate;
@property(nonatomic,retain) IBOutlet  UILabel *agrmentvaluelbl,*revisiedagrlbl;
@property(nonatomic,retain) IBOutlet  UIScrollView *scrollview;
@property(nonatomic,retain) UIToolbar*numberToolbarzip;
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;

@end
