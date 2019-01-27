

#import <UIKit/UIKit.h>
#import "SalesTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SalesVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *salesTableView;

@end

NS_ASSUME_NONNULL_END
