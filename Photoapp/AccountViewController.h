//
//  AccountViewController.h
//  Photoapp
//
//  Created by Esolz Technologies on 08/05/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "imageViewerViewController.h"

@interface AccountViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate> {
    ALAssetsLibrary *assetsLibrary;
    NSMutableArray *groups;
    ALAssetsGroup *assetsGroup;
    NSMutableArray *assets;
    BOOL tableVAppeared;
    NSString  *documentsDirectory;
    NSArray *directoryContent;
    NSArray       *paths;
    NSMutableArray *directoryElements;
    imageViewerViewController *imageViewer;
    
    NSString *albumName;
    BOOL isImportEnabled;
    NSMutableArray *importArray;
}

@property (nonatomic,retain) UITableView *imagetable;

@end
