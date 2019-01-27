//
//  MarketingMaterialViewController.h
//  Sales App
//
//  Created by Infinitum on 30/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketingMaterialViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (retain, nonatomic)  NSMutableArray *resultarr;
@property (retain, nonatomic) IBOutlet UICollectionView *collectioonview;

@end
