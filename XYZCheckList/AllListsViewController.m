//
//  AllListsViewController.m
//  XYZCheckList
//
//  Created by Xingyin Zhu on 12-11-30.
//  Copyright (c) 2012年 Xingyin Zhu. All rights reserved.
//

#import "AllListsViewController.h"
#import "Checklist.h"
#import "ChecklistViewController.h"

@interface AllListsViewController ()

@end

@implementation AllListsViewController
{
    NSMutableArray *lists;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        lists = [[NSMutableArray alloc] initWithCapacity:20];
        
        Checklist *list;
        
        list = [[Checklist alloc] init];
        list.name = @"Birthdays";
        [lists addObject:list];
        
        list = [[Checklist alloc] init];
        list.name = @"Groceries";
        [lists addObject:list];
        
        list = [[Checklist alloc] init];
        list.name = @"Cool Apps";
        [lists addObject:list];
        
        list = [[Checklist alloc] init];
        list.name = @"To Do";
        [lists addObject:list];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Checklist *checklist = [lists objectAtIndex:indexPath.row];
    
    cell.textLabel.text = checklist.name;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowChecklist"])
    {
        ChecklistViewController *controller = segue.destinationViewController;
        controller.checklist = sender;
    }
    else if ([segue.identifier isEqualToString:@"AddChecklist"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
        controller.checklistToEdit = nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Checklist *checklist = [lists objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
}

- (void)listdetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(Checklist *)checklist
{
    
    //NSLog(@"i am here haha");
    int newRowIndex = [lists count];
    //NSLog(@"i am here 0");
    [lists addObject:checklist];
    
    //NSLog(@"i am here 1");
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    //NSLog(@"i am here 2");
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    //NSLog(@"i am here 3");
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    //NSLog(@"i am here 4");
    [self dismissViewControllerAnimated:YES completion:nil];
    //sNSLog(@"i am here ");

}

- (void)listdetailViewController:(ListDetailViewController *)controller didFinishEditingChecklist:(Checklist *)checklist
{
    int index = [lists indexOfObject:checklist];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = checklist.name;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [lists removeObjectAtIndex:indexPath.row];
    
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *navigationController = [self.storyboard
                                                    instantiateViewControllerWithIdentifier:@"ListNavigationController"];
    ListDetailViewController *controller = (ListDetailViewController *) navigationController.topViewController;
    controller.delegate = self;
    Checklist *checklist = [lists objectAtIndex:indexPath.row];
    controller.checklistToEdit = checklist;
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end

