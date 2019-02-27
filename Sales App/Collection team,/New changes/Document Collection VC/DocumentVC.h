
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DocumentVC : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
}
@property (weak, nonatomic) IBOutlet UIButton *btnDocFollowup;
@property (weak, nonatomic) IBOutlet UIButton *btnDocHomeVisit;
@property (weak, nonatomic) IBOutlet UITableView *myTableview;

@end

NS_ASSUME_NONNULL_END
