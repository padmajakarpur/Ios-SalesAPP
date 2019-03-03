

#import "DocFollowupCell.h"

@implementation DocFollowupCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float shadowSize = 2.0f;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(self.myView.frame.origin.x - shadowSize / 2,
                                                                           self.myView.frame.origin.y - shadowSize / 2,
                                                                           self.myView.frame.size.width + shadowSize,
                                                                           self.myView.frame.size.height + shadowSize)];
    self.myView.layer.masksToBounds = NO;
    self.myView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.myView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.myView.layer.shadowOpacity = 0.2f;
    self.myView.layer.shadowPath = shadowPath.CGPath;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
