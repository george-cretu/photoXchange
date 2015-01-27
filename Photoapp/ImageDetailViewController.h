//
//  ImageDetailViewController.h
//  Photoapp
//
//  Created by Iphone_1 on 18/09/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//
#import "ELCImagePickerController.h"
#import "ELCAlbumPickerController.h"
#import "ELCAssetTablePicker.h"
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <DropboxSDK/DropboxSDK.h>
#import "HomeViewController.h"

@class DBRestClient;
@interface ImageDetailViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate,DBRestClientDelegate,UIAlertViewDelegate,UITextFieldDelegate>
{
    UIScrollView *scroll_for_images;
    UIPageControl * pageControl;
    UIImage *_fullImage;
    DBRestClient* restClient;
    UIImageView *buttonusertrouble;
    UILabel *headerlabel;
    UIButton *backButton;
    UIButton *share_btn;
    CGRect static_frame;
}
@property (nonatomic) int tag;
@property (nonatomic,retain)  UIImage *selected_image;
@property (nonatomic) BOOL imgtypestatic;
@property (nonatomic,retain) NSMutableArray *image_data_from_library,*pics_data,*url_of_images,*uploaded_image_urls;
@property (nonatomic, retain) UIImage *fullImage;
@property (nonatomic,retain) NSString *url_of_image, *album_name;
@property (nonatomic,assign) int selected_index;
- (void)setFullImage:(UIImage *)fullImageInstance;

@end