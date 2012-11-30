//
//  ListDetailViewController.m
//  XYZCheckList
//
//  Created by Xingyin Zhu on 12-11-30.
//  Copyright (c) 2012年 Xingyin Zhu. All rights reserved.
//

#import "ListDetailViewController.h"
#import "Checklist.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController

@synthesize textField;
@synthesize doneBarButton;
@synthesize delegate;
@synthesize checklistToEdit;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.checklistToEdit != nil)
    {
        self.title = @"Edit Checklist";
        self.textField.text = self.checklistToEdit.name;
        self.doneBarButton.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancel
{
    [self.delegate listDetailViewControllerDidCancel:self];
}

- (IBAction)done
{
    if (self.checklistToEdit == nil)
    {
        
        //NSLog(@"i am here ok !");
        Checklist *checklist = [[Checklist alloc] init];
        
        checklist.name = self.textField.text;
                            
        [self.delegate listdetailViewController:self didFinishAddingChecklist:checklist];
    }
    else
    {
        self.checklistToEdit.name = self.textField.text;
        [self.delegate listdetailViewController:self didFinishEditingChecklist:self.checklistToEdit];
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
    return YES;
}



@end
