//
//  ImagePagingViewController.m
//  Photoapp
//
//  Created by maxcon4 on 28/02/14.
//  Copyright (c) 2014 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import "ImagePagingViewController.h"
#import "ChildViewController.h"
@interface ImagePagingViewController ()<UIPageViewControllerDataSource>
{
    UIView *countview;
    UILabel *countlabel;
    UIButton *button;
}
@property (strong, nonatomic) UIPageViewController *pageController;
@end

@implementation ImagePagingViewController
@synthesize ftp_path,array_new_images,pageController;
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
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height+30)];
    
    ChildViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
	
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7)
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bar@2x.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        
        
        self.navigationController.navigationBarHidden = NO;
        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars=NO;
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    else
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top-bar.png"] forBarMetrics:nil];
    }
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationItem setTitle:[NSString stringWithFormat:@"Images in %@ (1/%d)",ftp_path, [array_new_images count]]];
    self.navigationItem.titleView.tintColor= [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                                           UITextAttributeFont: [UIFont fontWithName:@"MyriadPro-Bold" size:18.5],
                                                           }];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
   [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@2x.png"]]];
    

    button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(gobackto_ftp:)forControlEvents:UIControlEventTouchUpInside];
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
    
    
//    countview =[[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-70, 0, 70, 70)];
//    [self.view addSubview:countview];
//    countview.layer.zPosition=3;
//    countview.backgroundColor=[UIColor whiteColor];
//    
//    countlabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-70, 0, 70, 70)];
//    [self.view addSubview:countlabel];
//    countlabel.backgroundColor=[UIColor yellowColor];
//    countlabel.layer.zPosition=3;
//    countlabel.text= [NSString stringWithFormat:@"1/%d",[array_new_images count]];
}
-(void)gobackto_ftp:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (ChildViewController *)viewControllerAtIndex:(NSUInteger)index
{
      NSLog(@"index current: %d",index);
    ChildViewController *childViewController = [[ChildViewController alloc] init];
    childViewController.index = index;
    childViewController.image_url = [array_new_images objectAtIndex:index];
    return childViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(ChildViewController *)viewController index];
    index--;

    if (index == -1) {
//        countlabel.text= [NSString stringWithFormat:@"%d/%d",index+2,[array_new_images count]];
         [self.navigationItem setTitle:[NSString stringWithFormat:@"Images in %@ (%d/%d)",ftp_path,index+2, [array_new_images count]]];
        return nil;

    }
 //   index--;
    NSLog(@"index before: %d",index);

//    countlabel.text= [NSString stringWithFormat:@"%d/%d",index+2,[array_new_images count]];
     [self.navigationItem setTitle:[NSString stringWithFormat:@"Images in %@ (%d/%d)",ftp_path,index+2, [array_new_images count]]];
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(ChildViewController *)viewController index];
    
    index++;
    NSLog(@"index after: %d",index);
//    countlabel.text= [NSString stringWithFormat:@"%d/%d",index,[array_new_images count]];
     [self.navigationItem setTitle:[NSString stringWithFormat:@"Images in %@ (%d/%d)",ftp_path,index, [array_new_images count]]];
    if (index == [array_new_images count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return [array_new_images count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
