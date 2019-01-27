//
//  DiscApprovalViewController.h
//  Sales App
//
//  Created by Infinitum on 21/04/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ACFloatingTextField.h>
#import "CustomIOS7AlertView.h"

@interface DiscApprovalViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain) IBOutlet UITableView *tableViewHome;
@property(nonatomic,retain) IBOutlet NSString * str,*btntittle;
@property(nonatomic,retain) IBOutlet NSMutableArray *listarr;
@property(nonatomic,retain) IBOutlet ACFloatingTextField * aremars;
@property(nonatomic,retain) CustomIOS7AlertView *TakePhotoView;
@property(nonatomic,retain) IBOutlet NSMutableDictionary * dict;
@end
