//
//  ChecklistItem.m
//  XYZCheckList
//
//  Created by Xingyin Zhu on 12-11-28.
//  Copyright (c) 2012年 Xingyin Zhu. All rights reserved.
//

#import "ChecklistItem.h"

@implementation ChecklistItem

@synthesize text, checked;


- (void)toggleChecked
{
    self.checked = !self.checked;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
    }
    return self;
}


@end
