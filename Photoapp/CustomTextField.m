//
//  CustomTextField.m
//  Photoapp
//
//  Created by Iphone_1 on 03/09/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField
- (CGRect) textRectForBounds: (CGRect) bounds
{
    CGRect origValue = [super textRectForBounds: bounds];
    
    /* Just a sample offset */
    return CGRectOffset(origValue, 0.0f, 4.25f);
}

- (CGRect) editingRectForBounds: (CGRect) bounds
{
    CGRect origValue = [super textRectForBounds: bounds];
    
    /* Just a sample offset */
    return CGRectOffset(origValue, 0.0f, 4.25f);
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
