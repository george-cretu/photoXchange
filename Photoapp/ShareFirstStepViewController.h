//
//  ShareFirstStepViewController.h
//  Photoapp
//
//  Created by Iphone_1 on 09/01/14.
//  Copyright (c) 2014 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSTCollectionView.h"
#import <MessageUI/MessageUI.h>
#import <DropboxSDK/DropboxSDK.h>
@class DBRestClient;

typedef enum {
   Email,
   FTP,
   Dropbox
} shareType;
@interface ShareFirstStepViewController : UIViewController<PSTCollectionViewDataSource, PSTCollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate,MFMailComposeViewControllerDelegate, DBRestClientDelegate>
{
    DBRestClient* restClient;
}
@property (nonatomic,retain) NSMutableArray *image_urls;
@property (atomic) shareType *type;
@end
