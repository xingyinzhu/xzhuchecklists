//
//  DatePickerViewController.h
//  XYZCheckList
//
//  Created by Xingyin Zhu on 12-12-2.
//  Copyright (c) 2012年 Xingyin Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DatePickerViewController;

@protocol DatePickerViewControllerDelegate <NSObject>

- (void)datePickerDidCancel:(DatePickerViewController *)picker;
- (void)datePicker:(DatePickerViewController *)picker didPickDate:(NSDate *)date;

@end

@interface DatePickerViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, weak) id<DatePickerViewControllerDelegate> delegate;
@property (nonatomic, strong) NSDate *date;


- (IBAction)cancel;
- (IBAction)done;
- (IBAction)dateChanged;

@end
