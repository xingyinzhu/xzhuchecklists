//
//  AddItemViewController.m
//  XYZCheckList
//
//  Created by Xingyin Zhu on 12-11-28.
//  Copyright (c) 2012年 Xingyin Zhu. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ChecklistItem.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

@synthesize delegate;
@synthesize itemToEdit;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.itemToEdit != nil)
    {
        self.title = @"Edit Item";
        NSLog(@"the string is %@",self.itemToEdit.text);
        self.textField.text = self.itemToEdit.text;
        self.doneBarButton.enabled = YES;
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}


- (IBAction)cancel
{
    //[self.presentingViewController dismissViewControllerAnimated:YES completion: nil];
    [self.delegate itemDetailViewControllerDidCancel:self];
}

- (IBAction)done
{
    if (self.itemToEdit == nil)
    {
        ChecklistItem *item = [[ChecklistItem alloc]init];
        item.text = self.textField.text;
        item.checked = NO;
    
        [self.delegate itemDetailViewController:self didFinishAddingItem:item];
    }
    else
    {
        self.itemToEdit.text = self.textField.text;
        [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    self.doneBarButton.enabled = ([newText length] > 0);
    /*
    if ([newText length] > 0)
    {
        self.doneBarButton.enabled = YES;
    }
    else
    {
        self.doneBarButton.enabled = NO;
    }
    */
    return YES;
    
}

@end
