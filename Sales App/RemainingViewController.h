//
//  RemainingViewController.h
//  Sales App
//
//  Created by Infinitum on 31/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemainingViewController : UIViewController
@property (retain, nonatomic) IBOutlet UICollectionView *collectioonview;
@property (retain, nonatomic)NSMutableArray  *imagearray;
@property (retain, nonatomic) IBOutlet NSString *namestr,*prosjectstr;
@property (retain, nonatomic) IBOutlet UIImage *img;
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;

@end
