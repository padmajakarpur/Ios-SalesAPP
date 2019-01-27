//
//  MarketingDetailsViewController.h
//  Sales App
//
//  Created by Infinitum on 30/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketingDetailsViewController : UIViewController
@property (retain, nonatomic) IBOutlet UICollectionView *collectioonview;
@property (retain, nonatomic) NSMutableDictionary *dict;
@property (retain, nonatomic) NSMutableDictionary *resuldict;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (retain, nonatomic) IBOutlet UIImageView *imageview;
@property (retain, nonatomic) NSMutableArray *imagearr,*tittlearr;
@end
