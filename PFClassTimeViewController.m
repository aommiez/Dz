//
//  PFClassTimeViewController.m
//  DanceZone
//
//  Created by aOmMiez on 8/31/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFClassTimeViewController.h"

@interface PFClassTimeViewController ()

@end

@implementation PFClassTimeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.w.layer.cornerRadius = 5;
    self.w.layer.masksToBounds = YES;
    self.w.alpha = 1;
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:self.titleBar];
    [self.navigationItem setTitleView:myLabel];
    PFClassManager *classManager = [[PFClassManager alloc] init];
    classManager.delegate = self;
    [classManager getGroupByClassId:self.classId];
    UIView *topView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)]autorelease];;
    self.tableView.tableHeaderView = topView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [_navBg release];
    [super dealloc];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dict objectForKey:@"length"]integerValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFClassTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassTimeCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ClassTimeCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.label1.text = [[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.label2.text = [[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"description"];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_WIDESCREEN) {
        PFClassDetailViewController *classDetailViewController = [[PFClassDetailViewController alloc] initWithNibName:@"PFClassDetailViewController_Wide" bundle:nil];
        classDetailViewController.obj = [[self.dict objectForKey:@"data"]objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:classDetailViewController animated:YES];
    } else {
        PFClassDetailViewController *classDetailViewController = [[PFClassDetailViewController alloc] initWithNibName:@"PFClassDetailViewController" bundle:nil];
        classDetailViewController.obj = [[self.dict objectForKey:@"data"]objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:classDetailViewController animated:YES];
    }
}
- (void)PFClassManager:(id)sender getGroupByClassIdResponse:(NSDictionary *)response {
    self.dict = response;
    [self.tableView reloadData];
    self.w.alpha = 0;
}
- (void)PFClassManager:(id)sender getGroupByClassIdErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}
@end
