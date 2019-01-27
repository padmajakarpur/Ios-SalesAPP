

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangeStatusVC : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIDatePicker *datePicker;
    UIPickerView *pickerView;
}
@property BOOL isFromChangeStatusBtn;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UITextField *txtPickerView;
@property (weak, nonatomic) IBOutlet UITextField *txtRemark;
@property (weak, nonatomic) IBOutlet UITextField *txtDateSelection;
@property NSDictionary *dictChangeStatus;
@property NSString *moduleType;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

NS_ASSUME_NONNULL_END
