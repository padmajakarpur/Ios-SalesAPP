//
//  ChangeStatusBkngFormIncVC.h
//  Sales App
//
//  Created by Infinitum on 16/01/19.
//  Copyright © 2019 Infinitumus.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangeStatusBkngFormIncVC : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
{
    UIPickerView *pickerView;
}
@property (weak, nonatomic) IBOutlet UIView *viewform16;
@property (weak, nonatomic) IBOutlet UIView *viewSalSlip;
@property (weak, nonatomic) IBOutlet UIView *viewBankStat;
@property (weak, nonatomic) IBOutlet UIView *viewIPR;
@property (weak, nonatomic) IBOutlet UITextField *txtPickerView;
@property (weak, nonatomic) IBOutlet UIView *viewBadge;
@property (weak, nonatomic) IBOutlet UIView *viewEmploymentCer;
@property (weak, nonatomic) IBOutlet UIView *viewShopAct;
@property (weak, nonatomic) IBOutlet UIView *viewProofofBus;
@property (weak, nonatomic) IBOutlet UIView *viewInvestigationRep;
@property (weak, nonatomic) IBOutlet UIView *viewPDAssesment;
@property (weak, nonatomic) IBOutlet UIView *viewAppointmentRep;
@property (weak, nonatomic) IBOutlet UIButton *btnForm16;
@property (weak, nonatomic) IBOutlet UIButton *btnSalarySlip;
@property (weak, nonatomic) IBOutlet UIButton *btnBankStat;
@property (weak, nonatomic) IBOutlet UIButton *btnIPR;
@property (weak, nonatomic) IBOutlet UILabel *lblForm16;
@property (weak, nonatomic) IBOutlet UILabel *lblSalSlip;
@property (weak, nonatomic) IBOutlet UILabel *lblBankStat;
@property (weak, nonatomic) IBOutlet UILabel *lblIPR;
@property (weak, nonatomic) IBOutlet UILabel *lblBadge;
@property (weak, nonatomic) IBOutlet UILabel *lblEmpCer;
@property (weak, nonatomic) IBOutlet UILabel *lblShopAct;
@property (weak, nonatomic) IBOutlet UILabel *lblProofBus;
@property (weak, nonatomic) IBOutlet UILabel *lblInvRep;
@property (weak, nonatomic) IBOutlet UILabel *lblPDAssessment;
@property (weak, nonatomic) IBOutlet UILabel *lblAppointmentlet;
@property (weak, nonatomic) IBOutlet UIImageView *imgForm16;
@property (weak, nonatomic) IBOutlet UIImageView *imgSalSlip;
@property (weak, nonatomic) IBOutlet UIImageView *imgBankStat;
@property (weak, nonatomic) IBOutlet UIImageView *imgIPR;
@property (weak, nonatomic) IBOutlet UIImageView *imgBadge;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmployerCer;
@property (weak, nonatomic) IBOutlet UIImageView *imgShopAct;
@property (weak, nonatomic) IBOutlet UIImageView *imgProofofBus;
@property (weak, nonatomic) IBOutlet UIImageView *imgInvestigationRep;
@property (weak, nonatomic) IBOutlet UIImageView *imgPDAss;
@property (weak, nonatomic) IBOutlet UIImageView *imgAppointmentRep;
@property (weak, nonatomic) IBOutlet UIButton *btnAppointmentRep;
@property (weak, nonatomic) IBOutlet UIButton *btnPDAssessment;
@property (weak, nonatomic) IBOutlet UIButton *btnInvestigationRep;
@property (weak, nonatomic) IBOutlet UIButton *btnProofofBus;
@property (weak, nonatomic) IBOutlet UIButton *btnShopAct;
@property (weak, nonatomic) IBOutlet UIButton *btnEmployerCer;
@property (weak, nonatomic) IBOutlet UIButton *btnBadge;
@property (weak, nonatomic) IBOutlet UITextField *txtEmployerDetails;
@property (weak, nonatomic) IBOutlet UILabel *lblEmployerDet;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintBusDet;
@property NSDictionary *dictChangeStatusbkng;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnChangeStatusbkng;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthChangeStatusbkng;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xpositionchangestatusbkng;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingChangeStatbkng;
@property BOOL isFromChangeStatusBtn;
@end

NS_ASSUME_NONNULL_END
