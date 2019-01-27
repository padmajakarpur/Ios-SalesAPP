//
//  CloudSyncViewController.h
//  Sales App
//
//  Created by Infinitum on 16/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface CloudSyncViewController : UIViewController
@property(nonatomic,retain)AppDelegate * appDelegate;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end
