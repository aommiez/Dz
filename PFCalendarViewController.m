//
//  PFCalendarViewController.m
//  DanceZone
//
//  Created by aOmMiez on 9/4/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFCalendarViewController.h"

@interface PFCalendarViewController ()

@end

@implementation PFCalendarViewController
BOOL load;
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
    load = NO;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.monthView selectDate:[NSDate date]];
    self.dateStart = [[NSDate alloc]init];
    self.dateEnd = [[NSDate alloc] init];
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:@"Calendar"];
    [self.navigationItem setTitleView:myLabel];

    //[self.monthView reloadData];
    [self performSelector:@selector(CalenLoading) withObject:self afterDelay:0];
}
- (void)CalenLoading {
    [self.monthView setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Bangkok"]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backTapped{
    [self.view removeFromSuperview];
}
#pragma mark MonthView Delegate & DataSource
- (NSArray*) calendarMonthView:(TKCalendarMonthView*)monthView marksFromDate:(NSDate*)startDate toDate:(NSDate*)lastDate{
    //[self.dataArray removeAllObjects];
	[self testItem:startDate endDate:lastDate];
	return self.dataArray;
}
- (void) calendarMonthView:(TKCalendarMonthView*)monthView didSelectDate:(NSDate*)date{
	[self.tableView reloadData];
}
- (void) calendarMonthView:(TKCalendarMonthView*)mv monthDidChange:(NSDate*)d animated:(BOOL)animated{
	[super calendarMonthView:mv monthDidChange:d animated:animated];
	[self.tableView reloadData];
    
}


#pragma mark UITableView Delegate & DataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSArray *ar = self.dataDictionary[[self.monthView dateSelected]];
	if(ar == nil) return 0;
	return [ar count];
}
- (UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	monthCell *cell = [tv dequeueReusableCellWithIdentifier:@"monthCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"monthCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
	NSArray *ar = self.dataDictionary[[self.monthView dateSelected]];
    
    if ([[ar[indexPath.row] objectForKey:@"obj_type"] isEqualToString:@"activity"] ) {
        cell.nameLabel.text = [ar[indexPath.row] objectForKey:@"name"];
        cell.timeLabel.text =  [ar[indexPath.row] objectForKey:@"start_time_2"];
    } else {
        cell.nameLabel.text = [[ar[indexPath.row] objectForKey:@"group"] objectForKey:@"name"];
        cell.timeLabel.text =  [ar[indexPath.row] objectForKey:@"start_time_2"];
    }
    
	//cell.textLabel.text = ar[indexPath.row];
    //NSLog(@"-- %@",ar[indexPath.row]);
	
    return cell;
	
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *ar = self.dataDictionary[[self.monthView dateSelected]];
    if ([[ar[indexPath.row] objectForKey:@"obj_type"] isEqualToString:@"activity"] ) {
        if (IS_WIDESCREEN) {
            PFActivitiesDetailViewController *activitiesDetailViewController = [[PFActivitiesDetailViewController alloc] initWithNibName:@"PFActivitiesDetailViewController_Wide" bundle:nil];
            activitiesDetailViewController.obj = ar[indexPath.row];
            [self.navigationController pushViewController:activitiesDetailViewController animated:YES];
        } else {
            PFActivitiesDetailViewController *activitiesDetailViewController = [[PFActivitiesDetailViewController alloc] initWithNibName:@"PFActivitiesDetailViewController" bundle:nil];
            activitiesDetailViewController.obj = ar[indexPath.row];
            [self.navigationController pushViewController:activitiesDetailViewController animated:YES];
        }
    } else {
        if (IS_WIDESCREEN) {
            PFClassDetailViewController *classDetailViewController = [[PFClassDetailViewController alloc] initWithNibName:@"PFClassDetailViewController_Wide" bundle:nil];
            classDetailViewController.obj = [ar[indexPath.row] objectForKey:@"group"];
            [self.navigationController pushViewController:classDetailViewController animated:YES];
        } else {
            PFClassDetailViewController *classDetailViewController = [[PFClassDetailViewController alloc] initWithNibName:@"PFClassDetailViewController" bundle:nil];
            classDetailViewController.obj = [ar[indexPath.row] objectForKey:@"group"];
            [self.navigationController pushViewController:classDetailViewController animated:YES];
        }
    }
    
    
}
- (void)testItem:(NSDate*)start endDate:(NSDate*)end{
    NSLog(@"Delegate Range: %@ %@ %ld",start,end,(long)[start daysBetweenDate:end]);
    self.dateStart = start;
    self.dateEnd = end;
    NSString *startString = [NSDate stringFromDate:start];
    NSString *endString = [NSDate stringFromDate:end];
 
    NSString *dateStart = [[NSString alloc] initWithFormat:@"%@",startString];
    NSString *dateEnd = [[NSString alloc] initWithFormat:@"%@",endString];
    dateStart = [dateStart substringToIndex:10];
    dateEnd = [dateEnd substringToIndex:10];
    //NSLog(@"%@ %@",dateStart,dateEnd);
    //NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@activity?list_mode=day&start_date=%@&end_date=%@",API_URL,dateStart,dateEnd]autorelease];
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@calendar?start_date=%@&end_date=%@",API_URL,dateStart,dateEnd]autorelease];
    NSLog(@"%@",urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];
    
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        self.dataArray = [NSMutableArray array];
        self.actArray = [NSMutableArray array];
        self.allDataArray = [NSMutableArray array];
        
        self.dataDictionary = [NSMutableDictionary dictionary];
        self.actDictionary = [NSMutableDictionary dictionary];
        self.stuDictionary = [NSMutableDictionary dictionary];
        NSDate *d = start;
        int i = 0;
        while(YES){
            NSDateComponents *info = [d dateComponentsWithTimeZone:self.monthView.timeZone];
            
            if ( [[[[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"studies"] objectForKey:@"has_data"] isEqualToString:@"no"]  ) {
                //[self.dataArray addObject:@NO];
                //[self.actArray addObject:@NO];
            } else if ( [[[[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"studies"] objectForKey:@"has_data"] isEqualToString:@"yes"] ){
                //[self.dataDictionary[d] addObject:[[[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"studies"] objectForKey:@"data"]];
                //(self.dataDictionary)[d] = [[[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"studies"] objectForKey:@"data"];
                //NSLog(@"%@",[[[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"studies"] objectForKey:@"data"]);
                //NSLog(@"%@",self.dataDictionary[d]);
                (self.dataDictionary)[d] = [[[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"studies"] objectForKey:@"data"];
                //[self.dataArray addObject:@YES];
            }
            
            if ( [[[[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"activities"] objectForKey:@"has_data"] isEqualToString:@"no"]  ) {
                [self.dataArray addObject:@NO];
                //[self.actArray addObject:@NO];
            } else if ( [[[[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"activities"] objectForKey:@"has_data"] isEqualToString:@"yes"] ){
                //[self.dataDictionary[d] addObject:[[[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"activities"] objectForKey:@"data"]];
                //(self.dataDictionary)[d] = [[[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"activities"] objectForKey:@"data"];
                //NSLog(@"%@",[[[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"studies"] objectForKey:@"data"]);
                //NSLog(@"%@",self.dataDictionary[d]);
                (self.dataDictionary)[d] = [[[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"activities"] objectForKey:@"data"];
                [self.dataArray addObject:@YES];
            }
            
            if ( [[[[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"activities"] objectForKey:@"has_data"] isEqualToString:@"yes"] && [[[[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"studies"] objectForKey:@"has_data"] isEqualToString:@"yes"] ) {
                (self.dataDictionary)[d] = [[[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"all"] objectForKey:@"data"];
            }
            
            /*
            if ( [[[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"length"] intValue] == 0) {
                [self.dataArray addObject:@NO];
            } else if ( [[[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"length"] intValue] > 0 ){
                (self.dataDictionary)[d] = [[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"data"];
                NSLog(@"%@",[[[dict objectForKey:@"data"]objectAtIndex:i] objectForKey:@"data"]);
                [self.dataArray addObject:@YES];
            }
            */
            i++;
            info.day++;
            d = [NSDate dateWithDateComponents:info];
            if([d compare:end]==NSOrderedDescending) break;
            NSLog(@"%@",(self.dataDictionary));
        }
    }];
    [request setFailedBlock:^{
        
    }];
    [request startSynchronous];
    
    NSLog(@"--------------- %@",self.dataArray);
    //PFActivitiesManager *activitiesManager = [[PFActivitiesManager alloc] init];
    //activitiesManager.delegate = self;
    //[activitiesManager getactivitiCalerdar:dateStart endDate:dateEnd sDate:start eDate:end];

}
- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end {
	// this function sets up dataArray & dataDictionary
	// dataArray: has boolean markers for each day to pass to the calendar view (via the delegate function)
	// dataDictionary: has items that are associated with date keys (for tableview)
	
	
	NSLog(@"Delegate Range: %@ %@ %ld",start,end,(long)[start daysBetweenDate:end]);
	
	self.dataArray = [NSMutableArray array];
	self.dataDictionary = [NSMutableDictionary dictionary];
	
	NSDate *d = start;
	while(YES){
		
		NSInteger r = arc4random();
		if(r % 3==1){
			(self.dataDictionary)[d] = @[@"Item one",@"Item two"];
			[self.dataArray addObject:@YES];
		}else if(r%4==1){
			(self.dataDictionary)[d] = @[@"Item one"];
			[self.dataArray addObject:@YES];
			
		}else
			[self.dataArray addObject:@NO];
		
		
		NSDateComponents *info = [d dateComponentsWithTimeZone:self.monthView.timeZone];
		info.day++;
		d = [NSDate dateWithDateComponents:info];
        //NSLog(@"%@",info.day);
		if([d compare:end]==NSOrderedDescending) break;
	}
	
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self.navigationController.visibleViewController isKindOfClass:[PFActivitiesDetailViewController class]]) {
        
    } else {
        if (self.navigationController.visibleViewController != self) {
            if([self.delegate respondsToSelector:@selector(PFCalendarViewControllerBack)]){
                [self.delegate PFCalendarViewControllerBack];
            }
        }
    }
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
@end
