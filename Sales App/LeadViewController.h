//
//  LeadViewController.h
//  Sales App
//
//  Created by Infinitum on 14/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MXSegmentedPager.h>
#import <ACFloatingTextField.h>
@interface LeadViewController : UIViewController<MXSegmentedPagerDelegate,MXPagerViewDataSource,MXSegmentedPagerDelegate,MXSegmentedPagerDataSource,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *headerarr,*textarr,*tittlearr,*insidetittlearr;
    NSInteger tableindex;
}

@property(nonatomic,retain)IBOutlet MXSegmentedPager *mxpager;
@property(nonatomic,retain)IBOutlet UIView *documentbaseview, * bgview,*demoView;
@property(nonatomic,retain)IBOutlet UITableView *tasktableview;
@property(nonatomic,retain)IBOutlet UIButton * addbtn;
@property(nonatomic,retain) ACFloatingTextField *tasktxt,*scheduleontxt;
@property (retain, nonatomic) IBOutlet NSMutableDictionary * dict;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end
