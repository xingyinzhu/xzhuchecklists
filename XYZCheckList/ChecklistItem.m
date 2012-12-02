//
//  ChecklistItem.m
//  XYZCheckList
//
//  Created by Xingyin Zhu on 12-11-28.
//  Copyright (c) 2012年 Xingyin Zhu. All rights reserved.
//

#import "ChecklistItem.h"
#import "DataModel.h"

@implementation ChecklistItem

@synthesize text, checked;
@synthesize dueDate, shouldRemind, itemId;

-(id)init
{
    if (self = [super init])
    {
        self.itemId = [DataModel nextChecklistItemId];
    }
    return self;
}

- (void)toggleChecked
{
    self.checked = !self.checked;
}

- (UILocalNotification *)notificationFortThisItem
{
    NSArray *allNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *notification in allNotifications)
    {
        NSNumber *number = [notification.userInfo objectForKey:@"ItemID"];
        if (number != nil && [number intValue] == self.itemId)
        {
            return notification;
        }
    }
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
    
    [aCoder encodeObject:self.dueDate forKey:@"DueDate"];
    [aCoder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
    [aCoder encodeInt:self.itemId forKey:@"ItemID"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
        
        //NSLog(@"before!!");
        self.dueDate = [aDecoder decodeObjectForKey:@"DueDate"];
        self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
        self.itemId = [aDecoder decodeIntForKey:@"ItemID"];
        //NSLog(@"After!!!");
        
    }
    return self;
}

- (void)scheduleNotification
{
    
    UILocalNotification *existingNotification = [self notificationFortThisItem];
    if (existingNotification != nil)
    {
        NSLog(@"Found an existing notification %@",existingNotification);
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }
    
    if (self.shouldRemind && [self.dueDate compare:[NSDate date]] != NSOrderedAscending)
    {
        //NSLog(@"We should schedule a notification");
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = self.dueDate;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.alertBody = self.text;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:self.itemId] forKey:@"ItemID"];
        [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
        
        NSLog(@"Scheduled notification %@ for itemId %d",localNotification,self.itemId);
    }
}


-(void)dealloc
{
    UILocalNotification *existingNotification = [self notificationFortThisItem];
    
    if (existingNotification != nil)
    {
        NSLog(@"Removing existing notification %@",existingNotification);
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }
}
@end
