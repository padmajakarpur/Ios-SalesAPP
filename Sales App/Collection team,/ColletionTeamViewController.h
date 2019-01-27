//
//  ColletionTeamViewController.h
//  Sales App
//
//  Created by Infinitum on 25/06/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColletionTeamViewController : UIViewController
@property(nonatomic,retain) IBOutlet UIScrollView * scrollview;
@property(nonatomic,retain) IBOutlet NSMutableArray *dataarr,*filteredarr;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@end
