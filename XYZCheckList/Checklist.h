//
//  Checklist.h
//  XYZCheckList
//
//  Created by Xingyin Zhu on 12-11-30.
//  Copyright (c) 2012年 Xingyin Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *iconName;

@property (nonatomic, strong) NSMutableArray *items;

- (int)countUncheckedItems;

@end
