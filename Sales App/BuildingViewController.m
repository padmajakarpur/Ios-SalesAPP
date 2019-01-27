//
//  BuildingViewController.m
//  Sales App
//
//  Created by Infinitum on 26/04/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "BuildingViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
@interface BuildingViewController ()

@end

@implementation BuildingViewController
@synthesize  buildingtxt,collectioonview,buildingarr,buildingstr,buildingidarr,buildingidstr,buildingpicker,buildingtoolbar,indicator,unitlbl;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:30];
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE314" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Buildings";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
// 
//        buildingtxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.12,screenRect.size.width*0.90,screenRect.size.height*0.07)];
//        buildingtxt.textAlignment=NSTextAlignmentLeft;
//        buildingtxt.delegate = self;
//        buildingtxt.textColor=[UIColor blackColor];
//        buildingtxt.delegate=self;
//        [buildingtxt setBackgroundColor:[UIColor clearColor]];
//        buildingtxt.leftViewMode = UITextFieldViewModeAlways;
//        [buildingtxt setKeyboardType:UIKeyboardTypeEmailAddress];
//        buildingtxt.returnKeyType=UIReturnKeyDone;
//        buildingtxt.selectedLineColor = [UIColor redColor];
//        buildingtxt.selectedPlaceHolderColor = [UIColor redColor];
//        buildingtxt.placeHolderColor = [UIColor grayColor];
//        buildingtxt.placeholder=@"Building";
//        buildingtxt.font = [UIFont systemFontOfSize:14];
//        [self.view addSubview:buildingtxt];
//    
//          unitlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.05,screenRect.size.height*0.19,screenRect.size.width*.64,screenRect.size.height*0.04)];
//        //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
//        unitlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.040];
//        unitlbl.text=@"Units";
//        [unitlbl setTextColor:[UIColor blackColor]];
//        unitlbl.textAlignment = NSTextAlignmentLeft;
//        [self.view addSubview:unitlbl];
//    unitlbl.hidden=YES;
    
    NSMutableArray *floorarray=[[NSMutableArray alloc]init];
    NSMutableArray *finalarr=[[NSMutableArray alloc]init];

    for (int i=0; i<buildingarr.count; i++) {
        NSDictionary *dictionary=[buildingarr objectAtIndex:i];
        if (i==0) {
            [floorarray addObject:[dictionary objectForKey:@"floor"]];
        }
        for (int j=0;j<floorarray.count ; j++) {
            if (![floorarray containsObject:[dictionary objectForKey:@"floor"]]){
                [floorarray addObject:[dictionary objectForKey:@"floor"]];
            }
        }
    }
    for (int i=0;i<floorarray.count ; i++) {
        int count=0;
        for (int j=0; j<buildingarr.count; j++) {
            NSDictionary *dictionary=[buildingarr objectAtIndex:j];
            if ([[dictionary objectForKey:@"floor"]isEqualToString:[floorarray objectAtIndex:i]]) {
                count++;
            }
        }
        if (count==0) {
            count=1;
        }
        [finalarr addObject:[NSString stringWithFormat:@"%d",count]];
    }
    _floorarr=[[NSMutableArray alloc]init];
    for (int i=0; i<finalarr.count; i++) {
    NSMutableDictionary* _dict=[[NSMutableDictionary alloc]init];
                [_dict setObject:[floorarray objectAtIndex:i]  forKey:@"floor"];
                [_dict setObject: [finalarr objectAtIndex:i] forKey:@"count"];
        [_floorarr addObject:_dict];
    }
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.headerReferenceSize = CGSizeZero;
        layout.footerReferenceSize = CGSizeZero;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
    
        collectioonview=[[UICollectionView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.025, screenRect.size.height*0.25, screenRect.size.width*0.95,screenRect.size.height*0.71)
                                           collectionViewLayout:layout];
        [collectioonview setDataSource:self];
        [collectioonview setDelegate:self];
        collectioonview.scrollEnabled=YES;
        [collectioonview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        [collectioonview registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        collectioonview.backgroundColor=[UIColor clearColor];
        [self.view addSubview:collectioonview];
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(screenRect.size.width *0.35, screenRect.size.height *0.40, screenRect.size.width *0.30,screenRect.size.width *0.30);
    indicator.color=[UIColor whiteColor];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    indicator.layer.cornerRadius=15.0f;

}
-(void)viewWillAppear:(BOOL)animated
{
   // [self sortbyproject];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _floorarr.count;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    return CGSizeMake(screenRect.size.width*0.025,screenRect.size.width*0.025);
//
//}
- (UICollectionViewCell *)collectionView:(UICollectionView* )collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    NSMutableDictionary * dict=[_floorarr objectAtIndex:indexPath.row];
    UILabel *linelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.0,screenRect.size.width*0.20,screenRect.size.height*0.07)];
    linelbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    linelbl2.text=[NSString stringWithFormat:@"Floor %@",[dict objectForKey:@"floor"]];
    [linelbl2 setTextColor:[UIColor blackColor]];
    linelbl2.backgroundColor=[UIColor clearColor];
    linelbl2.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:linelbl2];
    linelbl2.layer.borderColor = [UIColor blackColor].CGColor;
    linelbl2.layer.borderWidth = 1.0;
    
    UILabel *linelbl1 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.07,screenRect.size.width*0.20,screenRect.size.height*0.05)];
    linelbl1.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    linelbl1.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"count"]];
    [linelbl1 setTextColor:[UIColor whiteColor]];
    linelbl1.backgroundColor=[UIColor blackColor];
    linelbl1.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:linelbl1];
    
    cell.contentView.backgroundColor=[UIColor clearColor];
    return cell;
}
- (CGSize)collectionView:(UICollectionView* )collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath* )indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return CGSizeMake(screenRect.size.width*.20, screenRect.size.height*0.13);
}

-(void)collectionView:(UICollectionView* )collectionView didSelectItemAtIndexPath:(NSIndexPath* )indexPath
{
//        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
//        [params setObject:@"get_flats"  forKey:@"requestType"];
//        [params setObject:siteidstr  forKey:@"buildingId"];
//        [params setObject:[_dict objectForKey:@"project_id"] forKey:@"projectId"];
//        [params setObject:[[_floorarr objectAtIndex:indexPath.row] objectForKey:@"id"] forKey:@"unitNumber"];
//
//        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getinventorydata.php?",[prefs objectForKey:@"Link"]];
//        [indicator startAnimating];
//
//        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//            NSLog(@"JSON: %@", userDict);
//            NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
//            unitsarr=[[NSMutableArray alloc]init];
//            unitsarr=[dic objectForKey:@"units"];
//            [indicator stopAnimating];
//            TakePhotoView = [[CustomIOS7AlertView alloc] init];
//            [TakePhotoView setContainerView:[self signImageSetAlert]];
//            [TakePhotoView setDelegate:self];
//            [TakePhotoView setUseMotionEffects:true];
//            [TakePhotoView show];
//
//        } failure:^(NSURLSessionTask *operation, NSError *error) {
//            NSLog(@"Error: %@", error);
//            [indicator stopAnimating];
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *rowItem;
    
    
    if (pickerView == buildingpicker)
    {
        rowItem = [buildingarr objectAtIndex: row];
    }
    
    UILabel *lblRow = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView bounds].size.width, 44.0f)];
    [lblRow setTextAlignment:UITextAlignmentCenter];
    [lblRow setTextColor: [UIColor blackColor]];
    [lblRow setText:rowItem];
    UIFont * fonts =[UIFont fontWithName:@"Open Sans" size:15.0f];
    lblRow.font=fonts;
    [lblRow setBackgroundColor:[UIColor clearColor]];
    return lblRow;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (pickerView ==buildingpicker)
    {
        buildingstr=[[NSString alloc]init];
        buildingstr=[NSString stringWithFormat:@"%@",[buildingarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
        buildingidstr=[[NSString alloc]init];
        buildingidstr=[NSString stringWithFormat:@"%@",[buildingidarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (pickerView == buildingpicker)
    {
        return [buildingarr objectAtIndex:row];
    }
    
    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat componentWidth = 0.0;
    componentWidth = 300.0;
    return componentWidth;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    
    buildingtoolbar.hidden=YES;
    buildingpicker.hidden=YES;
    
    
    
    if (textField ==buildingtxt) {
        
        //
        buildingpicker = [[UIPickerView alloc] init];
        [buildingpicker setDataSource: self];
        [buildingpicker setDelegate: self];
        buildingpicker.backgroundColor = [UIColor whiteColor];
        [buildingpicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        buildingpicker.showsSelectionIndicator = YES;
        [buildingpicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: buildingpicker];
        buildingpicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            buildingtoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            buildingtoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [buildingtoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed1)];
        [leftButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                  forState:UIControlStateNormal];
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)];
        [rightButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                   forState:UIControlStateNormal];
        
        buildingtoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:buildingtoolbar];
        
        buildingtoolbar.hidden=NO;
        return NO;
    }
        return YES;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    
    if ([pickerView isEqual: buildingpicker]) {
        return [buildingarr count];
    }
    
    return 0;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
-(BOOL)textFieldShouldReturn:(ACFloatingTextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)doneBtnPressed1{
    buildingtoolbar.hidden=YES;
    buildingpicker.hidden=YES;
    
    if ([buildingstr isEqualToString:@""] || buildingstr==nil) {
        if (buildingarr.count>0) {
            buildingtxt.text=[buildingarr objectAtIndex:0];
            buildingidstr=[buildingidarr objectAtIndex:0];
        }
    }
    else{
        buildingtxt.text=buildingstr;
    }
    unitlbl.hidden=NO;
    [self getflowerunit:buildingidstr];
}
-(void)getflowerunit:(NSString*)str
{
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"get_floors_units"  forKey:@"requestType"];
        [params setObject:buildingidstr  forKey:@"buildingId"];
        [params setObject:_projectidstr forKey:@"projectId"];
    
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getinventorydata.php?",[prefs objectForKey:@"Link"]];
        [indicator startAnimating];
    
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSLog(@"JSON: %@", userDict);
            NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
            _floorarr=[[NSMutableArray alloc]init];
            _floorarr=[dic objectForKey:@"inventory_data"];
            
            [indicator stopAnimating];
            [collectioonview reloadData];
    
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
}
-(void)sortbyproject
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
  
    
    [indicator startAnimating];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"get_buildings"  forKey:@"requestType"];
    [params setObject:_projectidstr  forKey:@"projectId"];
    
    
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getFilteredInventory.php?",[prefs objectForKey:@"Link"]];
    
    [indicator startAnimating];
    
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        buildingarr=[[NSMutableArray alloc]init];
        buildingidarr=[[NSMutableArray alloc]init];
        _floorarr=[[NSMutableArray alloc]init];
        [collectioonview reloadData];
        
        
        NSLog(@"JSON: %@", userDict);
        if([[userDict objectForKey:@"Android"] valueForKey:@"failure"] != nil) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[[userDict objectForKey:@"Android"] objectForKey:@"failure"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            buildingarr=nil;
            buildingidarr=nil;
        }
        
        NSMutableArray *build=[[userDict objectForKey:@"Android"] objectForKey:@"buildings"];
        for (int i=0; i<build.count;i++) {
            NSMutableDictionary *dict=[build objectAtIndex:i];
            [buildingarr addObject:[dict objectForKey:@"name"]];
            [buildingidarr addObject:[dict objectForKey:@"id"]];
        }
        NSMutableArray *typ=[[userDict objectForKey:@"Android"] objectForKey:@"unit_types"];
        
       
        [indicator stopAnimating];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}


-(IBAction)cancelBtnpress{
    
    buildingtoolbar.hidden=YES;
    buildingpicker.hidden=YES;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
