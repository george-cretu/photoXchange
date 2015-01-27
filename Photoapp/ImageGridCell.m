//
//  ImageGridCell.m
//  SelectionDelegateExample
//
//  Created by orta therox on 06/11/2012.
//  Copyright (c) 2012 orta therox. All rights reserved.
//

#import "ImageGridCell.h"

@implementation ImageGridCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIView *background = [[UIView alloc] init];
        background.backgroundColor = [UIColor colorWithRed:0.109 green:0.419 blue:0.000 alpha:1.000];
        self.selectedBackgroundView = background;

        _image = [[UIImageView alloc] init];
        _image.contentMode = UIViewContentModeScaleAspectFit;
        
        _overlayView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Overlay.png"]];
        [self.contentView addSubview:_image];
        [self.contentView addSubview:_overlayView];
        _overlayView.hidden=YES;
       
    }
    return self;
}

- (void)layoutSubviews {    
    _image.frame = CGRectMake(0, 0, 74, 74);
    _overlayView.frame = CGRectMake(0, 0, 74, 74);
    
}

- (void)setHighlighted:(BOOL)highlighted {
//    NSLog(@"Cell %@ highlight: %@", _label.text, highlighted ? @"ON" : @"OFF");
//    if (highlighted) {
//        _label.backgroundColor = [UIColor yellowColor];
//    }
//    else {
//        _label.backgroundColor = [UIColor underPageBackgroundColor];
//    }
}

@end
