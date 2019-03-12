

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DocImageVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgViewAppPan;
@property NSDictionary *InfoDict;
@property (weak, nonatomic) IBOutlet UILabel *lblApplPan;
@property (weak, nonatomic) IBOutlet UILabel *lblCoAppPan;
@property (weak, nonatomic) IBOutlet UILabel *lblApplAdhar;
@property (weak, nonatomic) IBOutlet UILabel *lblCoappAdhar;
@property (weak, nonatomic) IBOutlet UILabel *lblAppBankStat;
@property (weak, nonatomic) IBOutlet UILabel *lblCoappBankStat;

@end

NS_ASSUME_NONNULL_END
