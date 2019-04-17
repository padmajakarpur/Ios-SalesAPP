

#import <UIKit/UIKit.h>
#import <ACFloatingTextField.h>
#import "CustomIOS7AlertView.h"
#import "SalesVC.h"


NS_ASSUME_NONNULL_BEGIN

@interface RetentionBookingVC : UIViewController
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property(nonatomic,retain)NSString *comestr;
@property (retain, nonatomic) IBOutlet UIScrollView * teamtableview;
@property(nonatomic,retain)NSMutableArray *teamarr,*bookingarr;
@property(nonatomic,retain) CustomIOS7AlertView *TakePhotoView;
@property(nonatomic,retain) IBOutlet UIView *demoView;
@property (weak, nonatomic) IBOutlet UIButton *btn2Dashboard;
@property (weak, nonatomic) IBOutlet UIButton *btn3Dashboard;
@property(nonatomic,retain) ACFloatingTextField *remarktxt;
@property (weak, nonatomic) IBOutlet UIButton *btn1Dashboard;
@property (weak, nonatomic) IBOutlet UIButton *btn4Dashboard;
@property (retain, nonatomic) IBOutlet UISegmentedControl * segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *lblChequeBounce;
@property (weak, nonatomic) IBOutlet UILabel *lblBAC;
@property (weak, nonatomic) IBOutlet UILabel *lblOCR;
@property (weak, nonatomic) IBOutlet UILabel *lblSDC;
@property (weak, nonatomic) IBOutlet UILabel *lblEscalated;
@end

NS_ASSUME_NONNULL_END
