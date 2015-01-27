#import <FacebookSDK/FacebookSDK.h>
#import "ShareFirstStepViewController.h"
#import "CopyLabel.h"
#import "KOTreeViewController.h"
#import <MessageUI/MessageUI.h>
#import "PinterestViewController.h"
#import <Pinterest/Pinterest.h>
#import "ELCImagePickerController.h"
#import "ELCAlbumPickerController.h"
#import "ELCAssetTablePicker.h"
#import "ImageDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "SVProgressHUD.h"
#import <DropboxSDK/DropboxSDK.h>
#import <stdlib.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import "JSONKit.h"
#import "AppDelegate.h"
#import <Twitter/Twitter.h>
#import "RootViewController.h"

@interface ImageDetailViewController ()<GPPSignInDelegate,GPPShareDelegate,UIAlertViewDelegate>
{
    NSString *returnString_new;
    int lastpage_seen;
    Pinterest*  _pinterest;
    UITabBarController *tab_view;
    UIImageView *large_view;
    NSURL *URL;
    UIAlertView *alert;
    NSString *returnString_gimg;
    UIButton *button;
}
@end
@implementation ImageDetailViewController
@synthesize fullImage = _fullImage;
@synthesize image_data_from_library,imgtypestatic,pics_data,selected_image,tag,url_of_images,url_of_image,uploaded_image_urls,selected_index,album_name;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        selected_index = 0;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.view removeFromSuperview];
    [super viewWillDisappear:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    //  [super viewDidDisappear:YES];
    [large_view removeFromSuperview];
    [scroll_for_images removeFromSuperview];
    [self.view removeFromSuperview];
    [super viewDidDisappear:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    returnString_new = [[NSString  alloc] init];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@2x.png"]]];
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    
    if ([[ver objectAtIndex:0] intValue] >= 7)
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bar@2x.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    else
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top-bar.png"] forBarMetrics:nil];
    }
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationItem setTitle:@"Image Details"];
    self.navigationItem.titleView.tintColor= [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                                           UITextAttributeFont: [UIFont fontWithName:@"MyriadPro-Bold" size:18.5],
                                                           }];
    
    button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(goBack:)forControlEvents:UIControlEventTouchUpInside];
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPad:
        {
            [button setImage:[UIImage imageNamed:@"back-up1.png"] forState:UIControlStateNormal];
            [button setFrame:CGRectMake(0, 0,32, 25)];
        }
            break;
        case UIUserInterfaceIdiomPhone:
        {
            [button setImage:[UIImage imageNamed:@"back-up@2x.png"] forState:UIControlStateNormal];
            [button setFrame:CGRectMake(0, 0,32/2, 25/2)];
        }
            break;
    }
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
    
    UIBarButtonItem *Share_Btn = [[UIBarButtonItem alloc]
                                  initWithTitle:@"Share"
                                  style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(share:)];
    self.navigationItem.rightBarButtonItem = Share_Btn;
    
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    
    self.navigationController.navigationBarHidden = NO;
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChangedInImageDetail:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
    //    [super viewDidAppear:NO];
    
    tab_view = [[UITabBarController alloc] init];
    large_view = [[UIImageView alloc] init];
    [self.view addSubview:large_view];
    
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch(self.interfaceOrientation)
            {
                case UIInterfaceOrientationLandscapeRight:
                case UIInterfaceOrientationLandscapeLeft:
                {
                    if([[UIScreen mainScreen]bounds].size.height>500)
                    {
                        if ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.1f)
                        {
                            NSLog(@"did appear landscape 7.1");
                            
                            scroll_for_images = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.width-(tab_view.tabBar.frame.size.height+100)-20, [[UIScreen mainScreen] bounds].size.height, tab_view.tabBar.frame.size.height+100)];
                        }
                        else if ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0f)
                        {
                            NSLog(@"did appear landscape 6.0 ..... 4 inch");
                            
                            scroll_for_images = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.width-(tab_view.tabBar.frame.size.height+75), [[UIScreen mainScreen] bounds].size.height, tab_view.tabBar.frame.size.height+100)];
                        }
                        else
                        {
                            NSLog(@"did appear landscape 7.0  ..... 4 inch");
                            scroll_for_images = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.width-(tab_view.tabBar.frame.size.height+120), [[UIScreen mainScreen] bounds].size.height, tab_view.tabBar.frame.size.height+100)];
                        }
                    }
                    else
                    {
                        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f)
                        {
                            NSLog(@"did appear landscape 3.5 inch 6.0");
                            scroll_for_images = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.width-(tab_view.tabBar.frame.size.height+100)-20, [[UIScreen mainScreen] bounds].size.height, tab_view.tabBar.frame.size.height+100)];
                        }
                        else
                        {
                            NSLog(@"did appear landscape 3.5 inch");
                            scroll_for_images = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.width-(tab_view.tabBar.frame.size.height+100), [[UIScreen mainScreen] bounds].size.height, tab_view.tabBar.frame.size.height+100)];
                        }
                    }
                    scroll_for_images.delegate = self;
                    [self.view addSubview:scroll_for_images];
                }
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                case UIInterfaceOrientationPortrait:
                {
                    scroll_for_images = [[UIScrollView alloc] init];
                    if ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.1f)
                    {
                        if([[UIScreen mainScreen]bounds].size.height>500)
                        {
                            NSLog(@"did appear portrait 7.1  .....4 inch");
                            scroll_for_images.frame=CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+185), [[UIScreen mainScreen] bounds].size.width, tab_view.tabBar.frame.size.height+125);
                        }
                        else
                        {
                            NSLog(@"did appear portrait 7.1  .....3.5 inch");
                            scroll_for_images.frame=CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+150), [[UIScreen mainScreen] bounds].size.width, tab_view.tabBar.frame.size.height+125);
                        }
                    }
                    else if ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0f)
                    {
                        if([[UIScreen mainScreen]bounds].size.height>500)
                        {
                            NSLog(@"did appear portrait 7.0  .....4 inch");
                            scroll_for_images.frame=CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+125), [[UIScreen mainScreen] bounds].size.width, tab_view.tabBar.frame.size.height+125);
                        }
                        else
                        {
                            NSLog(@"did appear portrait 7.0  .....3.5 inch");
                            scroll_for_images.frame=CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+90), [[UIScreen mainScreen] bounds].size.width, tab_view.tabBar.frame.size.height+125);
                        }
                    }
                  else  {
                        if([[UIScreen mainScreen]bounds].size.height>500)
                        {
                            NSLog(@"did appear portrait 6.0 inch  .....4 inch %f", [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+150));
                            scroll_for_images.frame=CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+150)-30, [[UIScreen mainScreen] bounds].size.width, tab_view.tabBar.frame.size.height+150);
                        }
                        else
                        {
                            NSLog(@"did appear portrait 6.0 inch  .....3.5 inch");
                            scroll_for_images.frame=CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+150)-30, [[UIScreen mainScreen] bounds].size.width, tab_view.tabBar.frame.size.height+150);
                            NSLog(@"y axis now: %f",[[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+150));
                            //                            scroll_for_images.backgroundColor=[UIColor yellowColor]; 
                        }
                    }
                    scroll_for_images.delegate = self;
                    [self.view addSubview:scroll_for_images];
                }
                    break;
            }
        }
            break;
            
        case UIUserInterfaceIdiomPad:
        {
            switch(self.interfaceOrientation)
            {
                case UIInterfaceOrientationLandscapeRight:
                case UIInterfaceOrientationLandscapeLeft:
                {
                    NSLog(@"did appear landscape ipad 7.1");
                    if ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.1f)
                    {
                        NSLog(@"7.1 e landscape ipad view");
                        scroll_for_images = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.width-(tab_view.tabBar.frame.size.height+180), [[UIScreen mainScreen] bounds].size.height, tab_view.tabBar.frame.size.height+180)];
                    }
                    else if ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0f)
                    {
                        scroll_for_images = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.width-(tab_view.tabBar.frame.size.height+150), [[UIScreen mainScreen] bounds].size.height, tab_view.tabBar.frame.size.height+180)];
                    }
                    else
                    {
                        NSLog(@"6.1 e landscape ipad view");
                        
                        scroll_for_images = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.width-(tab_view.tabBar.frame.size.height+200), [[UIScreen mainScreen] bounds].size.height, tab_view.tabBar.frame.size.height+180)];
                    }
                    scroll_for_images.delegate = self;
                    [self.view addSubview:scroll_for_images];
                }
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                case UIInterfaceOrientationPortrait:
                {
                    scroll_for_images = [[UIScrollView alloc] init];
                    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
                    {
                        NSLog(@"did appear ipad portrait ipad 7.0");
                        scroll_for_images.frame=CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+200), [[UIScreen mainScreen] bounds].size.width, tab_view.tabBar.frame.size.height+190);
                    }
                    else
                    {
                        NSLog(@"did appear ipad portrait ipad 6.0");
                        scroll_for_images.frame=CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+220), [[UIScreen mainScreen] bounds].size.width, tab_view.tabBar.frame.size.height+190);
                    }
                    scroll_for_images.delegate = self;
                    [self.view addSubview:scroll_for_images];
                }
                    break;
            }
        }
            break;
    }
    [self reloadscroll];
    self.fullImage = [[UIImage alloc] init];
    url_of_image = [url_of_images objectAtIndex:selected_index];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:url_of_image resultBlock:^(ALAsset *asset)
     {
         if(asset)
         {
             self.fullImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage] scale:1.0 orientation:[[asset defaultRepresentation] orientation]];
             [self AdjustTheFullImageView];
         }
     }failureBlock:^(NSError *error)
     {}];
    
    dispatch_queue_t queue = dispatch_queue_create("Start_to_check",NULL);
    dispatch_queue_t main = dispatch_get_main_queue();
    
    NSString *json_string = [[NSString alloc] init];
    
    for (int x = 0; x<[url_of_images count];x++)
    {
        json_string = [json_string stringByAppendingString:[NSString stringWithFormat:@"%@||",[url_of_images objectAtIndex:x]]];
        json_string = [json_string stringByReplacingOccurrencesOfString:@"&"
                                                             withString:@"%20"];
    }
    dispatch_async(queue,^{
        
        @try {
        
        NSURL *url_to_be_fired = [NSURL URLWithString:[NSString stringWithFormat:@"%@iosphoto_action.php?action=gather_image_url_info&user_id=%@&url_of_images=%@",mydomainurl,[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"],[json_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        NSLog(@"url to b fyrd: %@",url_to_be_fired);
        NSError *error;
        NSData *return_data = [NSData dataWithContentsOfURL:url_to_be_fired options:NSDataReadingUncached error:&error];
        if(error)
        {
            [SVProgressHUD showErrorWithStatus:@"There is an issue with connectivity"];
        }
        dispatch_sync(main,^{
            if(return_data!=nil)
            {
                NSError *error;
                NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:return_data options:NSJSONReadingMutableContainers error:&error];
                if(error)
                {
//                    [SVProgressHUD showErrorWithStatus:@"Json Parsing error"];
                    NSLog(@"json parsing error");
                    return ;
                }
                else
                {
                    NSString  *present = [dict objectForKey:@"present"];
                    
                    if([present isEqualToString:@"YES"])
                    {
                        uploaded_image_urls = [[NSMutableArray alloc] init];
                        uploaded_image_urls = [dict objectForKey:@"data"];
                        [self reloadscroll];
                        
                        [self AdjustTheFullImageView];
                    }
                }
            }
        });
        }
        @catch (NSException *exception) {
            NSLog(@"exception dropbox: %@",exception);
        }
        @finally {
        }

    });
}
- (void) orientationChangedInImageDetail:(NSNotification *)note
{
    //    [large_view removeFromSuperview];
    UIDevice * device = note.object;
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPad:
        {
            switch(device.orientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
                    {
                        NSLog(@"orient portrait ipad 7.0");
                        scroll_for_images.frame=CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+220), [[UIScreen mainScreen] bounds].size.width, tab_view.tabBar.frame.size.height+200);
                    }
                    else
                    {
                        if([[UIScreen mainScreen]bounds].size.height>500)
                        {
                            NSLog(@"orient portrait ipad 6.0");
                            scroll_for_images.frame=CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+220), [[UIScreen mainScreen] bounds].size.width, tab_view.tabBar.frame.size.height+180);
                        }
                        else
                        {
                            NSLog(@"should not come here");
                            scroll_for_images.frame=CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+150), [[UIScreen mainScreen] bounds].size.width, tab_view.tabBar.frame.size.height+150);
                        }
                    }
                }
                    break;
                case UIDeviceOrientationLandscapeLeft:
                case UIDeviceOrientationLandscapeRight:
                {
                    //                     scroll_for_images.frame = CGRectMake(0, [[UIScreen mainScreen]bounds].size.width-(tab_view.tabBar.frame.size.height+200), [[UIScreen mainScreen] bounds].size.height, tab_view.tabBar.frame.size.height+200);
                    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
                    {
                        NSLog(@"orient landscape ipad 7.0");
                        scroll_for_images.frame = CGRectMake(0, [[UIScreen mainScreen]bounds].size.width-(tab_view.tabBar.frame.size.height+200), [[UIScreen mainScreen] bounds].size.height, tab_view.tabBar.frame.size.height+200);
                    }
                    else
                    {
                        NSLog(@"orient landscape ipad 6.0");
                        scroll_for_images.frame = CGRectMake(0, [[UIScreen mainScreen]bounds].size.width-(tab_view.tabBar.frame.size.height+200), [[UIScreen mainScreen] bounds].size.height, tab_view.tabBar.frame.size.height+130);
                    }
                }
                    break;
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
                    {
                        NSLog(@"orient portrait upside ipad 7.0");
                        scroll_for_images.frame=CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+125), [[UIScreen mainScreen] bounds].size.width, tab_view.tabBar.frame.size.height+125);
                    }
                    else
                    {
                        NSLog(@"orient portrait upside ipad 6.0");
                        scroll_for_images.frame=CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+150), [[UIScreen mainScreen] bounds].size.width, tab_view.tabBar.frame.size.height+150);
                    }
                }
                    break;
                case UIDeviceOrientationUnknown:
                case UIDeviceOrientationFaceUp:
                case UIDeviceOrientationFaceDown:
                    break;
            }
        }
            break;
        case UIUserInterfaceIdiomPhone:
        {
            switch(device.orientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    if ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.1f)
                    {
                        if([[UIScreen mainScreen]bounds].size.height>500)
                        {
                            NSLog(@"orient portrait iphone 7.1 4 inch if");
                            scroll_for_images.frame=CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+185), [[UIScreen mainScreen] bounds].size.width, tab_view.tabBar.frame.size.height+165);
                        }
                        else
                        {
                            NSLog(@"orient portrait iphone 7.1 4 inch else");
                            scroll_for_images.frame=CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+150), [[UIScreen mainScreen] bounds].size.width, tab_view.tabBar.frame.size.height+125);
                        }
                    }
                    
                    
                   else if ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0f)
                    {
                        if([[UIScreen mainScreen]bounds].size.height>500)
                        {
                            NSLog(@"orient portrait iphone 7.0 4 inch");
                            scroll_for_images.frame=CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+125), [[UIScreen mainScreen] bounds].size.width, tab_view.tabBar.frame.size.height+125);
                        }
                        else
                        {
                            NSLog(@"orient portrait iphone 7.0 4 inch");
                            scroll_for_images.frame=CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+90), [[UIScreen mainScreen] bounds].size.width, tab_view.tabBar.frame.size.height+125);
                        }
                    }

                    else
                    {
                        NSLog(@"orient portrait iphone 6.0");
                        scroll_for_images.frame=CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(tab_view.tabBar.frame.size.height+150)-30, [[UIScreen mainScreen] bounds].size.width, tab_view.tabBar.frame.size.height+150);
                    }
                }
                    break;
                case UIDeviceOrientationLandscapeLeft:
                case UIDeviceOrientationLandscapeRight:
                {
                    if ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.1f)
                    {
                        if([[UIScreen mainScreen]bounds].size.height>500)
                        {
                            NSLog(@"orient landscape iphone 4 inch 7.1");
                            scroll_for_images.frame = CGRectMake(0, [[UIScreen mainScreen]bounds].size.width-(tab_view.tabBar.frame.size.height+120), [[UIScreen mainScreen] bounds].size.height, tab_view.tabBar.frame.size.height+100);
                        }
                        else
                        {
                            NSLog(@"orient landscape iphone 3.5 inch 7.1");
                            scroll_for_images.frame = CGRectMake(0, [[UIScreen mainScreen]bounds].size.width-(tab_view.tabBar.frame.size.height+120), [[UIScreen mainScreen] bounds].size.height, tab_view.tabBar.frame.size.height+100);
                        }
                    }
                    
                    else if ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0f)
                    {
                        if([[UIScreen mainScreen]bounds].size.height>500)
                        {
                            NSLog(@"orient landscape iphone 4 inch 7.0");
                            scroll_for_images.frame = CGRectMake(0, [[UIScreen mainScreen]bounds].size.width-(tab_view.tabBar.frame.size.height+60), [[UIScreen mainScreen] bounds].size.height, tab_view.tabBar.frame.size.height+80);
                        }
                        else
                        {
                            NSLog(@"orient landscape iphone 3.5 inch 7.0");
                            scroll_for_images.frame = CGRectMake(0, [[UIScreen mainScreen]bounds].size.width-(tab_view.tabBar.frame.size.height+100), [[UIScreen mainScreen] bounds].size.height, tab_view.tabBar.frame.size.height+100);
                        }
                    }
                    else
                    {
                        NSLog(@"orient landscape iphone 6.0");
                        scroll_for_images.frame = CGRectMake(0, [[UIScreen mainScreen]bounds].size.width-(tab_view.tabBar.frame.size.height+130)-10, [[UIScreen mainScreen] bounds].size.height, tab_view.tabBar.frame.size.height+130);
                    }
                }
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                {
                }
                    break;
                    
                case UIDeviceOrientationUnknown:
                case UIDeviceOrientationFaceUp:
                case UIDeviceOrientationFaceDown:
                    break;
            }
        }
            break;
    }
    [self reloadscroll];
    [self AdjustTheFullImageView];
}
-(UIImage *)resizeImage:(UIImage *)image width:(CGFloat)resizedWidth height:(CGFloat)resizedHeight
{
    CGImageRef imageRef = [image CGImage];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmap = CGBitmapContextCreate(NULL, resizedWidth, resizedHeight, 8, 4 * resizedWidth, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(bitmap, CGRectMake(0, 0, resizedWidth, resizedHeight), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *result = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    return result;
}
-(void)AdjustTheFullImageView
{
    for (UIView *Sub in self.view.subviews)
    {
        if([Sub isKindOfClass:[UITextField class]])
        {
            [Sub removeFromSuperview];
        }
    }
    CGFloat ratio = self.fullImage.size.width/self.fullImage.size.height;
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        CGRect newRect;
        float hfactor = self.fullImage.size.width / scroll_for_images.frame.size.width;
        float vfactor = self.fullImage.size.height / scroll_for_images.frame.origin.y;
        float factor = fmax(hfactor, vfactor);
        float newWidth = self.fullImage.size.width / factor-50;
        float newHeight = self.fullImage.size.height / factor -140;
        float leftOffset = (scroll_for_images.frame.size.width - newWidth) / 2;
        float topOffset = (scroll_for_images.frame.origin.y - newHeight) / 2;
        if(self.interfaceOrientation == UIInterfaceOrientationPortrait||self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            newRect = CGRectMake(leftOffset, topOffset+10, newWidth, newHeight-10);
        }
        else
        {
            newRect = CGRectMake((scroll_for_images.frame.size.width - newWidth/2) / 2, (scroll_for_images.frame.origin.y - newHeight/2) / 2+10, newWidth/2, newHeight/2);
        }
        
        large_view.frame = newRect;
    }
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        switch (self.interfaceOrientation) {
            case UIInterfaceOrientationPortrait:
            case UIInterfaceOrientationPortraitUpsideDown:
            {
                if([[UIScreen mainScreen]bounds].size.height<500)
                {
                    //large_view.frame =  CGRectMake(scroll_for_images.frame.size.width/4, start_y, scroll_for_images.frame.size.width/2,(scroll_for_images.frame.size.width/2)/ratio);
                    float hfactor = self.fullImage.size.width / scroll_for_images.frame.size.width;
                    float vfactor = self.fullImage.size.height / scroll_for_images.frame.origin.y;
                    float factor = fmax(hfactor, vfactor);
                    float newWidth = self.fullImage.size.width / factor;
                    float newHeight = self.fullImage.size.height / factor;
                    
                    float leftOffset = (scroll_for_images.frame.size.width - newWidth) / 2;
                    float topOffset = (scroll_for_images.frame.origin.y - newHeight) / 2;
                    
                    CGRect newRect = CGRectMake(leftOffset, topOffset+60, newWidth, newHeight-20);
                    //                           [large_view removeFromSuperview];
                    //                           large_view = [[UIImageView alloc] initWithFrame:newRect];
                    //                           [self.view addSubview:large_view];
                    //                           large_view.image=self.fullImage;
                    
                    large_view.frame = newRect;
                }
                else
                {
                    float hfactor = self.fullImage.size.width / scroll_for_images.frame.size.width;
                    float vfactor = self.fullImage.size.height / scroll_for_images.frame.origin.y;
                    float factor = fmax(hfactor, vfactor);
                    float newWidth = self.fullImage.size.width / factor;
                    float newHeight = self.fullImage.size.height / factor;
                    float leftOffset = (scroll_for_images.frame.size.width - newWidth) / 2;
                    float topOffset = (scroll_for_images.frame.origin.y - newHeight) / 2;
                    
                    CGRect newRect = CGRectMake(leftOffset, topOffset+30, newWidth, newHeight);
                    //                           [large_view removeFromSuperview];
                    //                           large_view = [[UIImageView alloc] initWithFrame:newRect];
                    //                           [self.view addSubview:large_view];
                    //                           large_view.image=self.fullImage;
                    large_view.frame = newRect;
                }
            }
                break;
                
            case UIInterfaceOrientationLandscapeLeft:
            case UIInterfaceOrientationLandscapeRight:
            {
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
                {
                    float start_y = self.navigationController.navigationBar.frame.size.height + 20;
                    float size_height = 320 - (scroll_for_images.frame.size.height + start_y);
                    float size_width = ratio*size_height;
                    //                           large_view.frame = CGRectMake((scroll_for_images.frame.size.width-size_width)/2, start_y, size_width, size_height);
                    
                    //                           [large_view removeFromSuperview];
                    large_view.frame=CGRectMake((scroll_for_images.frame.size.width-size_width)/2, start_y, size_width, size_height);
                    //                           [self.view addSubview:large_view];
                    //                           large_view.image=self.fullImage;
                    
                }
                else
                {
                    float start_y = self.navigationController.navigationBar.frame.size.height;
                    float size_height = 320 - (scroll_for_images.frame.size.height + start_y);
                    float size_width = ratio*size_height;
                    //                           large_view.frame = CGRectMake((scroll_for_images.frame.size.width-size_width)/2, start_y, size_width, size_height);
                    
                    //                           [large_view removeFromSuperview];
                    large_view.frame = CGRectMake((scroll_for_images.frame.size.width-size_width)/2, start_y, size_width, size_height);
                    //                           [self.view addSubview:large_view];
                    //                           large_view.image=self.fullImage;
                    
                }
            }
                break;
        }
        
        for (UILabel *lbl in self.view.subviews)
        {
            if([lbl isKindOfClass:[UILabel class]])
            {
                [lbl removeFromSuperview];
            }
        }
    }
    for (int x=0;x<[uploaded_image_urls count];x++)
    {
        NSLog(@"ei tay hmm");
        NSDictionary *data_obj = (NSDictionary *)[uploaded_image_urls objectAtIndex:x];
        NSLog(@"dataobj url at %d :%@",x,[data_obj objectForKey:@"asset_url"]);
        NSLog(@"compare url:%@",url_of_image);
        
        if([[[data_obj objectForKey:@"asset_url"] stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:[[NSString stringWithFormat:@"%@", url_of_image] stringByReplacingOccurrencesOfString:@" " withString:@""]])
        {
            NSLog(@"ei tay hmm 1");
            CopyLabel *url_label=[[CopyLabel alloc]initWithFrame:CGRectMake(0,scroll_for_images.frame.origin.y-25,self.view.bounds.size.width,30)];
            url_label.text = [data_obj objectForKey:@"url"];
            [url_label setNumberOfLines:3];
            url_label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            url_label.textColor = [UIColor whiteColor];
            url_label.textAlignment = NSTextAlignmentCenter;
            url_label.font = [UIFont systemFontOfSize:11.5f];
            [self.view addSubview:url_label];
        }
    }
    large_view.image = self.fullImage;
}
-(void)reloadscroll
{
    for (UIView *sub in scroll_for_images.subviews)
    {
        [sub removeFromSuperview];
    }
    __block CGFloat cx = 0;
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    for (int nimages=0;nimages<[image_data_from_library count];nimages++) {
        
        [library assetForURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[url_of_images objectAtIndex:nimages]]] resultBlock:^(ALAsset *asset) {
            if(asset)
            {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:[asset thumbnail] scale:1.0 orientation:[[asset defaultRepresentation] orientation]]];
                CALayer* layer = [imageView layer];
                [layer setBorderWidth:1.0f];
                [layer setBorderColor:[UIColor colorWithWhite:.54 alpha:1].CGColor];
                //[layer setShadowColor:[[UIColor redColor]CGColor]];
                [layer setShadowOffset:CGSizeMake(-3.0, 3.0)];
                [layer setShadowRadius:3.0];
                [layer setShadowOpacity:1.0];
                
                imageView.clipsToBounds = NO;
                [imageView setTag:nimages];
                CGRect rect = imageView.frame;
                
                if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
                {
                    NSLog(@"etay elo 1");
                    rect.size.height = 80;
                }
                else
                {
                    rect.size.height = 100;
                }
                rect.size.width = 80;
                rect.origin.x = cx;
                switch (self.interfaceOrientation) {
                    case UIInterfaceOrientationPortrait:
                    {
                        if([[UIScreen mainScreen]bounds].size.height<500)
                        {
                            NSLog(@"etay elo");
                            rect.origin.y = (scroll_for_images.frame.size.height- rect.size.height)/2;
                        }
                        else
                        {
                            rect.origin.y = 80;
                        }
                    }
                        break;
                        
                    case UIInterfaceOrientationLandscapeRight:
                    case UIInterfaceOrientationLandscapeLeft:
                    {
                        rect.origin.y = (scroll_for_images.frame.size.height- rect.size.height)/2;
                    }
                        break;
                    case UIInterfaceOrientationPortraitUpsideDown:
                        break;
                }
                imageView.frame = rect;
                cx += imageView.frame.size.width+5;
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap_action = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showThelargeView:)];
                [tap_action setNumberOfTapsRequired:1];
                [tap_action setNumberOfTouchesRequired:1];
                [imageView addGestureRecognizer:tap_action];
                
                [scroll_for_images addSubview:imageView];
            }
        } failureBlock:^(NSError *error) {
        }];
    }
    scroll_for_images.contentSize = (CGSize){.width = 85.0f*[image_data_from_library count], .height = scroll_for_images.frame.size.height};
}

-(void)showThelargeView:(UITapGestureRecognizer *)sender
{
    selected_index = [[sender view] tag];
    url_of_image = [url_of_images objectAtIndex:[[sender view] tag]];
    NSLog(@"url of image selected: %@",url_of_image);
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:url_of_image resultBlock:^(ALAsset *asset)
     {
         if(asset)
         {
             self.fullImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage] scale:1.0 orientation:[[asset defaultRepresentation] orientation]];
             [self AdjustTheFullImageView];
             
             ALAssetRepresentation *defaultRepresentation = [asset defaultRepresentation];
             
             NSString *uti = [defaultRepresentation UTI];
             URL = [[asset valueForProperty:ALAssetPropertyURLs] valueForKey:uti];
             NSLog(@"nsurl conversion: %@",URL);
         }
     }failureBlock:^(NSError *error)
     {
     }];
}

- (void)goBack:(id)sender {
    
    if ([[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] unlinkAll];
    }
    selected_index = 0;
    image_data_from_library = [[NSMutableArray alloc] init];
    
    RootViewController *root = [[RootViewController alloc]init];
    [self.navigationController pushViewController:root animated:NO];
}


-(void)share:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Share the Picture"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel Button"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Facebook", @"Twitter",@"DropBox",@"Google+",@"Share to pXc webpage",@"Pinterest",@"Share via Email",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}
-(void)startToPostFB
{
    NSMutableDictionary * params;
    
    params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
              [NSString stringWithFormat:@"%@",@""], @"message",
              UIImageJPEGRepresentation(_fullImage, 1), @"source",
              nil];
    
    [FBRequestConnection startWithGraphPath:@"/me/photos"
                                 parameters:params
                                 HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error) {
                                  [[FBSession activeSession] closeAndClearTokenInformation];
                                  [[FBSession activeSession] close];
                                  [FBSession setActiveSession:nil];
                                  
                              } else {
                                  if(error.code==4)
                                  {
                                      
                                  }
                              }
                          }];
}
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    switch (state) {
            
        case FBSessionStateClosed:
            break;
        case FBSessionStateClosedLoginFailed:
            
            break;
            
        case FBSessionStateCreated:
            
        case FBSessionStateCreatedOpening:
            
        case FBSessionStateOpen:
            
            [self startToPostFB];
            
            break;
        default:
            break;
            
    }
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            if([[FBSession activeSession]isOpen])
                
            {
                
                [FBSession.activeSession requestNewPublishPermissions:@[@"publish_actions",@"publish_stream"]
                 
                                                      defaultAudience:FBSessionDefaultAudienceFriends
                 
                                                    completionHandler:^(FBSession *session,
                                                                        
                                                                        NSError *error)
                 {
                     [ self startToPostFB];
                 }];
            }
            else
            {
                [FBSession openActiveSessionWithPublishPermissions:[[NSArray alloc] initWithObjects:@"publish_stream",@"publish_actions", nil]
                 
                                                   defaultAudience:FBSessionDefaultAudienceFriends
                                                      allowLoginUI:YES
                                                 completionHandler:^(FBSession *session,
                                                                     FBSessionState state, NSError *error) {
                                                     if(!error)
                                                     {
                                                         [self sessionStateChanged:session state:state error:error];
                                                     }
                                                 }];
            }
        }
            break;
        case 1:
        {
            if ([TWTweetComposeViewController canSendTweet])
            {
                TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
                [tweetSheet setInitialText:@"PhotoXchange"];
                
                //        if (self.imageString)
                //        {
                [tweetSheet addImage:_fullImage];
                //        }
                //        if (self.urlString)
                //        {
                //[tweetSheet addURL:[NSURL URLWithString:self.urlString]];
                //        }
                [self presentModalViewController:tweetSheet animated:YES];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                                    message:@"No Account Found in Settings!!"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                [alertView show];
            }
        }
            break;
        case 2:
        {
            ShareFirstStepViewController *share = [[ShareFirstStepViewController alloc] init];
            share.image_urls=url_of_images;
            share.type = Dropbox;
            [self.navigationController pushViewController:share animated:NO];
        }
            break;
        case 3:
        {
            [SVProgressHUD show];
            //            if([[GPPSignIn sharedInstance]hasAuthInKeychain])
            //
            //            {
            //                NSLog(@"coming in share gplus if");
            //
            //                id<GPPNativeShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];
            //
            //                // Set any prefilled text that you might want to suggest
            //
            //                [shareBuilder setPrefillText:[NSString stringWithFormat:@" via QuiqFind"]];
            //
            //                [shareBuilder attachImage: [UIImage imageNamed:@"50.png"]];
            //
            //                [shareBuilder open];
            //
            //
            ////                id<GPPShareBuilder> shareBuilder = [[GPPShare sharedInstance] shareDialog];
            ////
            ////                // This line will fill out the title, description, and thumbnail of the item
            ////                // you're sharing based on the URL you included.
            ////                [shareBuilder setURLToShare:URL];//
            ////
            ////                [shareBuilder setPrefillText:@"Hey! Its working"];
            ////                // if somebody opens the link on a supported mobile device
            //////                [shareBuilder setContentDeepLinkID:@"rest=1234567"];
            ////
            ////                [shareBuilder open];
            //
            //            }
            //
            //            else
            //
            //            {
            //                NSLog(@"coming in share gplus else");
            //                [GPPSignIn sharedInstance].delegate = self;
            //
            //                [GPPSignIn sharedInstance].shouldFetchGoogleUserEmail = YES;
            //
            //                [GPPSignIn sharedInstance].shouldFetchGoogleUserID = YES;
            //
            //                [GPPSignIn sharedInstance].clientID = kClientID;
            //
            //                [GPPSignIn sharedInstance].scopes = [NSArray arrayWithObjects:kGTLAuthScopePlusLogin,@"profile",nil];
            //
            //                [[GPPSignIn sharedInstance] authenticate];
            //
            //            }
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSString *strurl = [NSString stringWithFormat:@"%@image_upload.php",mydomainurl];
                NSLog(@"url ta dichhe: %@",strurl);
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                
                [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
                
                [request setHTTPShouldHandleCookies:NO];
                
                [request setURL:[NSURL URLWithString:strurl]];
                
                [request setTimeoutInterval:10];
                
                [request setHTTPMethod:@"POST"];
                
                
                NSCharacterSet *whitespace;
                NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
                
                NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
                
                [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
                
                NSMutableData *body = [NSMutableData data];
                
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"share_pic\"; filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [body appendData:[NSData dataWithData:UIImageJPEGRepresentation(_fullImage, 1)]];
                
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [request setHTTPBody:body];
                
                
                NSURLResponse *response = nil;
                NSError *error = nil;
                NSData *returnData1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                NSLog(@"data returned: %@",returnData1);
                if(error)
                {
                    [SVProgressHUD dismiss];
                    NSLog(@"Please check your internet connectivity %@",error);
                    alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Failed to Connect, Please Try Again"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    
                    //                    return ;
                }else{
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
                    
                    returnString_gimg = [[[NSString alloc] initWithData:returnData1 encoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet:whitespace];
                    NSLog(@"etar pore return korlo: %@",returnString_gimg);
                    
                    //                    alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Connecting to Google Plus"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    //                    [alert show];
                    alert.tag=2;
                    [SVProgressHUD showSuccessWithStatus:@"Connecting to Google Plus"];
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // UI UPDATION 1
                    //                    if([returnString_gimg isEqualToString:@"success"])
                    //                    {
                    self.view.userInteractionEnabled=YES;
                    
                    [SVProgressHUD dismiss];
                    
                    if([[GPPSignIn sharedInstance]hasAuthInKeychain])
                    {
                        id<GPPShareBuilder> shareBuilder = [[GPPShare sharedInstance] shareDialog];
                        
                        // This line will fill out the title, description, and thumbnail of the item
                        // you're sharing based on the URL you included.
                        [shareBuilder setURLToShare:[NSURL URLWithString:returnString_gimg]];//
                        
                        [shareBuilder setPrefillText:@"Shared via PhotoXchange"];
                        // if somebody opens the link on a supported mobile device
                        [shareBuilder setContentDeepLinkID:@"rest=1234567"];
                        
                        [shareBuilder open];
                    }
                    else
                    {
                        GPPSignIn *signIn = [GPPSignIn sharedInstance];
                        // You previously set kClientID in the "Initialize the Google+ client" step
                        signIn.clientID = @"536735755870-1bcqgtc3splihm9mgu008oojtrjvgffd.apps.googleusercontent.com";
                        signIn.scopes = [NSArray arrayWithObjects:
                                         kGTLAuthScopePlusLogin,kGTLAuthScopePlusMe,
                                         nil]; //// defined in GTLPlusConstants.h
                        
                        signIn.delegate = self;
                        [signIn authenticate];
                    }
                    
                    //                    }
                    
                });
            });
        }
            break;
        case 4:
        {
            
            ShareFirstStepViewController *share = [[ShareFirstStepViewController alloc] init];
            share.image_urls=url_of_images;
            share.type = FTP;
            [self.navigationController pushViewController:share animated:NO];
        }
            break;
        case 5:
        {
            
            
            NSString *urlString = [NSString stringWithFormat:@"http://lab1.esolzdemos.com/PXCimg/simplepush.php"];
            NSURL* requestURL = [NSURL URLWithString:urlString];
            NSLog(@"%@", urlString);
            
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
            [request setHTTPShouldHandleCookies:NO];
            [request setURL:requestURL];
            [request setTimeoutInterval:30];
            [request setHTTPMethod:@"POST"];
            NSURLResponse *response = nil;
            NSError *error;
            
            NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
            [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
            
            NSMutableData *body = [NSMutableData data];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image_for_pinterest\"; filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[NSData dataWithData:UIImageJPEGRepresentation(_fullImage, 1.0)]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [request setHTTPBody:body];
            
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            NSLog(@" return String - %@",returnString);
            
            if([[returnString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@"Error"]||[[returnString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
            {
                [SVProgressHUD showErrorWithStatus:@" Error while saving the image for share"];
                return;
            }
            else
            {
                // NSLog(@" url is %@",url_of_image);
                _pinterest = [[Pinterest alloc] initWithClientId:@"1433202"];
                [_pinterest createPinWithImageURL:[NSURL URLWithString:returnString]
                                        sourceURL:[NSURL URLWithString:@"http://www.photoxchange.com"]
                                      description:@"via PXC"];
            }
            
            
            
        }
            break;
        case 6:
        {
            ShareFirstStepViewController *share = [[ShareFirstStepViewController alloc] init];
            share.image_urls=url_of_images;
            share.type = Email;
            [self.navigationController pushViewController:share animated:NO];
        }
            break;
    }
}

- (void)finishedSharing: (BOOL)shared {
    if (shared) {
        [SVProgressHUD showSuccessWithStatus:@"Successfully shared to Google+"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"User didn't share."];
        
    }
}
- (DBRestClient*)restClient {
    if (restClient == nil) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    return restClient;
}
-(void)showsts:(NSString *)status
{
    [SVProgressHUD showSuccessWithStatus:status];
}



//- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth
//
//                   error:(NSError *)error {
//    if (error) {
//
//        NSLog(@" here %@",
//              [NSString stringWithFormat:@"Status: Authentication error: %@", error]);
//
//        return;
//    }
//    else
//    {
//        GTLServicePlus* plusService = [[GTLServicePlus alloc] init];
//
//        plusService.retryEnabled = YES;
//
//        plusService=[GPPSignIn sharedInstance].plusService;
//
//        GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
//
//        [plusService executeQuery:query
//
//                completionHandler:^(GTLServiceTicket *ticket,
//
//                                    GTLPlusPerson *person,
//
//                                    NSError *error) {
//
//                    if (error) {
//                        GTMLoggerError(@"Error:  and here %@", error);
//
//                    } else {
//
//                        id<GPPNativeShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];
//
//                        // Set any prefilled text that you might want to suggest
//
//                        [shareBuilder setPrefillText:[NSString stringWithFormat:@"via QuiqFind"]];
//
//                        [shareBuilder attachImage:[UIImage imageNamed:@"50.png"]];
//
//                        [shareBuilder open];
//
////                        id<GPPShareBuilder> shareBuilder = [[GPPShare sharedInstance] shareDialog];
////
////                        // This line will fill out the title, description, and thumbnail of the item
////                        // you're sharing based on the URL you included.
////                        [shareBuilder setURLToShare:URL];//
////
////                        [shareBuilder setPrefillText:@"Hey! Its working"];
////                        // if somebody opens the link on a supported mobile device
//////                        [shareBuilder setContentDeepLinkID:@"rest=1234567"];
////
////                        [shareBuilder open];
//
//                    }
//                }];
//    }
//}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error
{
    NSLog(@"Received error %@ and auth object %@",error, auth);
    
    if (error) {
        
        
    }
    
    else{
        
        id<GPPShareBuilder> shareBuilder = [[GPPShare sharedInstance] shareDialog];
        
        // This line will fill out the title, description, and thumbnail of the item
        // you're sharing based on the URL you included.
        [shareBuilder setURLToShare:[NSURL URLWithString:returnString_gimg]];//
        
        [shareBuilder setPrefillText:@"Shared via PhotoXchange"];
        // if somebody opens the link on a supported mobile device
        [shareBuilder setContentDeepLinkID:@"rest=1234567"];
        
        [shareBuilder open];
        
        //        id<GPPNativeShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];
        //
        //        // This line will fill out the title, description, and thumbnail from
        //        // the URL that you are sharing and includes a link to that URL.
        ////        [shareBuilder setURLToShare:[NSURL URLWithString:@"https://www.example.com/restaurant/sf/1234567/"]];
        //        [shareBuilder setPrefillText:@"PhotoXchange"];
        //
        //        [shareBuilder attachImage:self.fullImage];
        //
        //        [shareBuilder open];
    }
}
@end