//
//  LibraryViewController.h
//  Photoapp
//
//  Created by Soumalya on 18/06/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "imageViewerViewController.h"

@interface LibraryViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    NSString *albumName;
    UITableView *libraryTable;
    BOOL tableVAppeared;
    
    ALAssetsLibrary *assetsLibrary;
    NSMutableArray *groups;
    ALAssetsGroup *assetsGroup;
    NSMutableArray *assets;
    imageViewerViewController *imageViewer;
    NSMutableArray *static_imgs,*mutableArray;
    NSTimer *timer_foraction;
    NSOperationQueue *fetch_que;
}
- (void)checkFTP;
- (void)getAllAssets;
- (void)viewFullPic:(UIGestureRecognizer *)gesture;

@end
