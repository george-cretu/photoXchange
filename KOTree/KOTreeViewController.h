//
//  KOSelectingViewController.h
//  Kodiak
//
//  Created by Adam Horacek on 18.04.12.
//  Copyright (c) 2012 Adam Horacek, Kuba Brecka
//
//  Website: http://www.becomekodiak.com/
//  github: http://github.com/adamhoracek/KOTree
//	Twitter: http://twitter.com/becomekodiak
//  Mail: adam@becomekodiak.com, kuba@becomekodiak.com
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

//UIAlertView *show_alert1;
//show_alert1 = [[UIAlertView alloc] initWithTitle:@"Successfully Shared to pXc Website!!" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
////                show_alert1.delegate=self;
//[show_alert1 show];

#import "KOTreeTableViewCell.h"

@interface KOTreeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, KOTreeTableViewCellDelegate,UIAlertViewDelegate,NSURLSessionDataDelegate>

@property (nonatomic, strong) UITableView *treeTableView;
@property (nonatomic, strong) NSMutableArray *treeItems,*another_new_array;
@property (nonatomic, strong) NSMutableArray *selectedTreeItems;
@property (nonatomic,strong) NSString *folder_path_to_be_moved, *image_to_be_copy, *imageName;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,retain) UIImage *img_to_be_shared;
@property (nonatomic,retain) NSString *asset_url, *func_type;
@property (nonatomic,retain) NSMutableArray *original_array,*img_to_shared_array;
@property (nonatomic, strong) NSOperationQueue *networkQueue;
@end
