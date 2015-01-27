//
//  KOSelectingTableViewCell.m
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

#import "KOTreeTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "KOTreeViewController.h"

#define KOCOLOR_FILES_TITLE [UIColor colorWithRed:0.4 green:0.357 blue:0.325 alpha:1] /*#665b53*/
#define KOCOLOR_FILES_TITLE_SHADOW [UIColor colorWithRed:1 green:1 blue:1 alpha:1] /*#ffffff*/
#define KOCOLOR_FILES_COUNTER [UIColor colorWithRed:0.608 green:0.376 blue:0.251 alpha:1] /*#9b6040*/
#define KOCOLOR_FILES_COUNTER_SHADOW [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35] /*#ffffff*/
#define KOFONT_FILES_TITLE [UIFont fontWithName:@"HelveticaNeue" size:12.0f]
#define KOFONT_FILES_COUNTER [UIFont fontWithName:@"HelveticaNeue-Bold" size:11.0f]

@implementation KOTreeTableViewCell

@synthesize backgroundImageView;
@synthesize iconButton;
@synthesize titleTextField;
@synthesize countLabel;
@synthesize delegate;
@synthesize treeItem;
@synthesize upload_button,func_type;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		
		backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"copymove-cell-bg"]];
		[backgroundImageView setContentMode:UIViewContentModeCenter];
		
		[self setBackgroundView:backgroundImageView];
//        [self setBackgroundColor:[UIColor colorWithRed:(87.0f/255.0f) green:(87.0f/255.0f) blue:(87.0f/255.0f) alpha:0.75f]];
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
		
		iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[iconButton setFrame:CGRectMake(200, 0, 100, 65)];
		[iconButton setAdjustsImageWhenHighlighted:NO];
		[iconButton addTarget:self action:@selector(iconButtonAction:) forControlEvents:UIControlEventTouchUpInside];
		[iconButton setImage:[UIImage imageNamed:@"item-icon-folder"] forState:UIControlStateNormal];
		[iconButton setImage:[UIImage imageNamed:@"item-icon-folder-selected"] forState:UIControlStateSelected];
		[iconButton setImage:[UIImage imageNamed:@"item-icon-folder-selected"] forState:UIControlStateHighlighted];
		[self.contentView addSubview:iconButton];
		
		titleTextField = [[UITextField alloc] init];
		[titleTextField setFont:KOFONT_FILES_TITLE];
		[titleTextField setTextColor:KOCOLOR_FILES_COUNTER];
		[titleTextField.layer setShadowColor:KOCOLOR_FILES_TITLE_SHADOW.CGColor];
		[titleTextField.layer setShadowOffset:CGSizeMake(0, 1)];
		[titleTextField.layer setShadowOpacity:1.0f];
		[titleTextField.layer setShadowRadius:0.0f];
		
		[titleTextField setUserInteractionEnabled:NO];
		[titleTextField setBackgroundColor:[UIColor clearColor]];
		[titleTextField sizeToFit];
		[titleTextField setFrame:CGRectMake(90, 20, titleTextField.frame.size.width, titleTextField.frame.size.height)];
        [titleTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [titleTextField setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
		[self.contentView addSubview:titleTextField];
		


        upload_button = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2+100, (self.frame.size.height-28)/2+10.5f, 47, 28)];
		[upload_button setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
		[upload_button setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"item-counter"]]];
//        [upload_button setBackgroundColor:[UIColor colorWithRed:(205.0f/255) green:(92.0f/255.0f) blue:(92.0f/255.0f) alpha:1]];
		[upload_button setTextAlignment:NSTextAlignmentCenter];
        [upload_button setText:@"Upload"];
        [upload_button setTextColor:[UIColor whiteColor]];
		[upload_button setLineBreakMode:NSLineBreakByTruncatingMiddle];
		[upload_button setFont:KOFONT_FILES_COUNTER];
		[upload_button setTextColor:KOCOLOR_FILES_COUNTER];
		[upload_button setShadowColor:KOCOLOR_FILES_COUNTER_SHADOW];
		[upload_button setShadowOffset:CGSizeMake(0, 1)];
        [upload_button setUserInteractionEnabled:YES];
        
        
        UITapGestureRecognizer *tap_action = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openToUpload:)];
        [tap_action setNumberOfTapsRequired:1];
        [tap_action setNumberOfTouchesRequired:1];
        [upload_button addGestureRecognizer:tap_action];
        
        [self.contentView addSubview:upload_button];
        
		[self.layer setMasksToBounds:YES];
		
		countLabel = [[UILabel alloc] initWithFrame:CGRectMake(686, 28, 47, 28)];
		[countLabel setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
		[countLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"item-counter"]]];
        [countLabel setTextColor:[UIColor whiteColor]];
		[countLabel setTextAlignment:NSTextAlignmentCenter];
		[countLabel setLineBreakMode:NSLineBreakByTruncatingMiddle];
		[countLabel setFont:KOFONT_FILES_COUNTER];
		[countLabel setTextColor:KOCOLOR_FILES_COUNTER];
		[countLabel setShadowColor:KOCOLOR_FILES_COUNTER_SHADOW];
		[countLabel setShadowOffset:CGSizeMake(0, 1)];
		
        
        
		[self setAccessoryView:countLabel];
		[self.accessoryView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin];
        
//        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width+100, 1)];/// change size as you need.
//        separatorLineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@2x.png"]];
//        [separatorLineView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
//        [self.contentView addSubview:separatorLineView];
		
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}

- (void)setLevel:(NSInteger)level {
	CGRect rect;
	
    if(!iconButton.hidden)
    {
        rect = iconButton.frame;
        rect.origin.x = 25;
        iconButton.frame = rect;
        
        rect = titleTextField.frame;
        rect.origin.x = 25;
        titleTextField.frame = rect;
        [iconButton setFrame:CGRectMake(190, 0, 100, 65)];

    }
    else
    {
        rect = titleTextField.frame;
        rect.origin.x = 25;
        titleTextField.frame = rect;
    }
	
}
-(void)openToUpload:(UITapGestureRecognizer *)sender
{
//    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"function_type"] isEqualToString:@"COPY"]) {
//        NSLog(@"yes copy function will work now");
//        
//        if (delegate && [delegate respondsToSelector:@selector(treeTableViewCell:copyImageTo:)]) {
//            [delegate treeTableViewCell:(KOTreeTableViewCell *)self didTapIconWithTreeItem:(KOTreeItem *)treeItem];
//        }
//
//    
//    }
//    else
//    {
     if (delegate && [delegate respondsToSelector:@selector(treeTableViewCell:didTapIconWithTreeItem:)]) {
        [delegate treeTableViewCell:(KOTreeTableViewCell *)self didTapIconWithTreeItem:(KOTreeItem *)treeItem];
     }
//    }
}
- (void)iconButtonAction:(id)sender {

if (delegate && [delegate respondsToSelector:@selector(treeTableViewCell:uploadImageTo:)]) {
                [delegate treeTableViewCell:(KOTreeTableViewCell *)self uploadImageTo:(KOTreeItem *)treeItem];
            }
}

@end
