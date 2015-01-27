//
//  AlbumPickerController.h
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ELCAssetSelectionDelegate.h"
#import "ELCAssetPickerFilterDelegate.h"

@class ELCImageAlbumPickerController;
@protocol ELCImageAlbumPickerController <UINavigationControllerDelegate>
- (void) moveToFTP:(ELCImageAlbumPickerController *)picker;
@end

@interface ELCAlbumPickerController : UITableViewController <ELCAssetSelectionDelegate,UITextFieldDelegate>
@property (nonatomic,assign) id <ELCImageAlbumPickerController>mydelegate;
@property (nonatomic, assign) id<ELCAssetSelectionDelegate> parent;
@property (nonatomic, retain) NSMutableArray *assetGroups;
@property (nonatomic,retain) UIView *drop_dow_menu,*name_view;
// optional, can be used to filter the assets displayed
@property (nonatomic, assign) id<ELCAssetPickerFilterDelegate> assetPickerFilterDelegate;

@end

