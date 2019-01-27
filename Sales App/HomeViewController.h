//
//  HomeViewController.h
//  Sales App
//
//  Created by Infinitum on 06/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface HomeViewController : UIViewController
{
    int  hight;
}
-(void)createTab;
@property(nonatomic,retain)AppDelegate * appDelegate;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (retain, nonatomic) IBOutlet NSString * comefrom;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UILabel *baccountlbl,*bookingcountlbl,*ESCcountlbl,*followupslbl,*roxcountlbl,*visitscountlbl,*backoffcountlbl;

@end
