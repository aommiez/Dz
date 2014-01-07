//
//  PFActivitiesViewController.m
//  DanceZone
//
//  Created by aOmMiez on 8/31/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFActivitiesViewController.h"

@interface PFActivitiesViewController ()

@end

@implementation PFActivitiesViewController

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
    [myLabel setText:@"Activities"];
    [self.navigationItem setTitleView:myLabel];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    PFActivitiesManager *activitiesManager = [[PFActivitiesManager alloc] init];
    activitiesManager.delegate = self;
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatterM = [[NSDateFormatter alloc]init];
    [dateFormatterM setDateFormat:@"MM"];
    NSString *dateStringM = [dateFormatterM stringFromDate:currDate];
    NSDateFormatter *dateFormatterY = [[NSDateFormatter alloc]init];
    [dateFormatterY setDateFormat:@"YYYY"];
    NSString *dateStringY = [dateFormatterY stringFromDate:currDate];
    
 
    NSDateFormatter *dateFormatterMFull = [[NSDateFormatter alloc]init];
    [dateFormatterMFull setDateFormat:@"MMMM"];
    NSString *dateStringMFull = [dateFormatterMFull stringFromDate:currDate];

    [self.mButton setTitle:dateStringMFull forState:UIControlStateNormal];
    [activitiesManager getActivitiesByM:dateStringM year:dateStringY];
    self.tableData = [NSArray arrayWithObjects:@"HIPHOP", @"JAZZ", @"COVER" ,nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
  
    [_tableView release];
    [_navBg release];
    [_mButton release];
    [super dealloc];
}
- (void)back {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.obj objectForKey:@"length"] integerValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFActivitiesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivitiesCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ActivitiesCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.nameLabel.text = [[[self.obj objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"name"];

    NSString *m = [[[[self.obj objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"start_time"] substringFromIndex:8];
    m = [m substringToIndex:3];
    NSString *min = [[[[self.obj objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"start_time_2"] substringToIndex:5];
    NSString *minAMPM = [[[[self.obj objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"start_time_2"] substringFromIndex:5];
    cell.minLabel.text = min;
    cell.dayLabel.text  = m;
    cell.minLabel2.text = minAMPM;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (IS_WIDESCREEN) {
        PFActivitiesDetailViewController *activitiesDetailViewController = [[PFActivitiesDetailViewController alloc] initWithNibName:@"PFActivitiesDetailViewController_Wide" bundle:nil];
        activitiesDetailViewController.obj = [[self.obj objectForKey:@"data"]objectAtIndex:indexPath.row];
        activitiesDetailViewController.delegate = self;
        [self.navigationController pushViewController:activitiesDetailViewController animated:YES];
    } else {
        PFActivitiesDetailViewController *activitiesDetailViewController = [[PFActivitiesDetailViewController alloc] initWithNibName:@"PFActivitiesDetailViewController" bundle:nil];
        activitiesDetailViewController.obj = [[self.obj objectForKey:@"data"]objectAtIndex:indexPath.row];
        activitiesDetailViewController.delegate = self;
        [self.navigationController pushViewController:activitiesDetailViewController animated:YES];
    }
}

- (void)PFActivitiesManager:(id)sender getActivitiesByMResponse:(NSDictionary *)response {
    self.obj = response;
    [self.tableView reloadData];
    self.w.alpha = 0;
}
- (void)PFActivitiesManager:(id)sender getActivitiesByMErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.y);
	if ( scrollView.contentOffset.y < -40.0f ) {
        [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        self.loadLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [dateFormatter stringFromDate:[NSDate date]]];
        self.act.alpha =1;
    }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    //NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < -60.0f ) {
        PFActivitiesManager *activitiesManager = [[PFActivitiesManager alloc] init];
        activitiesManager.delegate = self;
        NSDate *currDate = [NSDate date];
        NSDateFormatter *dateFormatterM = [[NSDateFormatter alloc]init];
        [dateFormatterM setDateFormat:@"MM"];
        NSString *dateStringM = [dateFormatterM stringFromDate:currDate];
        NSDateFormatter *dateFormatterY = [[NSDateFormatter alloc]init];
        [dateFormatterY setDateFormat:@"YYYY"];
        NSString *dateStringY = [dateFormatterY stringFromDate:currDate];
        
        
        NSDateFormatter *dateFormatterMFull = [[NSDateFormatter alloc]init];
        [dateFormatterMFull setDateFormat:@"MMMM"];
        NSString *dateStringMFull = [dateFormatterMFull stringFromDate:currDate];
        
        [self.mButton setTitle:dateStringMFull forState:UIControlStateNormal];
        [activitiesManager getActivitiesByM:dateStringM year:dateStringY];
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if ( scrollView.contentOffset.y < -60.0f ) {
        [UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		self.tableView.frame = CGRectMake(0, 150, 320, self.tableView.frame.size.height);
		[UIView commitAnimations];
        
        [self performSelector:@selector(resizeTable) withObject:nil afterDelay:2];
    } else {
        self.loadLabel.text = @"";
        self.act.alpha = 0;
    }
}
- (void)resizeTable {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.tableView.frame = CGRectMake(0, 107, 320, self.tableView.frame.size.height);
    [UIView commitAnimations];
    self.loadLabel.text = @"";
    self.act.alpha = 0;
}
- (void)PFActivitiesDetailViewControllerPhoto:(NSString *)link {
    [self.delegate PFActivitiesViewControllerPhoto:link];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self.navigationController.visibleViewController isKindOfClass:[PFActivitiesDetailViewController class]]) {
        
    } else {
        if (self.navigationController.visibleViewController != self) {
            if([self.delegate respondsToSelector:@selector(PFActivitiesViewControllerBack)]){
                [self.delegate PFActivitiesViewControllerBack];
            }
        }
    }
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
@end
