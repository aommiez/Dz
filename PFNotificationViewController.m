//
//  PFNotificationViewController.m
//  DanceZone
//
//  Created by aOmMiez on 10/4/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFNotificationViewController.h"

@interface PFNotificationViewController ()

@end

@implementation PFNotificationViewController
BOOL noDatazz;
BOOL refreshDataz;
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
    noDatazz = NO;
    refreshDataz = NO;
    [self.blurView setBlurTintColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:5]];
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:@"Notification"];
    [self.navigationItem setTitleView:myLabel];
    self.tableData = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    self.tableView.tableHeaderView = topView;
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.tableView.tableFooterView = footView;
    PFUserManager *userManager = [[PFUserManager alloc] init];
    userManager.delegate = self;
    [userManager getNotifiy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [_blurView release];
    [_textView release];
    [super dealloc];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.obj objectForKey:@"length"] integerValue];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NotificationCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if ([[[[self.obj objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"read"] isEqualToString:@"1"]){
        cell.bg.image = [UIImage imageNamed:@"NotBoxReadedIp4.png"];
    } else {
        cell.bg.image = [UIImage imageNamed:@"NotBoxNoReadIp4.png"];
    }
    
    cell.msgLabel.text = [[[self.obj objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"message"];
    cell.timeLabel.text = [[[self.obj objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"updated_at"];
    if ([[[[self.obj objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"showcase"] ) {
        cell.imgType.image = [UIImage imageNamed:@"ShowcaseNotIconIp5"];
    } else if ([[[[self.obj objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"news"] ) {
        cell.imgType.image = [UIImage imageNamed:@"UpdateNotIconIp5"];
    } else if ([[[[self.obj objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"lesson"] ) {
        cell.imgType.image = [UIImage imageNamed:@"LessonNotIconIp5"];
    } else if ([[[[self.obj objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"activity"] ) {
        cell.imgType.image = [UIImage imageNamed:@"NewsFormDZNotIconIp5"];
    } else {
        cell.imgType.image = [UIImage imageNamed:@"NewsFormDZNotIconIp5"];
    }
    return cell;
}

- (void)PFUserManager:(id)sender getNotifiyResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
    self.obj = response;
    [self.tableView reloadData];
}
- (void)PFUserManager:(id)sender getNotifiyErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationCell"];
    cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.bg.image = [UIImage imageNamed:@"NotBoxReadedIp4.png"];
    
    NSString *type = [[[self.obj objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"type"];
    //NSLog(@"not id :  %@",[[[self.obj objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"id"]);
    PFDzApi *dzApi = [[PFDzApi alloc] init];
    [dzApi DzApiReadNotify:[[[self.obj objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"id"]];
    
    if ( [type isEqualToString:@"showcase"]) {
        if (IS_WIDESCREEN) {
            PFYouTubeViewController *youTubeViewController = [[PFYouTubeViewController alloc] initWithNibName:@"PFYouTubeViewController_Wide" bundle:nil];
            youTubeViewController.youtubeId = [[[self.obj objectForKey:@"data"] objectAtIndex:[indexPath row]] objectForKey:@"object_id"];
            NSString *urlString = [[NSString alloc] initWithFormat:@"%@showcase/%@",API_URL,[[[self.obj objectForKey:@"data"] objectAtIndex:[indexPath row]] objectForKey:@"object_id"]];
            NSURL *url = [NSURL URLWithString:urlString];
            __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setCompletionBlock:^{
                // Use when fetching text data
                SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
                id resJson = [resultJson objectWithString:[request responseString]];
                NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
                youTubeViewController.youtubeObj = dict;
            }];
            [request setFailedBlock:^{
                //NSError *error = [request error];
            }];
            [request startSynchronous];

            [self.navigationController pushViewController:youTubeViewController animated:YES];
        } else {
            PFYouTubeViewController *youTubeViewController = [[PFYouTubeViewController alloc] initWithNibName:@"PFYouTubeViewController" bundle:nil];
            youTubeViewController.youtubeId = [[[self.obj objectForKey:@"data"] objectAtIndex:[indexPath row]] objectForKey:@"object_id"];
            NSString *urlString = [[NSString alloc] initWithFormat:@"%@showcase/%@",API_URL,[[[self.obj objectForKey:@"data"] objectAtIndex:[indexPath row]] objectForKey:@"object_id"]];
            NSURL *url = [NSURL URLWithString:urlString];
            __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setCompletionBlock:^{
                // Use when fetching text data
                SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
                id resJson = [resultJson objectWithString:[request responseString]];
                NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
                youTubeViewController.youtubeObj = dict;
            }];
            [request setFailedBlock:^{
                //NSError *error = [request error];
            }];
            [request startSynchronous];
            
            [self.navigationController pushViewController:youTubeViewController animated:YES];
        }
    } else if ([type isEqualToString:@"news"]) {
        if([self.delegate respondsToSelector:@selector(PFNotificationViewControllerNewsTapped:newsId:)]){
            [self.delegate PFNotificationViewControllerNewsTapped:self newsId:[[[self.obj objectForKey:@"data"] objectAtIndex:[indexPath row]] objectForKey:@"object_id"]];
        }
    } else if ([type isEqualToString:@"lesson"]) {
        if (IS_WIDESCREEN) {
            PFLesson1ViewController *lesson1ViewController = [[PFLesson1ViewController alloc] initWithNibName:@"PFLesson1ViewController_Wide" bundle:nil];
            NSString *urlString = [[NSString alloc] initWithFormat:@"%@lesson/%@",API_URL,[[[self.obj objectForKey:@"data"] objectAtIndex:[indexPath row]] objectForKey:@"object_id"]];
            NSURL *url = [NSURL URLWithString:urlString];
            __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setCompletionBlock:^{
                // Use when fetching text data
                SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
                id resJson = [resultJson objectWithString:[request responseString]];
                NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
                lesson1ViewController.lessonId = [dict objectForKey:@"id"];
                lesson1ViewController.lessonName = [dict objectForKey:@"name"];
                lesson1ViewController.colorString = [dict objectForKey:@"color"];
            }];
            [request setFailedBlock:^{
                //NSError *error = [request error];
            }];
            [request startSynchronous];
            [self.navigationController pushViewController:lesson1ViewController animated:YES];
        } else {
            PFLesson1ViewController *lesson1ViewController = [[PFLesson1ViewController alloc] initWithNibName:@"PFLesson1ViewController" bundle:nil];
            NSString *urlString = [[NSString alloc] initWithFormat:@"%@lesson/%@",API_URL,[[[self.obj objectForKey:@"data"] objectAtIndex:[indexPath row]] objectForKey:@"object_id"]];
            NSURL *url = [NSURL URLWithString:urlString];
            __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setCompletionBlock:^{
                // Use when fetching text data
                SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
                id resJson = [resultJson objectWithString:[request responseString]];
                NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
                lesson1ViewController.lessonId = [dict objectForKey:@"id"];
                lesson1ViewController.lessonName = [dict objectForKey:@"name"];
                lesson1ViewController.colorString = [dict objectForKey:@"color"];
            }];
            [request setFailedBlock:^{
                //NSError *error = [request error];
            }];
            [request startSynchronous];
            [self.navigationController pushViewController:lesson1ViewController animated:YES];
        }
    } else if ([type isEqualToString:@"activity"] ) {
        if (IS_WIDESCREEN) {
            PFActivitiesDetailViewController *activitiesDetailViewController = [[PFActivitiesDetailViewController alloc] initWithNibName:@"PFActivitiesDetailViewController_Wide" bundle:nil];
            
            NSString *urlString = [[NSString alloc] initWithFormat:@"%@activity/%@",API_URL,[[[self.obj objectForKey:@"data"] objectAtIndex:[indexPath row]] objectForKey:@"object_id"]];
            NSURL *url = [NSURL URLWithString:urlString];
            __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setCompletionBlock:^{
                // Use when fetching text data
                SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
                id resJson = [resultJson objectWithString:[request responseString]];
                NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
                activitiesDetailViewController.obj = dict;
            }];
            [request setFailedBlock:^{
                //NSError *error = [request error];
            }];
            [request startSynchronous];
            [self.navigationController pushViewController:activitiesDetailViewController animated:YES];
        } else {
            PFActivitiesDetailViewController *activitiesDetailViewController = [[PFActivitiesDetailViewController alloc] initWithNibName:@"PFActivitiesDetailViewController" bundle:nil];
            NSString *urlString = [[NSString alloc] initWithFormat:@"%@activity/%@",API_URL,[[[self.obj objectForKey:@"data"] objectAtIndex:[indexPath row]] objectForKey:@"object_id"]];
            NSURL *url = [NSURL URLWithString:urlString];
            __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setCompletionBlock:^{
                // Use when fetching text data
                SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
                id resJson = [resultJson objectWithString:[request responseString]];
                NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
                activitiesDetailViewController.obj = dict;
            }];
            [request setFailedBlock:^{
                //NSError *error = [request error];
            }];
            [request startSynchronous];
            [self.navigationController pushViewController:activitiesDetailViewController animated:YES];
        }
    }  else {
        NSString *urlString = [[NSString alloc] initWithFormat:@"%@sys_notification/%@",API_URL,[[[self.obj objectForKey:@"data"] objectAtIndex:[indexPath row]] objectForKey:@"object_id"]];
        NSURL *url = [NSURL URLWithString:urlString];
        __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setCompletionBlock:^{
            // Use when fetching text data
            SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
            id resJson = [resultJson objectWithString:[request responseString]];
            NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
            self.textView.text = [dict objectForKey:@"message"];
            [self.view addSubview:self.blurView];
            UIButton *a2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [a2 setFrame:CGRectMake(0.0f, 0.0f, 60.0f, 30.0f)];
            [a2 addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
            [a2 setTitle:@"Close" forState:UIControlStateNormal];
            UIBarButtonItem *closeBut = [[UIBarButtonItem alloc] initWithCustomView:a2];
            self.navigationItem.rightBarButtonItem = closeBut;
        }];
        [request setFailedBlock:^{
            //NSError *error = [request error];
        }];
        [request startSynchronous];
    }
}
- (void)closeView {
    [self.blurView removeFromSuperview];
    self.navigationItem.rightBarButtonItem = nil;
}
- (void)PFNotificationViewController:(id)sender obj:(NSDictionary *)obj {
    NSLog(@"%@",obj);
    NSString *type = [[obj objectForKey:@"dz"] objectForKey:@"type"];
    if ( [type isEqualToString:@"showcase"]) {
        if (IS_WIDESCREEN) {
            PFYouTubeViewController *youTubeViewController = [[PFYouTubeViewController alloc] initWithNibName:@"PFYouTubeViewController_Wide" bundle:nil];
            youTubeViewController.youtubeId = [[obj objectForKey:@"dz"] objectForKey:@"object_id"];
            NSString *urlString = [[NSString alloc] initWithFormat:@"%@showcase/%@",API_URL,[[obj objectForKey:@"dz"] objectForKey:@"object_id"]];
            NSURL *url = [NSURL URLWithString:urlString];
            __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setCompletionBlock:^{
                // Use when fetching text data
                SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
                id resJson = [resultJson objectWithString:[request responseString]];
                NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
                youTubeViewController.youtubeObj = dict;
            }];
            [request setFailedBlock:^{
                //NSError *error = [request error];
            }];
            [request startSynchronous];
            
            [self.navigationController pushViewController:youTubeViewController animated:YES];
        } else {
            PFYouTubeViewController *youTubeViewController = [[PFYouTubeViewController alloc] initWithNibName:@"PFYouTubeViewController" bundle:nil];
            youTubeViewController.youtubeId = [[obj objectForKey:@"dz"] objectForKey:@"object_id"];
            NSString *urlString = [[NSString alloc] initWithFormat:@"%@showcase/%@",API_URL,[[obj objectForKey:@"dz"] objectForKey:@"object_id"]];
            NSURL *url = [NSURL URLWithString:urlString];
            __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setCompletionBlock:^{
                // Use when fetching text data
                SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
                id resJson = [resultJson objectWithString:[request responseString]];
                NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
                youTubeViewController.youtubeObj = dict;
            }];
            [request setFailedBlock:^{
                //NSError *error = [request error];
            }];
            [request startSynchronous];
            
            [self.navigationController pushViewController:youTubeViewController animated:YES];
        }
    } else if ([type isEqualToString:@"news"]) {
        if([self.delegate respondsToSelector:@selector(PFNotificationViewControllerNewsTapped:newsId:)]){
            [self.delegate PFNotificationViewControllerNewsTapped:self newsId:[[obj objectForKey:@"dz"] objectForKey:@"object_id"]];
        }
    } else if ([type isEqualToString:@"lesson"]) {
        if (IS_WIDESCREEN) {
            PFLesson1ViewController *lesson1ViewController = [[PFLesson1ViewController alloc] initWithNibName:@"PFLesson1ViewController_Wide" bundle:nil];
            NSString *urlString = [[NSString alloc] initWithFormat:@"%@lesson/%@",API_URL,[[obj objectForKey:@"dz"] objectForKey:@"object_id"]];
            NSURL *url = [NSURL URLWithString:urlString];
            __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setCompletionBlock:^{
                // Use when fetching text data
                SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
                id resJson = [resultJson objectWithString:[request responseString]];
                NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
                lesson1ViewController.lessonId = [dict objectForKey:@"id"];
                lesson1ViewController.lessonName = [dict objectForKey:@"name"];
                lesson1ViewController.colorString = [dict objectForKey:@"color"];
            }];
            [request setFailedBlock:^{
                //NSError *error = [request error];
            }];
            [request startSynchronous];
            [self.navigationController pushViewController:lesson1ViewController animated:YES];
        } else {
            PFLesson1ViewController *lesson1ViewController = [[PFLesson1ViewController alloc] initWithNibName:@"PFLesson1ViewController" bundle:nil];
            NSString *urlString = [[NSString alloc] initWithFormat:@"%@lesson/%@",API_URL,[[obj objectForKey:@"dz"] objectForKey:@"object_id"]];
            NSURL *url = [NSURL URLWithString:urlString];
            __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setCompletionBlock:^{
                // Use when fetching text data
                SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
                id resJson = [resultJson objectWithString:[request responseString]];
                NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
                lesson1ViewController.lessonId = [dict objectForKey:@"id"];
                lesson1ViewController.lessonName = [dict objectForKey:@"name"];
                lesson1ViewController.colorString = [dict objectForKey:@"color"];
            }];
            [request setFailedBlock:^{
                //NSError *error = [request error];
            }];
            [request startSynchronous];
            [self.navigationController pushViewController:lesson1ViewController animated:YES];
        }
    } else if ([type isEqualToString:@"activity"] ) {
        if (IS_WIDESCREEN) {
            PFActivitiesDetailViewController *activitiesDetailViewController = [[PFActivitiesDetailViewController alloc] initWithNibName:@"PFActivitiesDetailViewController_Wide" bundle:nil];
            
            NSString *urlString = [[NSString alloc] initWithFormat:@"%@activity/%@",API_URL,[[obj objectForKey:@"dz"] objectForKey:@"object_id"]];
            NSURL *url = [NSURL URLWithString:urlString];
            __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setCompletionBlock:^{
                // Use when fetching text data
                SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
                id resJson = [resultJson objectWithString:[request responseString]];
                NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
                activitiesDetailViewController.obj = dict;
            }];
            [request setFailedBlock:^{
                //NSError *error = [request error];
            }];
            [request startSynchronous];
            [self.navigationController pushViewController:activitiesDetailViewController animated:YES];
        } else {
            PFActivitiesDetailViewController *activitiesDetailViewController = [[PFActivitiesDetailViewController alloc] initWithNibName:@"PFActivitiesDetailViewController" bundle:nil];
            NSString *urlString = [[NSString alloc] initWithFormat:@"%@activity/%@",API_URL,[[obj objectForKey:@"dz"] objectForKey:@"object_id"]];
            NSURL *url = [NSURL URLWithString:urlString];
            __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setCompletionBlock:^{
                // Use when fetching text data
                SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
                id resJson = [resultJson objectWithString:[request responseString]];
                NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
                activitiesDetailViewController.obj = dict;
            }];
            [request setFailedBlock:^{
                //NSError *error = [request error];
            }];
            [request startSynchronous];
            [self.navigationController pushViewController:activitiesDetailViewController animated:YES];
        }
    } else {
        NSString *urlString = [[NSString alloc] initWithFormat:@"%@sys_notification/%@",API_URL,[[obj objectForKey:@"dz"] objectForKey:@"object_id"]];
        NSURL *url = [NSURL URLWithString:urlString];
        __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setCompletionBlock:^{
            // Use when fetching text data
            SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
            id resJson = [resultJson objectWithString:[request responseString]];
            NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
            self.textView.text = [dict objectForKey:@"message"];
            [self.view addSubview:self.blurView];
            UIButton *a2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [a2 setFrame:CGRectMake(0.0f, 0.0f, 60.0f, 30.0f)];
            [a2 addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
            [a2 setTitle:@"Close" forState:UIControlStateNormal];
            UIBarButtonItem *closeBut = [[UIBarButtonItem alloc] initWithCustomView:a2];
            self.navigationItem.rightBarButtonItem = closeBut;
        }];
        [request setFailedBlock:^{
            //NSError *error = [request error];
        }];
        [request startSynchronous];
    }
}

@end
