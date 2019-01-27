

#import <UIKit/UIKit.h>
#import "BookingFormIncompleteCustCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookingFormIncompleteVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
     UIPickerView *pickerView;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

NS_ASSUME_NONNULL_END
