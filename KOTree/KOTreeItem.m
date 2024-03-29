//
//  KOSelectingItem.m
//  KOSelection
//
//  Created by Adam Horacek on 07.08.12.
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

#import "KOTreeItem.h"

@implementation KOTreeItem

@synthesize base, path;
@synthesize numberOfImages;
@synthesize numberOfSubitems;
@synthesize parentSelectingItem;
@synthesize ancestorSelectingItems;
@synthesize submersionLevel;

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    return [self isEqualToSelectingItem:other];
}

- (BOOL)isEqualToSelectingItem:(KOTreeItem *)selectingItem {
	if (self == selectingItem)
        return YES;
	
	if ([base isEqualToString:selectingItem.base])
		if ([path isEqualToString:selectingItem.path])
			if (numberOfSubitems == selectingItem.numberOfSubitems)
				return YES;
	
	return NO;
}


@end
