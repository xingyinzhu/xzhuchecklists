//
//  ChecklistItem.h
//  XYZCheckList
//
//  Created by Xingyin Zhu on 12-11-28.
//  Copyright (c) 2012年 Xingyin Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL checked;

- (void)toggleChecked;

@end

