//
//  AddbookingViewController.h
//  Sales App
//
//  Created by Infinitum on 22/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPFloatingPlaceholderTextField.h"
#import <ACFloatingTextField.h>
#import "CustomIOS7AlertView.h"
#import <DLRadioButton.h>
//#import "MRMSDevFPiOS.h"
//#import "PaymentModeViewController.h"
#import <UITextField_AutoSuggestion/UITextField+AutoSuggestion.h>

@interface AddbookingViewController : UIViewController<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger noofcheque,tag,count,hight,*chequetag,*chequeamounttag,indexcount;
}
@property (nonatomic, retain) UIScrollView *scrollView,*view2scrollview,*view5scrollview,*view3scrollview,*view4scrollview,*radioscrollview;
@property(nonatomic,retain)  RPFloatingPlaceholderTextField * nametxt,*buildingtxt,*schemetxt,*descontvaluetxt,*discountremarktxt,*revisedagrttxt,*custnametxt,*custmobnotxt,*custemailtxt,*custaddrtxt,*custSourcetxt,*Revisedagretxt,*bankamountxt,*typeofpayment,*pamentschemetxt,*revisedagrementvaluetxt,*chequeinstrumentdatetxt,*chequeAmountxt;
@property(nonatomic,retain) ACFloatingTextField *rmarktxt,*remainingtxt,*handedovertotext,*amounttxt,*instrumentdatetxt,*lastfourdigitsofcardtxt,*instrumentno,*cibiltext,*Customertypetxt,*businessdetailstxt,*sourcetxt,*countrcodetxt;
@property (nonatomic, retain) UIButton *step1btn,*step2btn,*step3btn,*step4btn,*step5btn,*addbtn,*captureimgbtn,*capturebookingbtn,*checkbox1,*checkbox2,*checkbox3,*checkbox4,*checkbox5,*checkbox6,*checkbox7,*checkbox8,*checkbox9,*checkbox10,*checkbox11,*checkbox12,*paymentgateybtn,*finalbookbtn,*approvebtn;
@property(nonatomic,retain) UIToolbar*numberToolbarzip,*sitenametoolbar,*projectnametoolbar,*schemetoolbar,*typeofpaymentoolbar,*customertypetoolbar,*sourcetoolbar,*countrytoolbar;
@property(nonatomic,retain)NSMutableArray *sitenamearr,*projectnamearr,*schemearr,*tableheadrarr,*Typeofpaymentarr,*buildingarr,*siteidarr,*floorarr,*unitsarr,*schemeidarr,*projectarr,*projectidarr,*customeridarr,*customertypearr,*sourcearr,*imagerarr,*countryarr,*chequeamountarr,*indexarray;
@property(nonatomic,retain)NSString *sitestr,*projectnamestr,*schemestr,*typeofpaymentstr,*siteidstr,*buildingstr,*schemeidstr,*comefromstr,*projectidstr,*avaragevaluastr,*customertypestr,*sourcestr,*flooridstr,*floorno,*countrstr,*pkidstr,*bk_numstr;
@property (retain, nonatomic) IBOutlet UICollectionView *collectioonview,*chequeimagecollectionview;
@property(nonatomic,retain) IBOutlet UIPickerView *sitenamepickerview,*projectpickerview,*schemepickerview,*typeofpaymentpicker,*customertypepicker,*sourcepicker,*countrpicker;
@property(nonatomic,retain) CustomIOS7AlertView *TakePhotoView;
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome,*checktableview;
@property(nonatomic,retain) IBOutlet UIImageView *chequeimage,*bookingimage,*chequeimage2,*chequeimage3;
@property (retain, nonatomic) IBOutlet NSMutableDictionary * dict,*flatdetailsdict,*ipprojectdic,*paymentdetailsdict,*sourcedict,*pamentdetialsfinaldict,*remainingamtdict;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator,*indicator2;
@property (retain, nonatomic) IBOutlet UILabel *flatyplbl2,*unitlbl2,*carlbl2,*redcarpetlbl2,*totalarwlbl2,*totalagrlbl2,*agrementvaluetxt,*registrationchartxt,*stampdutytxt,*gstlbltxt,*legaldocchartxt,*totalcosttxt,*stampdutylbl,*gstlbl,*checkboxlbl1,*checkboxlbl,*checkboxlbl2,*checkboxlbl3,*checkboxlbl4,*checkboxlbl5,*checkboxlbl6,*checkboxlbl7,*checkboxlbl8,*checkboxlbl9,*checkboxlbl10,*checkboxlbl11,*checkboxlbl12,*unitlbl,*assignlbl;
@property (retain, nonatomic) IBOutlet DLRadioButton *step3radiobtn,*remaingbtn;
@property(nonatomic,retain) IBOutlet UIDatePicker *  datePicker;
@property(nonatomic,retain) IBOutlet NSTimer * timer;
@end
