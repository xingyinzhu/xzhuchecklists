//
//  ViewController.h
//  XYZCheckList
//
//  Created by Xingyin Zhu on 12-11-28.
//  Copyright (c) 2012年 Xingyin Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@class Checklist;



@interface ChecklistViewController : UITableViewController<ItemDetailViewControllerDelegate>


@property (nonatomic, strong) Checklist *checklist;

@end
