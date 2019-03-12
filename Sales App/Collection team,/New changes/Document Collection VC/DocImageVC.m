

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
    int Tag_AppBankStat;
    int Tag_CoAppBankStat;
    

    
    __weak IBOutlet UIImageView *imgViewCoAppPan;
    __weak IBOutlet UIImageView *imgViewAppAdhar;
    __weak IBOutlet UIImageView *imgViewCoAppAdhar;
    __weak IBOutlet UIImageView *imgViewAppBankStat;
    __weak IBOutlet UIImageView *imgViewCoappBankStat;
    
    __weak IBOutlet UIView *container4;
    __weak IBOutlet UIView *container3;
    __weak IBOutlet UIView *container2;
    __weak IBOutlet UIView *container1;
    __weak IBOutlet UIView *container5;
    __weak IBOutlet UIView *container6;
   
    
    NSDictionary * userDict;
    
}

@end

@implementation DocImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //Setup UI
    container1.layer.cornerRadius = 7.0;
    container1.layer.borderColor = [UIColor darkGrayColor].CGColor;
    container1.layer.borderWidth = 1.0;
    
    container2.layer.cornerRadius = 7.0;
    container2.layer.borderColor = [UIColor darkGrayColor].CGColor;
    container2.layer.borderWidth = 1.0;
    
    container3.layer.cornerRadius = 7.0;
    container3.layer.borderColor = [UIColor darkGrayColor].CGColor;
    container3.layer.borderWidth = 1.0;
    
    container4.layer.cornerRadius = 7.0;
    container4.layer.borderColor = [UIColor darkGrayColor].CGColor;
    container4.layer.borderWidth = 1.0;
    
    container5.layer.cornerRadius = 7.0;
    container5.layer.borderColor = [UIColor darkGrayColor].CGColor;
    container5.layer.borderWidth = 1.0;
    
    container6.layer.cornerRadius = 7.0;
    container6.layer.borderColor = [UIColor darkGrayColor].CGColor;
    container6.layer.borderWidth = 1.0;
    
    screenRect = [[UIScreen mainScreen] bounds];
    Tag_AppAdhar = 1;
    Tag_CoAdhar = 2;
    Tag_AppPan = 3;
    Tag_CoPan = 4;
    Tag_AppBankStat = 5;
    Tag_CoAppBankStat = 6;
    
   
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text = @"Upload Image";
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
    
    if (self.InfoDict[@"app_pan"] == nil || [self.InfoDict[@"app_pan"]  isEqual: @""] || self.InfoDict[@"app_pan"] == (id)[NSNull null]) {
        // nil branch
        self.lblApplPan.text = @"";
    } else {
        // category name is set
        self.lblApplPan.text = self.InfoDict[@"app_pan"];
        self.imgViewAppPan.image = [self getImageFromUrl:self.InfoDict[@"app_pan"]];
        
    }
    
    if (self.InfoDict[@"app_aadh"] == nil || [self.InfoDict[@"app_aadh"]  isEqual: @""]|| self.InfoDict[@"app_aadh"] == (id)[NSNull null]) {
        // nil branch
        self.lblApplAdhar.text = @"";
    } else {
        // category name is set
        self.lblApplAdhar.text = self.InfoDict[@"app_aadh"];
        imgViewAppAdhar.image = [self getImageFromUrl:self.InfoDict[@"app_aadh"]];
        
    }

    
    
    if (self.InfoDict[@"coapp_pan"] == nil || [self.InfoDict[@"coapp_pan"]  isEqual: @""] || self.InfoDict[@"coapp_pan"] == (id)[NSNull null]) {
        // nil branch
        self.lblCoAppPan.text = @"";
    } else {
        // category name is set
        self.lblCoAppPan.text = self.InfoDict[@"coapp_pan"];
        imgViewCoAppPan.image = [self getImageFromUrl:self.InfoDict[@"coapp_pan"]];
        
    }
    
    if (self.InfoDict[@"coapp_aadh"] == nil || [self.InfoDict[@"coapp_aadh"]  isEqual: @""] || self.InfoDict[@"coapp_aadh"] == (id)[NSNull null]) {
        // nil branch
        self.lblCoappAdhar.text = @"";
    } else {
        // category name is set
        self.lblCoappAdhar.text = self.InfoDict[@"coapp_aadh"];
        imgViewCoAppAdhar.image = [self getImageFromUrl:self.InfoDict[@"coapp_aadh"]];
        
    }
    
    if (self.InfoDict[@"app_bank"] == nil || [self.InfoDict[@"app_bank"]  isEqual: @""] || self.InfoDict[@"app_bank"] == (id)[NSNull null]) {
        // nil branch
        self.lblAppBankStat.text = @"";
    } else {
        // category name is set
        self.lblAppBankStat.text = self.InfoDict[@"app_bank"];
        imgViewAppBankStat.image = [self getImageFromUrl:self.InfoDict[@"app_bank"]];
        
    }
    
    if (self.InfoDict[@"coapp_bank"] == nil || [self.InfoDict[@"coapp_bank"]  isEqual: @""] || self.InfoDict[@"coapp_bank"] == (id)[NSNull null]) {
        // nil branch
        self.lblCoappBankStat.text = @"";
    } else {
        // category name is set
        self.lblCoappBankStat.text = self.InfoDict[@"coapp_bank"];
        imgViewCoappBankStat.image = [self getImageFromUrl:self.InfoDict[@"coapp_bank"]];
        
    }
    
    }

-(UIImage *)getImageFromUrl :(NSString *)url{
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
    return  [UIImage imageWithData: imageData];
}
-(void)viewWillAppear:(BOOL)animated{

    
}
-(void)viewDidAppear:(BOOL)animated{


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
- (IBAction)btnAppAadharClicked:(id)sender {
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
   
    
    if ([self selectImageValidation:_imgViewAppPan.image]) {
        [self uploadImage:@"applicant_pancard" :_imgViewAppPan.image];
        

      }
   }
- (IBAction)btnapplAdharUploadClicked:(id)sender {
    if ([self selectImageValidation:imgViewAppAdhar.image]) {
    [self uploadImage:@"applicant_adharcard" :imgViewAppAdhar.image];
    }
}
- (IBAction)btncoaplPanUploadClicked:(id)sender {
    if ([self selectImageValidation:imgViewCoAppPan.image]) {
    [self uploadImage:@"coapplicant_pancard" :imgViewCoAppPan.image];
    
    }
}
- (IBAction)btncoaplAdharUploadClicked:(id)sender {
    if ([self selectImageValidation:imgViewCoAppAdhar.image]) {
    [self uploadImage:@"coapplicant_adharcard" :imgViewCoAppAdhar.image];
        
    if (self->_InfoDict[@"coapp_aadh"] == nil || self->_InfoDict[@"coapp_aadh"] == (id)[NSNull null]) {
                    // nil branch
        self->_lblCoappAdhar.text = @"null";
    } else {
                    // category name is set
        self->_lblCoappAdhar.text = self->_InfoDict[@"coapp_aadh"];
        
        }
    }
}


-(BOOL)selectImageValidation: (UIImage *)selectedImage{
    //************REMOVE************
   if ([UIImagePNGRepresentation(selectedImage) isEqualToData: UIImagePNGRepresentation([UIImage imageNamed:@"iconTakeImage.png"])]){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Please choose image to upload" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
       [alert show];
        return false;

  }else{
        return true;
    }
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
       imgViewCoAppAdhar.image = chosenImage;
    }if (picker.view.tag == Tag_CoPan) {
        imgViewCoAppPan.image = chosenImage;
    }if (picker.view.tag == Tag_AppAdhar) {
        imgViewAppAdhar.image = chosenImage;
    }if (picker.view.tag == Tag_AppPan) {
        self.imgViewAppPan.image = chosenImage;
    }if (picker.view.tag == Tag_AppBankStat){
        imgViewAppBankStat.image = chosenImage;
    }if (picker.view.tag == Tag_CoAppBankStat){
        imgViewCoappBankStat.image = chosenImage;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)uploadImage:(NSString *)urlType :(UIImage *)selctedImage{
    //Image to base 64
    NSString*  base64String = @"";
    NSData *   ImageDatas = UIImageJPEGRepresentation(selctedImage,0.0);
    base64String  = [ImageDatas base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    //network related
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString * userId = [prefs objectForKey:@"user_id"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:self.InfoDict[@"bknum"]  forKey:@"bknum"];
    [params setObject:self.InfoDict[@"proj_name"]  forKey:@"project_name"];
    [params setObject:self.InfoDict[@"name1"]  forKey:@"customer_name"];

    
    [params setObject:urlType  forKey:@"request_type"];
    //This need to be change
    [params setObject:userId forKey:@"created_by"];

   // [params setObject:self.InfoDict[@"name1"]  forKey:@"created_by"];
    [params setObject:base64String  forKey:@"img_string"];
   

    //  NSString* urlString =@"http://49.248.43.178/xrbia/mobilecrm/getdetails.php?";
    NSString*   urlString = @"http://13.126.129.245/xrbia/mobilecrm/sales/doc_upload/upload_doc.php?";
    [indicator startAnimating];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSMutableDictionary* dict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
       NSMutableDictionary * dict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", dict);
        
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:dict[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        [self->indicator stopAnimating];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self->indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
- (IBAction)btnAppBankStatClicked:(id)sender {
     [self TakeImage : Tag_AppBankStat];
}
- (IBAction)btnAppBankStatUploadClicked:(id)sender {
    if ([self selectImageValidation:imgViewAppBankStat.image]) {
        [self uploadImage:@"applicant_bstate" : imgViewAppBankStat.image];
        
        
    }
    
}
- (IBAction)btnCoAppBankStatClicked:(id)sender {
    [self TakeImage : Tag_CoAppBankStat];

}
- (IBAction)btnCoAppBankStatUploadClicked:(id)sender {
    if ([self selectImageValidation:imgViewCoappBankStat.image]) {
        [self uploadImage:@"coapplicant_bstate" :imgViewCoappBankStat.image];
    }
}


@end
