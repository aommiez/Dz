//
//  PFLessonViewController.m
//  DanceZone
//
//  Created by aOmMiez on 8/26/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFLessonViewController.h"

@interface PFLessonViewController ()

@end

@implementation PFLessonViewController

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
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.dict = [[NSDictionary alloc] init];
    // Do any additional setup after loading the view from its nib.
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:@"Lesson"];
    [self.NavItem setTitleView:myLabel];
    
    
    NSShadow *titleShadow = [[NSShadow alloc] init];
    titleShadow.shadowOffset = CGSizeMake(0.0f, -1.0f);
    titleShadow.shadowColor = [UIColor blackColor];
    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                NSShadowAttributeName: titleShadow};
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    [self.view addSubview:self.navController.view];
    PFLessonManager *lessonManager = [[PFLessonManager alloc] init];
    lessonManager.delegate = self;
    [lessonManager getLesson];
    UIView *topView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)]autorelease];;
    self.tableView.tableHeaderView = topView;
    if (IS_WIDESCREEN) {
        AMBlurView *backgroundView = [[AMBlurView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.navController.navigationBar.frame), 64)];
        [backgroundView setBlurTintColor:[UIColor colorWithRed:1.000000 green:0.685938 blue:0.007812 alpha:0.792188]];
        [self.navController.view insertSubview:backgroundView belowSubview:self.navController.navigationBar];
    } else {
        self.topNav.frame = CGRectMake(0, 0, 320, 20);
        [self.navController.view addSubview:self.topNav];
    }
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dict objectForKey:@"length"] integerValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PFLessonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LessonCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LessonCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bgTypeView.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerTopLeft) cornerRadii:CGSizeMake(5.0, 5.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cell.bgTypeView.frame;
    maskLayer.path = maskPath.CGPath;
    cell.bgTypeView.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 100, 100);
    cell.bgTypeView.layer.mask = maskLayer;
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%@",[[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"logo_link"]]]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    [cell.myImageView loadImageFromURL:url];

    NSString *colorStr = [[NSString alloc] initWithFormat:@"%@",[[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"color"]];
 
    cell.bgTypeView.backgroundColor = [self colorFromRGBHexString:colorStr];
    cell.lessonName.text = [[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_WIDESCREEN) {
        PFLesson1ViewController *lesson1ViewController = [[PFLesson1ViewController alloc] initWithNibName:@"PFLesson1ViewController_Wide" bundle:nil];
        lesson1ViewController.lessonId = [[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"id"];
        lesson1ViewController.lessonName = [[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"name"];
        lesson1ViewController.colorString = [[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"color"];
        [self.navController pushViewController:lesson1ViewController animated:YES];
    } else {
        PFLesson1ViewController *lesson1ViewController = [[PFLesson1ViewController alloc] initWithNibName:@"PFLesson1ViewController" bundle:nil];
        lesson1ViewController.lessonId = [[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"id"];
        lesson1ViewController.lessonName = [[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"name"];
        lesson1ViewController.colorString = [[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"color"];
        [self.navController pushViewController:lesson1ViewController animated:YES];
    }
}
- (void)PFLessonManager:(id)sender getLessonResponse:(NSDictionary *)response {
    self.dict = response;
    [self.tableView reloadData];
    self.w.alpha = 0;
}
- (void)PFLessonManager:(id)sender getLessonErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}
- (UIColor *)colorFromRGBHexString:(NSString *)colorString
{
    if (colorString.length == 7) {
        const char *colorUTF8String = [colorString UTF8String];
        int r, g, b;
        sscanf(colorUTF8String, "#%2x%2x%2x", &r, &g, &b);
        return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1.0];
    }
    
    return nil;
}

#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if ( scrollView.contentOffset.y < -64.0f ) {
        [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        self.loadLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [dateFormatter stringFromDate:[NSDate date]]];
        self.act.alpha =1;
    } 
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < -128.0f ) {
        PFLessonManager *lessonManager = [[PFLessonManager alloc] init];
        lessonManager.delegate = self;
        [lessonManager getLesson];
    } 
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ( scrollView.contentOffset.y < -128.0f ) {
        [UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		self.tableView.frame = CGRectMake(0, 50, 320, self.tableView.frame.size.height);
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
    self.tableView.frame = CGRectMake(0, 0, 320, self.tableView.frame.size.height);
    [UIView commitAnimations];
    self.loadLabel.text = @"";
    self.act.alpha = 0;
}

@end
