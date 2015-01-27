//
//  SetViewController.h
//  Photoapp
//
//  Created by Admin on 12/08/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>{
    UITableView *tableview;
    NSArray *theArray;
    NSOperationQueue *que;
}
@property(nonatomic)UITableView *tableview;


@property (nonatomic,retain) IBOutlet UILabel *labeltext;
@end

/*
 CATransition* transition = [CATransition animation];
 transition.duration = 0.5;
 transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 transition.type = kCATransitionFade;
 HomeViewController *control1 = [[HomeViewController alloc] init];
 [self.navigationController.view.layer addAnimation:transition forKey:nil];
 [[self navigationController] pushViewController:control1 animated:NO];
*/