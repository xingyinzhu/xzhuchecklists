//
//  AddItemViewController.h
//  XYZCheckList
//
//  Created by Xingyin Zhu on 12-11-28.
//  Copyright (c) 2012年 Xingyin Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemDetailViewController;
@class ChecklistItem;

@protocol ItemDetailViewControllerDelegate <NSObject>

- (void) itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller;
- (void) itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item;
- (void) itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item;


@end


@interface ItemDetailViewController : UITableViewController <UITextFieldDelegate>

- (IBAction)cancel;
- (IBAction)done;

@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;

@property (nonatomic, weak) id <ItemDetailViewControllerDelegate> delegate;

@property (nonatomic, strong) ChecklistItem *itemToEdit;

@end
