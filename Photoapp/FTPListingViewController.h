//
//  FTPListingViewController.h
//  Photoapp
//
//  Created by Iphone_1 on 23/08/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCImagePickerController.h"
#import "ELCAlbumPickerController.h"

@interface FTPListingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,NSURLConnectionDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate,ELCImagePickerControllerDelegate,UIActionSheetDelegate>
{
    UITableView *list_tab;
    UIView *shadow_view,*new_folder_view;
    UILabel *title_lbl_for_new_view;
    UITextField *text_enter;
    NSURLConnection *conn;
    NSString *prev_directory;
    NSMutableData *responseData;
    BOOL intial,about_details,move;
    NSUInteger selectedindex;
    UIButton *ok_button;
     NSOperationQueue *que;
    NSMutableArray *folder_table_data;
}
@property (nonatomic,retain) NSMutableArray *folder_path_array;
@property (nonatomic,retain) NSString *director_string;
@property (nonatomic, strong) NSMutableArray *selectedIndexPaths;
@end
