

#import "DocImageVC.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
#import <AFNetworking.h>

@interface DocImageVC ()
{
    CGRect screenRect;
    UIActivityIndicatorView *indicator;
    NSMutableArray *resultArray;
    UIButton *backBtn;
    int Tag_AppAdhar;
    int Tag_CoAdhar;
    int Tag_AppPan;
    int Tag_CoPan;
    //bool isFollowupClicked;
}

@end

@implementation DocImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    screenRect = [[UIScreen mainScreen] bounds];
    Tag_AppAdhar = 1;
    Tag_CoAdhar = 2;
    Tag_AppPan = 3;
    Tag_CoPan = 4;
    //    isFollowupClicked = true;
    //    [_btnFollowup setBackgroundColor:[UIColor colorWithHexString:@"#004c00"]];
    //    [_btnHomeVisit setBackgroundColor:[UIColor grayColor]];
    //
    //[self loadDocFollowupData];
    //
    //    _btnFollowup.tag = 1;
    //    _btnHomeVisit.tag = 1;
   // _myTableview.delegate  = self;
    //_myTableview.dataSource = self;
   // isFollowupClicked = true;
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text = @"Upload Image";
    //    if ([ocrStr isEqualToString:@"OCRStr"]){
    //        horizontallbl.text = @"OCR";
    //
    //    }else if ([sdcStr isEqualToString:@"SDCStr"]){
    //        horizontallbl.text = @"SDC";
    //
    //    }else{
    //        horizontallbl.text = @"BAC";
    //
    //    }
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    [self addBackButtonWithImageName:@"backwhite"];
    [navigationView addSubview:backBtn];
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(screenRect.size.width *0.35, screenRect.size.height *0.40, screenRect.size.width *0.30,screenRect.size.width *0.30);
    indicator.color=[UIColor whiteColor];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    indicator.layer.cornerRadius=15.0f;
    

}
- (void)addBackButtonWithImageName:(NSString *)imageName {
    // init your custom button, or your custom view
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}
-(void)backButtonPressed:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:true];
}

//Button take image
- (IBAction)btnApppanClicked:(id)sender {
    [self TakeImage : Tag_AppPan];
}
- (IBAction)btnAppAdharClicked:(id)sender {
    [self TakeImage : Tag_AppAdhar];
}
- (IBAction)btnCoappPanClicked:(id)sender {
     [self TakeImage : Tag_CoPan];
}
- (IBAction)btnCoAppAdharClicked:(id)sender {
     [self TakeImage : Tag_CoAdhar];
}
//BtnUpload Image
- (IBAction)btnAplPanUploadClicked:(id)sender {
}

- (IBAction)btncoapplAdharUploadClicked:(id)sender {
}

- (IBAction)btncoaplPanUploadClicked:(id)sender {
}

- (IBAction)btncoaplAdharUploadClicked:(id)sender {
}

-(void)TakeImage : (int)tag
{
UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select option" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                        @"Camera",
                        @"Gallery",
                        nil];
popup.tag = tag;
[popup showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex==0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.view.tag = popup.tag;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }
    if (buttonIndex==1)
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.view.tag = popup.tag;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // output image
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    if (picker.view.tag == Tag_CoAdhar) {
        self.imgViewAppPan.image = chosenImage;
    }if (picker.view.tag == Tag_CoPan) {
        self.imgViewAppPan.image = chosenImage;
    }if (picker.view.tag == Tag_AppAdhar) {
        self.imgViewAppPan.image = chosenImage;
    }if (picker.view.tag == Tag_AppPan) {
        self.imgViewAppPan.image = chosenImage;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)uploadImage{
//    NSData  *imageData;
//    imageData =  UIImagePNGRepresentation(_imgViewAppPan);
//   NSString * base64 = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//   // extension=@"image/png";}
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager POST:@"https://blahblahblah.com/uploadProfileImg?userId=1" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        //NSData *pngData = [[NSData alloc] initWithBase64EncodedString:base64 options:1];
//        [formData appendPartWithFileData:imageData
//                                    name:@"img_string"
//                                fileName:_imgViewAppPan]; //mimeType:extension];
//
//    }  success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"Response: %@", responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
//        NSLog(@"error: %@",error);
//        // NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
//        NSLog(@"statusCode: %ld", (long)response.statusCode);
//        NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
//        NSLog(@"Error Response:%@",ErrorResponse);
//    }];
}


@end
