//
//  AllListsViewController.h
//  XYZCheckList
//
//  Created by Xingyin Zhu on 12-11-30.
//  Copyright (c) 2012年 Xingyin Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"
#import "DataModel.h"

@interface AllListsViewController : UITableViewController<ListDetailViewControllerDelegate>

@property (nonatomic, strong) DataModel *dataModel;

@end
