//
//  BackOfficeinfoViewController.h
//  Sales App
//
//  Created by Infinitum on 19/10/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MXSegmentedPager.h>
NS_ASSUME_NONNULL_BEGIN

@interface BackOfficeinfoViewController : UIViewController
{
    NSMutableArray *  tittlearr;
}
@property(nonatomic,retain)IBOutlet MXSegmentedPager *mxpager;
@property(nonatomic,retain) NSMutableDictionary * dict,*infodict;
@property(nonatomic,retain) NSMutableArray * daboardarr,*summeryarr,*loanarr,*contactarr,*statusarr,*historyarr;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

NS_ASSUME_NONNULL_END
