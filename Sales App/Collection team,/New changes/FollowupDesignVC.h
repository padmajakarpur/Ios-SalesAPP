
#import <UIKit/UIKit.h>
#import "FollowUpViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface FollowupDesignVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTodayFolloCnt;
@property (weak, nonatomic) IBOutlet UILabel *lblMissedFolloCnt;
@property (weak, nonatomic) IBOutlet UILabel *lblFutureFolloCnt;

@end

NS_ASSUME_NONNULL_END
