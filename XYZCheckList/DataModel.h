//
//  DataModel.h
//  XYZCheckList
//
//  Created by Xingyin Zhu on 12-12-1.
//  Copyright (c) 2012年 Xingyin Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, strong) NSMutableArray *lists;
- (void)saveChecklists;

@end
