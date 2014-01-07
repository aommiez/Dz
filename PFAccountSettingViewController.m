//
//  PFAccountSettingViewController.m
//  DanceZone
//
//  Created by aOmMiez on 9/17/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFAccountSettingViewController.h"
#import "PFAppDelegate.h"
#import "PFIndexViewController.h"
#import "PFTabBarViewController.h"
#import "SDImageCache.h"
#import "GKImagePicker.h"
@interface PFAccountSettingViewController ()

@end

@implementation PFAccountSettingViewController
BOOL newMedia;
BOOL cameraView;
BOOL editMode;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.wv];
    cameraView = NO;
    editMode = NO;
    self.phoneTextField.delegate = self;
    self.emailTextField.delegate = self;
    
    
    UIButton *a2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [a2 setFrame:CGRectMake(0.0f, 0.0f, 40.0f, 30.0f)];
    [a2 addTarget:self action:@selector(editTapped) forControlEvents:UIControlEventTouchUpInside];
    [a2 setTitle:@"Edit" forState:UIControlStateNormal];
    //UIBarButtonItem *editBut = [[UIBarButtonItem alloc] initWithCustomView:a2];
    //self.navigationItem.rightBarButtonItem = editBut;
    
    
    //UIButton *a2 = [UIButton buttonWithType:UIButtonTypeCustom];
    //[a2 setFrame:CGRectMake(0.0f, 0.0f, 50.0f, 30.0f)];
    //[a2 addTarget:self action:@selector(backTapped:) forControlEvents:UIControlEventTouchUpInside];
    //[a2 setTitle:@"Back" forState:UIControlStateNormal];
    //[a1 setImage:[UIImage imageNamed:@"SettingIconIp5@2x"] forState:UIControlStateNormal];
    //UIBarButtonItem *backBut = [[UIBarButtonItem alloc] initWithCustomView:a2];
    //self.navigationItem.leftBarButtonItem = backBut;
    
    self.navigationController.delegate = self;
    UIView *fbView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 5, 20)];
    UIView *emailView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 5, 20)];
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 5, 20)];
    self.facebookTextField.leftView = fbView;
    self.facebookTextField.leftViewMode = UITextFieldViewModeAlways;
    self.emailTextField.leftView = emailView;
    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
    self.phoneTextField.leftView = phoneView;
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.navBg setBackgroundColor:NAV_RGB];
    // Do any additional setup after loading the view from its nib.
    [self.scrollView setContentSize:CGSizeMake(self.formSetting.frame.size.width, self.formSetting.frame.size.height)];
    [self.scrollView addSubview:self.formSetting];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // Get username
    NSString *uid = [defaults objectForKey:@"id"];
    
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@user/%@/picture",API_URL,uid]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    self.imgLink = urlStr;
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{

        // Use when fetching binary data
        NSData *responseData = [request responseData];
        self.profileImg.image = [UIImage imageWithData:responseData];
    }];
    [request setFailedBlock:^{
        //NSError *error = [request error];
        
    }];
    [request startAsynchronous];
    
    PFUserManager *userManager = [[PFUserManager alloc] init];
    userManager.delegate = self;
    [userManager getProfileById:uid];
    [userManager getSetting];
}
- (void)editTapped {
    UIButton *a1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [a1 setFrame:CGRectMake(0.0f, 0.0f, 40.0f, 30.0f)];
    [a1 addTarget:self action:@selector(UpdateTapped) forControlEvents:UIControlEventTouchUpInside];
    [a1 setTitle:@"Save" forState:UIControlStateNormal];
    UIBarButtonItem *random = [[UIBarButtonItem alloc] initWithCustomView:a1];
    self.navigationItem.rightBarButtonItem = random;
    [self.emailTextField setEnabled:YES];
    [self.phoneTextField setEnabled:YES];
    UIButton *a3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [a3 setFrame:CGRectMake(0.0f, 0.0f, 60.0f, 30.0f)];
    [a3 addTarget:self action:@selector(cancelTapped) forControlEvents:UIControlEventTouchUpInside];
    [a3 setTitle:@"Cancel" forState:UIControlStateNormal];
    UIBarButtonItem *cancelBut = [[UIBarButtonItem alloc] initWithCustomView:a3];
    self.navigationItem.leftBarButtonItem = cancelBut;
    [self.emailTextField becomeFirstResponder];
    
    editMode = YES;
}
- (void)cancelTapped {
    editMode = NO;
    [self.emailTextField setEnabled:NO];
    [self.phoneTextField setEnabled:NO];
    UIButton *a2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [a2 setFrame:CGRectMake(0.0f, 0.0f, 40.0f, 30.0f)];
    [a2 addTarget:self action:@selector(editTapped) forControlEvents:UIControlEventTouchUpInside];
    [a2 setTitle:@"Edit" forState:UIControlStateNormal];
    //UIBarButtonItem *editBut = [[UIBarButtonItem alloc] initWithCustomView:a2];
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = nil;
    self.editBut.alpha = 1;
}
- (void)UpdateTapped {
    [self hideKeyboard];
    editMode = NO;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // Get username
    NSString *uid = [defaults objectForKey:@"id"];
    PFUserManager *userManager = [[PFUserManager alloc] init];
    userManager.delegate = self;
    [userManager updateProfile:uid token:[defaults objectForKey:@"token"] email:self.emailTextField.text phone:self.phoneTextField.text];
    [self.emailTextField setEnabled:NO];
    [self.phoneTextField setEnabled:NO];
    UIButton *a2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [a2 setFrame:CGRectMake(0.0f, 0.0f, 40.0f, 30.0f)];
    [a2 addTarget:self action:@selector(editTapped) forControlEvents:UIControlEventTouchUpInside];
    [a2 setTitle:@"Edit" forState:UIControlStateNormal];
    //UIBarButtonItem *editBut = [[UIBarButtonItem alloc] initWithCustomView:a2];
    self.navigationItem.rightBarButtonItem = nil;
    self.editBut.alpha = 1;
    self.navigationItem.leftBarButtonItem = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_scrollView release];
    [_formSetting release];
    [_profileImg release];
    [_facebookTextField release];
    [_emailTextField release];
    [_phoneTextField release];
    [_navTitle release];
    [_pushNews release];
    [_pushShowcase release];
    [_pushLesson release];
    [_pushDancezone release];
    [_wv release];
    [_editBut release];
    [super dealloc];
}
- (IBAction)backTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if([self.delegate respondsToSelector:@selector(PFAccountSettingViewControllerBackTapped:)]){
        [self.delegate PFAccountSettingViewControllerBackTapped:self];
    }
}
- (IBAction)uploadPicProfileTapped:(id)sender {
    if (editMode) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Select Profile Picture"
                                      delegate:self
                                      cancelButtonTitle:@"cancel"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Camera", @"Camera Roll", nil];
        [actionSheet showInView:self.view];
    } else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [defaults objectForKey:@"id"];
        NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@user/%@/picture?display=full",API_URL,uid]autorelease];
        NSLog(@"%@",urlStr);
        [self.delegate PFAccountSettingViewControllerPhoto:urlStr];
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ( buttonIndex == 0 ) {
         [self useCamera];
        [[UIBarButtonItem appearance] setTintColor:[UIColor blueColor]];
    } else if ( buttonIndex == 1 ) {
        [self useCameraRoll];
        [[UIBarButtonItem appearance] setTintColor:[UIColor blueColor]];
    }
}
- (void) useCamera
{
    cameraView = YES;
    if ([UIImagePickerController isSourceTypeAvailable:   UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =   [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
        imagePicker.allowsEditing = YES;
        imagePicker.editing = YES;
        imagePicker.navigationBarHidden=YES;
        imagePicker.view.userInteractionEnabled=YES;
        imagePicker.wantsFullScreenLayout = YES;
        //[self.view.superview addSubview:imagePicker.view];
        [self presentViewController:imagePicker animated:YES completion:nil];
        [imagePicker release];
        newMedia = YES;
    }
}

- (void) useCameraRoll
{

    cameraView = YES;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =   [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =   UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];
        imagePicker.allowsEditing = YES;
        imagePicker.editing = YES;
        //[self presentViewController:imagePicker animated:YES completion:nil];
        [self presentModalViewController:imagePicker animated:YES];
        [imagePicker release];
        newMedia = NO;
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    //[self removeFromParentViewController];
    [self dismissModalViewControllerAnimated:YES];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        image = [self squareImageWithImage:image scaledToSize:CGSizeMake(640, 640)];
        self.profileImg.image = image;
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        // Get username
        NSString *uid = [defaults objectForKey:@"id"];
        
        [self.view addSubview:self.waitView];
        NSString *strUrl = [[NSString alloc] initWithFormat:@"%@user/%@/picture",API_URL,uid];
        NSURL *url = [[NSURL alloc] initWithString:strUrl];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        NSString *filename1=[NSString stringWithFormat:@"picture.jpg"];
        NSData *imageData1=UIImageJPEGRepresentation(image, 75);
        [request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
        [request setPostValue:uid forKey:@"uid"];
        [request setData:imageData1 withFileName:filename1 andContentType:@"image/jpeg" forKey:@"picture"];
        [request setRequestMethod:@"POST"];
        [request setUploadProgressDelegate:self];
        //[request appendPostData:body];
        [request setDelegate:self];
        //[request setTimeOutSeconds:3.0];
        request.shouldAttemptPersistentConnection = NO;
        [request setDidFinishSelector:@selector(uploadRequestFinished:)];
        [request setDidFailSelector:@selector(uploadRequestFailed:)];
        [request startAsynchronous];
        
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
    cameraView = NO;
}
- (void)request:(ASIHTTPRequest *)request incrementDownloadSizeBy:(long long)newLength
{
    NSLog(@"%@",[NSString stringWithFormat:@"incrementDownloadSizeBy %quKb", newLength/1024]);
    self.DownloadSize.text = [NSString stringWithFormat:@"/ %quKb", newLength/1024];
}

- (void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes
{
    NSLog(@"%@",[NSString stringWithFormat:@"didReceiveBytes %quKb", bytes/1024]);
    self.currentLength += bytes;
    NSString *myString = [NSString stringWithFormat:@"%.2fKb", self.currentLength/1024];
    self.ReceiveBytes.text = myString;
    //[lblTotal setText:[NSString    stringWithFormat:@"%quKb/%@",currentLength/1024,self.TotalFileDimension]];
}
- (void)setProgress:(float)newProgress {
    [self.progressView setProgress:newProgress];
    NSLog(@"value: %f",[self.progressView progress]);
}
- (void)uploadRequestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"%@",[request responseString]);
    [self.waitView removeFromSuperview];
    [self.progressView setProgress:0];
    cameraView = NO;
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache clearDisk];
    
}

- (void)uploadRequestFailed:(ASIHTTPRequest *)request{
    NSLog(@" Error - Statistics file upload failed: \"%@\"",[[request error] localizedDescription]);
    [self.waitView removeFromSuperview];
    [self.progressView setProgress:0];
    cameraView = NO;
}
- (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    double ratio;
    double delta;
    CGPoint offset;
    
    //make a new square size, that is the resized imaged width
    CGSize sz = CGSizeMake(newSize.width, newSize.width);
    
    //figure out if the picture is landscape or portrait, then
    //calculate scale factor and offset
    if (image.size.width > image.size.height) {
        ratio = newSize.width / image.size.width;
        delta = (ratio*image.size.width - ratio*image.size.height);
        offset = CGPointMake(delta/2, 0);
    } else {
        ratio = newSize.width / image.size.height;
        delta = (ratio*image.size.height - ratio*image.size.width);
        offset = CGPointMake(0, delta/2);
    }
    
    //make the final clipping rect based on the calculated values
    CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                                 (ratio * image.size.width) + delta,
                                 (ratio * image.size.height) + delta);
    
    
    //start a new context, with scale factor 0.0 so retina displays get
    //high quality image
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(sz, YES, 0.0);
    } else {
        UIGraphicsBeginImageContext(sz);
    }
    UIRectClip(clipRect);
    [image drawInRect:clipRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
- (void)PFUserManager:(id)sender getProfileByIdResponse:(NSDictionary *)response {

    self.facebookTextField.text = [response objectForKey:@"facebook_id"];
    self.emailTextField.text = [response objectForKey:@"email_show"];
    self.phoneTextField.text = [response objectForKey:@"phone_show"];

    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:[response objectForKey:@"username"]];
    [self.navigationItem setTitleView:myLabel];
    
}
- (void)PFUserManager:(id)sender getProfileByIdErrorResponse:(NSString *)errorResponse {
    
}
- (void)hideKeyboard {
    [self.emailTextField resignFirstResponder];
    [self.facebookTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
}
- (IBAction)bgTappe:(id)sender {
    [self hideKeyboard];
}


- (void)PFUserManager:(id)sender updateProfileResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
}
- (void)PFUserManager:(id)sender updateProfileErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}
- (IBAction)logoutTapped:(id)sender {
    
    if (FBSession.activeSession.isOpen)
    {
        FBLoginView *fbloginview = [[FBLoginView alloc]init];
        fbloginview.frame = CGRectMake(0, 0, 0, 0);
        fbloginview.delegate = self;
        [self.view addSubview:fbloginview];
        for (id obj in fbloginview.subviews) {
            if ([obj isKindOfClass:[UIButton class]]){
                [obj sendActionsForControlEvents: UIControlEventTouchUpInside];
                {
                }
            }
        }
    } else {
        
        PFAppDelegate *d = [[UIApplication sharedApplication] delegate];
        if (IS_WIDESCREEN) {
            PFIndexViewController *viewController = [[[PFIndexViewController alloc] initWithNibName:@"PFIndexViewController_Wide" bundle:nil] autorelease];
            viewController.delegate = self;
            d.window.rootViewController = viewController;
        } else {
            PFIndexViewController *viewController = [[[PFIndexViewController alloc] initWithNibName:@"PFIndexViewController" bundle:nil] autorelease];
            viewController.delegate = self;
            d.window.rootViewController = viewController;
        }
        //exit(0);

    }
    
}
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    
    PFAppDelegate *d = [[UIApplication sharedApplication] delegate];
    if (IS_WIDESCREEN) {
        PFIndexViewController *viewController = [[[PFIndexViewController alloc] initWithNibName:@"PFIndexViewController_Wide" bundle:nil] autorelease];
        viewController.delegate = self;
        d.window.rootViewController = viewController;
    } else {
        PFIndexViewController *viewController = [[[PFIndexViewController alloc] initWithNibName:@"PFIndexViewController" bundle:nil] autorelease];
        viewController.delegate = self;
        d.window.rootViewController = viewController;
    }
    //exit(0);
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (!cameraView) {
        if (self.navigationController.visibleViewController != self) {
            if([self.delegate respondsToSelector:@selector(PFAccountSettingViewControllerBackTapped:)]){
                [self.delegate PFAccountSettingViewControllerBackTapped:self];
            }
        }
    }
}
- (void)PFUserManager:(id)sender getSettingResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
    if ( [[response objectForKey:@"new_lesson"] intValue] == 0 ) {
        [self.pushLesson setOn:NO];
    } else {
        [self.pushLesson setOn:YES];
    }
    if ( [[response objectForKey:@"new_showcase"] intValue] == 0 ) {
        [self.pushShowcase setOn:NO];
    } else {
        [self.pushShowcase setOn:YES];
    }
    if ( [[response objectForKey:@"new_update"] intValue] == 0 ) {
        [self.pushNews setOn:NO];
    } else {
        [self.pushNews setOn:YES];
    }
    if ( [[response objectForKey:@"news_from_dancezone"] intValue] == 0 ) {
        [self.pushDancezone setOn:NO];
    } else {
        [self.pushDancezone setOn:YES];
    }
    [self.wv removeFromSuperview];
}
- (void)PFUserManager:(id)sender getSettingErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}
- (IBAction)newsChanged:(id)sender {
    PFUserManager *userManager = [[PFUserManager alloc] init];
    if ([self.pushNews isOn] ){
        [userManager setPush:@"new_update" onoff:@"1"];
    } else {
        [userManager setPush:@"new_update" onoff:@"0"];
    }
    
}

- (IBAction)showcaseChanged:(id)sender {
    PFUserManager *userManager = [[PFUserManager alloc] init];
    if ([self.pushShowcase isOn] ){
        [userManager setPush:@"new_showcase" onoff:@"1"];
    } else {
        [userManager setPush:@"new_showcase" onoff:@"0"];
    }
}
- (IBAction)dancezoneChanged:(id)sender {
    PFUserManager *userManager = [[PFUserManager alloc] init];
    if ([self.pushDancezone isOn] ){
        [userManager setPush:@"news_from_dancezone" onoff:@"1"];
    } else {
        [userManager setPush:@"news_from_dancezone" onoff:@"0"];
    }
}

- (IBAction)lessonChanged:(id)sender {
    PFUserManager *userManager = [[PFUserManager alloc] init];
    if ([self.pushLesson isOn] ){
        [userManager setPush:@"new_lesson" onoff:@"1"];
    } else {
        [userManager setPush:@"new_lesson" onoff:@"0"];
    }
}
- (void)PFIndexViewController:(id)sender loginSuccess:(NSDictionary *)res {
    PFAppDelegate *d = [[UIApplication sharedApplication] delegate];

    if (IS_WIDESCREEN) {
        PFTabBarViewController *tabBarViewController = [[[PFTabBarViewController alloc] initWithNibName:@"PFTabBarViewController_Wide" bundle:nil] autorelease];
        d.window.rootViewController = tabBarViewController;
    } else {
        PFTabBarViewController *tabBarViewController = [[[PFTabBarViewController alloc] initWithNibName:@"PFTabBarViewController" bundle:nil] autorelease];
        d.window.rootViewController = tabBarViewController;
    }
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField { //Keyboard becomes visible
    if (!IS_WIDESCREEN) {
        [self.scrollView setContentOffset:CGPointMake(0, 307 - 170) animated:YES];
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField { //keyboard will hide
    if (!IS_WIDESCREEN) {
        [self.scrollView setContentOffset:CGPointZero animated:YES];
    }
}
- (IBAction)editTapped:(id)sender {
    self.editBut.alpha = 0;
    [self editTapped];
    
}

@end
