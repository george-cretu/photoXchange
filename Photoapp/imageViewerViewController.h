//
//  imageViewerViewController.h
//  Photoapp
//
//  Created by Soumalya on 13/06/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <DropboxSDK/DropboxSDK.h>
@class DBRestClient;
@interface imageViewerViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate,DBRestClientDelegate>
{
    UIImage *_fullImage;
    CGRect screenRect;
    NSString *albumName;
    UIScrollView *pic_scroll;
    UIView *nav_bar;
    UIImageView *imageContainer;
    DBRestClient* restClient;
    BOOL shareviadropbox;
}
@property (nonatomic) BOOL imgtypestatic;
@property (nonatomic) NSMutableArray *image_data_from_library,*pics_data;
@property (nonatomic, retain) UIImage *fullImage;
- (void)setFullImage:(UIImage *)fullImageInstance;

@end
