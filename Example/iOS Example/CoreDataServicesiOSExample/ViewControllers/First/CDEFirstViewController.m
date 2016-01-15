//
//  FirstViewController.m
//  CoreDataServicesiOSExample
//
//  Created by William Boles on 15/01/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import "CDEFirstViewController.h"

#import <CoreDataServices/CDSServiceManager.h>
#import <CoreDataServices/NSManagedObjectContext+CDSRetrieval.h>

#import "CDEUser.h"
#import "CDEUserTableViewCell.h"

@interface CDEFirstViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *users;

@end

@implementation CDEFirstViewController

#pragma mark - ViewLifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*-------------------*/
    
    self.title = @"Users";
    
    /*-------------------*/
    
    [self.view addSubview:self.tableView];
}

#pragma mark - Subview

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame
                                                  style:UITableViewStylePlain];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerClass:[CDEUserTableViewCell class]
           forCellReuseIdentifier:[CDEUserTableViewCell reuseIdentifier]];
    }
    
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CDEUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CDEUserTableViewCell reuseIdentifier]
                                                                 forIndexPath:indexPath];
    
    CDEUser *user = self.users[indexPath.row];
    
    cell.nameLabel.text = user.name;
    cell.ageLabel.text = [NSString stringWithFormat:@"%@", user.age];
    
    [cell layoutByApplyingConstraints];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}

#pragma mark - Users

- (NSArray *)users
{
    if (!_users)
    {
        NSSortDescriptor *ageSort = [NSSortDescriptor sortDescriptorWithKey:@"age"
                                                                  ascending:YES];
        
        _users = [[CDSServiceManager sharedInstance].managedObjectContext cds_retrieveEntriesForEntityClass:[CDEUser class]
                                                                                            sortDescriptors:@[ageSort]];
    }
    
    return _users;
}

@end
