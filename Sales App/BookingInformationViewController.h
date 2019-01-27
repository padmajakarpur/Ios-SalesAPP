//
//  BookingInformationViewController.h
//  Sales App
//
//  Created by Infinitum on 12/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MXSegmentedPager.h>
@interface BookingInformationViewController : UIViewController<MXPagerViewDelegate,MXPagerViewDataSource,MXSegmentedPagerDelegate,MXSegmentedPagerDataSource,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *headerarr,*textarr,*tittlearr,*totalarr;
    NSInteger tableindex;
}
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet MXSegmentedPager *mxpager;
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property(nonatomic,retain) IBOutlet UIView * bottomview;
@property(nonatomic,retain) IBOutlet NSMutableDictionary *bookdict,*sapbookingdict,*paymentdetailsdict,*outstadingpaydict,*paymentscheduledict,*paymentduesdict,*interestdetailsdict;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain) IBOutlet UILabel *phonelbl,*emaillbl;
@end
