

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InventoryDetailsVC : UIViewController<UITableViewDataSource,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableview;
@property (weak, nonatomic) IBOutlet UILabel *lblProjectName;
@property (weak, nonatomic) IBOutlet UITextField *txtProjectList;
@property (weak, nonatomic) IBOutlet UITextField *txtUnit_no;

@end

NS_ASSUME_NONNULL_END
