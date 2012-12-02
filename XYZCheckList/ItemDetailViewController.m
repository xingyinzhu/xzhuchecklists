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
{
    NSString *text;
    BOOL shouldRemind;
    NSDate *dueDate;
}

@synthesize delegate;
@synthesize itemToEdit;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        text = @"";
        shouldRemind = NO;
        dueDate = [NSDate date];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && self.view.window == nil)
    {
        self.view = nil;
    }
    
    if (![self isViewLoaded])
    {
        self.textField = nil;
        self.doneBarButton = nil;
        self.switchControl = nil;
        self.dueDateLabel  = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.itemToEdit != nil)
    {
        /*
        self.title = @"Edit Item";
        self.textField.text = self.itemToEdit.text;
        self.doneBarButton.enabled = YES;
        self.switchControl.on = self.itemToEdit.shouldRemind;
        dueDate = self.itemToEdit.dueDate;
        */
        self.title = @"Edit Item";
    }
    
    self.textField.text = text;
    self.switchControl.on = shouldRemind;
    
    
    /*
    else
    {
        self.switchControl.on = NO;
        dueDate = [NSDate date];
    }
    */
    [self updateDoneBarButton];
    
    [self updateDueDateLabel];
    
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    text = textField.text;
    [self updateDoneBarButton];
}


- (void)updateDoneBarButton
{
    self.doneBarButton.enabled = ([text length] > 0);
}

- (void)updateDueDateLabel
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    self.dueDateLabel.text = [formatter stringFromDate:dueDate];
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
        item.shouldRemind = self.switchControl.on;
        item.dueDate = dueDate;
        [item scheduleNotification];
        
        [self.delegate itemDetailViewController:self didFinishAddingItem:item];
    }
    else
    {
        self.itemToEdit.text = self.textField.text;
        self.itemToEdit.shouldRemind = self.switchControl.on;
        self.itemToEdit.dueDate = dueDate;
        [self.itemToEdit scheduleNotification];
        
        [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
    {
        return indexPath;
    }
    else
    {
        return nil;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    [self updateDoneBarButton];
    
    //self.doneBarButton.enabled = ([newText length] > 0);
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

- (void)setItemToEdit:(ChecklistItem *)newItem
{
    if (itemToEdit != newItem)
    {
        itemToEdit = newItem;
        text = itemToEdit.text;
        shouldRemind = itemToEdit.shouldRemind;
        dueDate = itemToEdit.dueDate;
    }
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PickDate"])
    {
        DatePickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
        controller.date = dueDate;
    }
}

- (void)datePicker:(DatePickerViewController *)picker didPickDate:(NSDate *)date
{
    dueDate = date;
    [self updateDueDateLabel];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)datePickerDidCancel:(DatePickerViewController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)switchChanged:(UISwitch *)sender
{
    shouldRemind = sender.on;
}



@end
