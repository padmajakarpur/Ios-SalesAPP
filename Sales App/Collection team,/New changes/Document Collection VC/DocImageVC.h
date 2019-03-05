

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DocImageVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgViewAppPan;
@property NSDictionary *InfoDict;
@property (weak, nonatomic) IBOutlet UILabel *lblApplPan;
@property (weak, nonatomic) IBOutlet UILabel *lblCoAppPan;
@property (weak, nonatomic) IBOutlet UILabel *lblApplAdhar;
@property (weak, nonatomic) IBOutlet UILabel *lblCoappAdhar;

@end

NS_ASSUME_NONNULL_END
