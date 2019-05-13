//
//  AppDelegate.h
//  Sales App
//
//  Created by Infinitum on 06/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,readwrite) int index,calltime;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic)IBOutlet NSMutableDictionary *name_value_list,*userinfodict;
@property (retain, nonatomic) NSMutableArray * userinfoarr,*leadsarr,*projectarr,*visitsarr,*bookingarr,*syncleadarr,*versinostr;
@property (retain, nonatomic) IBOutlet NSString *isvalid,*rolestr,*premiumstr,*projectId,*unitMaxSize,*unitMaxValue,*unitMinSize,*unitMinValue,*unitType,*projectstr,*comestr;
@end

