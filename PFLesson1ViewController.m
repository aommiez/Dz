//
//  PFLesson1ViewController.m
//  DanceZone
//
//  Created by aOmMiez on 9/2/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFLesson1ViewController.h"

@interface PFLesson1ViewController ()

@end

@implementation PFLesson1ViewController

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
    self.w.alpha =1 ;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIView *topView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)]autorelease];    self.tableView.tableHeaderView = topView;
    PFLessonManager *lessonManager = [[PFLessonManager alloc] init];
    lessonManager.delegate = self;
    [lessonManager getChapterlistByLessonId:self.lessonId];
    [self.contentView.layer setCornerRadius:4.0f];
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:self.lessonName];
    [self.navigationItem setTitleView:myLabel];
    AMBlurView *backgroundView = [[AMBlurView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.navigationController.navigationBar.frame), 64)];
    [backgroundView setBlurTintColor:[self colorFromRGBHexString:self.colorString]];
    [self.navigationController.view insertSubview:backgroundView belowSubview:self.navigationController.navigationBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_contentView release];
    [_scrollView release];

    [_tableView release];
    [super dealloc];
}

- (void)PFLessonManager:(id)sender getChapterlistByLessonIdResponse:(NSDictionary *)response {
    self.dict = response;
    [self.tableView reloadData];
    self.w.alpha = 0;
}
- (void)PFLessonManager:(id)sender getChapterlistByLessonIdErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dict objectForKey:@"length"] integerValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 322;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PFLessonChapterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LessonChapterCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LessonChapterCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSString *urlStr = [[NSString alloc]init];
    if (IS_WIDESCREEN) {
        urlStr = [[NSString alloc] initWithFormat:@"%@pic/%@?display=custom&size_x=490&size_y=290",API_URL,[[[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row]objectForKey:@"picture"] objectForKey:@"id"]];
    } else {
        urlStr = [[NSString alloc] initWithFormat:@"%@pic/%@?display=custom&size_x=245&size_y=145",API_URL,[[[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row]objectForKey:@"picture"] objectForKey:@"id"]];
    }

    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    [cell.myImageView loadImageFromURL:url];
    [cell.detailView.layer setCornerRadius:4.0f];
    cell.textView.text = [[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row]objectForKey:@"description"];
    cell.nameLabel.text = [[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row]objectForKey:@"name"];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.bgBut.backgroundColor = [self colorFromRGBHexString:self.colorString];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_WIDESCREEN) {
        PFLesson2ViewController *lesson2 = [[PFLesson2ViewController alloc] initWithNibName:@"PFLesson2ViewController_Wide" bundle:nil];
        lesson2.capterId = [[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row]objectForKey:@"id"];
        lesson2.lessonId = [[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row]objectForKey:@"lesson_id"];
        [self.navigationController pushViewController:lesson2 animated:YES];
    } else {
        PFLesson2ViewController *lesson2 = [[PFLesson2ViewController alloc] initWithNibName:@"PFLesson2ViewController" bundle:nil];
        lesson2.capterId = [[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row]objectForKey:@"id"];
        lesson2.lessonId = [[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row]objectForKey:@"lesson_id"];
        [self.navigationController pushViewController:lesson2 animated:YES];
    }
}
- (UIColor *)colorFromRGBHexString:(NSString *)colorString
{
    if (colorString.length == 7) {
        const char *colorUTF8String = [colorString UTF8String];
        int r, g, b;
        sscanf(colorUTF8String, "#%2x%2x%2x", &r, &g, &b);
        return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:0.7];
    }
    
    return nil;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.navigationController.visibleViewController isKindOfClass:[PFLesson2ViewController class]]) {
        
    } else {
        if (self.navigationController.visibleViewController != self) {
            AMBlurView *backgroundView = [[AMBlurView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.navigationController.navigationBar.frame), 64)];
            [backgroundView setBlurTintColor:[UIColor colorWithRed:1.000000 green:0.685938 blue:0.007812 alpha:0.792188]];
            [self.navigationController.view insertSubview:backgroundView belowSubview:self.navigationController.navigationBar];
        }
    }
    
}
@end
