//
//  ViewimageViewController.h
//  ESD
//
//  Created by Apple on 18/04/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewimageViewController : UIViewController<UIScrollViewDelegate,UIScrollViewAccessibilityDelegate>
@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;
@property (retain, nonatomic) IBOutlet UIImageView * profileViewimageView;
@property (retain, nonatomic) IBOutlet NSString * urlstr;
- (CGSize)imageScale;
@end
