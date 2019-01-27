//
//  AddLeadViewController.h
//  Sales App
//
//  Created by Infinitum on 27/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ACFloatingTextField.h>
#import "AppDelegate.h"
#import <UITextField_AutoSuggestion/UITextField+AutoSuggestion.h>

@interface AddLeadViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *projectoremove;
    int hight,firsthight;
    NSString * gotid;
}
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) ACFloatingTextField *fnametxt,*lnametxt,*mobiletxt,*projectstxt,*prospectstatustxt,*prospectstagestxt,*scheduletxt,*emailtxt,*alternamtetxt,*companynametxt,*dapartmentxt,*prsspectsourcetxt,*prospectalloctxt,*streetxt,*citytxt,*postaltxt,*countytxt,*locationpreftxt,*projectofinterest,*statetxt,*workphone,*homephone,*otherphone,*digitialtxt,*primarysourcetxt,*printtxt,*referedbycustprotxt,*refbycustnotxt,*chanelpartnertxt,*assigntotext,*countrcodetxt;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain)AppDelegate * appDelegate;
@property(nonatomic,retain) UIToolbar * stagestoolbar,*statustoolbar,*projectttlbar,*sourcetoolbar,*printtoolbar,*assigntotoolbar,*countrytoolbar;
@property(nonatomic,retain)NSMutableArray *stagearr,*statusarr,*projectarr,*prosjectidarr,*sourcearr,*printarr,*assignarr,*assignidarr,*countryarr;
@property(nonatomic,retain)NSString * statusstr,*stagestr,*projectstr,*formatteddatestr,*indstr,*sourcestr,*printstr,*comefrom,*assignstr,*assignidstr,*mobilestr,*countrstr,*custypoestr,*purposestr,*custprojstr,*unitnostr;
@property(nonatomic,retain) IBOutlet UIDatePicker *  datePicker;
@property(nonatomic,retain) IBOutlet NSMutableDictionary *dict,*sourcedict,*cpdict;
@property(nonatomic,retain) IBOutlet UIPickerView *statuwpicker,*stegespickeer,*projectpicker,*sourcepicker,*printpicker,*assignpicker,*countrpicker;
@property(nonatomic,retain) UIToolbar*numberToolbarzip;
@property(nonatomic,retain) IBOutlet UIView *phoneview,*addrsview;
@property(nonatomic,retain) IBOutlet UIButton *downbtn2,*primaryaddrs,*addphondeclbl,*downbtn1;
@property(nonatomic,retain) IBOutlet NSMutableDictionary *_submitdict;
@property(nonatomic,retain) IBOutlet  UITextField *salesname;
@end

