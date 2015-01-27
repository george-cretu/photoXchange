//
//  HomeViewController.h
//  Photoapp
//
//  Created by Soumalya on 20/05/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ELCImagePickerController.h"
#import "ImageDetailViewController.h"
#import "AppDelegate.h"
@class KOAProgressBar;
@class YLProgressBar;
@interface HomeViewController : UIViewController<UIScrollViewDelegate,ELCImagePickerControllerDelegate> {
    UIButton *profileButton;
    UIButton *importButton;
    UIButton *galleryButton;
    UIButton *logoutButton;
    KOAProgressBar *progressBar;
    NSTimer *_timer;
    float progress;
    ALAssetsLibrary *assetsLibrary;
    NSMutableArray *groups;
    ALAssetsGroup *assetsGroup;
    NSMutableArray *assets;
}
@property (nonatomic,retain) AppDelegate *delegate;
@property (nonatomic, retain) ALAssetsLibrary *specialLibrary;
@property (nonatomic, strong) IBOutlet YLProgressBar  *progressBarRoundedSlim;

- (void)_timerFired;
- (void)getPhotosFromAlbum;

@end
