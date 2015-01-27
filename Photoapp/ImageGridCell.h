//
//  ImageGridCell.h
//  SelectionDelegateExample
//
//  Created by orta therox on 06/11/2012.
//  Copyright (c) 2012 orta therox. All rights reserved.
//

#include "UILabel+Highlight.h"
#import "PSTCollectionView.h"
@interface ImageGridCell : PSUICollectionViewCell

@property (strong, nonatomic) UIImageView *image,*overlayView;

@end
