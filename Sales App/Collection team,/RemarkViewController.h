//
//  RemarkViewController.h
//  Sales App
//
//  Created by Infinitum on 03/07/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"
#import <ACFloatingTextField.h>
@interface RemarkViewController : UIViewController
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property(nonatomic,retain) IBOutlet NSMutableArray *teamarr;
@property(nonatomic,retain) IBOutlet UIScrollView * scrollview;
@property(nonatomic,retain) IBOutlet NSMutableString * remarkstr;
@property(nonatomic,retain) CustomIOS7AlertView *TakePhotoView;
@property(nonatomic,retain) IBOutlet ACFloatingTextField * remarktxt;
@property(nonatomic,retain) IBOutlet NSString * comestr;
@property(nonatomic,retain) IBOutlet UILabel *remarklbl;
@end
