//
//  PFClassViewController.m
//  DanceZone
//
//  Created by aOmMiez on 8/31/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFClassViewController.h"

@interface PFClassViewController ()

@end

@implementation PFClassViewController

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
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:@"Class"];
    [self.navigationItem setTitleView:myLabel];
    self.w.layer.cornerRadius = 5;
    self.w.layer.masksToBounds = YES;
    self.w.alpha = 1;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    PFClassManager *classManager = [[PFClassManager alloc] init];
    classManager.delegate = self;
    [classManager getClass];
    UIView *topView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 74)]autorelease];;
    self.tableView.tableHeaderView = topView;
    UIView *footView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)]autorelease];;
    self.tableView.tableFooterView = footView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)back {
    [self.view removeFromSuperview];
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
    
    PFClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ClassCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bgTypeView.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerTopLeft) cornerRadii:CGSizeMake(5.0, 5.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cell.bgTypeView.frame;
    maskLayer.path = maskPath.CGPath;
    cell.bgTypeView.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 100, 120);
    cell.bgTypeView.layer.mask = maskLayer;
    
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%@",[[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"logo_link"]]]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    [cell.myImageView loadImageFromURL:url];
    /*
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        
        // Use when fetching binary data
        NSData *responseData = [request responseData];
        cell.dancePic.image = [UIImage imageWithData:responseData];
    }];
    [request setFailedBlock:^{
        //NSError *error = [request error];
        
    }];
    [request startAsynchronous];
    */
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
     PFClassTimeViewController *classTimeViewController = [[PFClassTimeViewController alloc] initWithNibName:@"PFClassTimeViewController_Wide" bundle:nil];
         classTimeViewController.classId = [[[self.dict objectForKey:@"data"]objectAtIndex:indexPath.row]objectForKey:@"id"];
         classTimeViewController.titleBar = [[[self.dict objectForKey:@"data"]objectAtIndex:indexPath.row]objectForKey:@"name"];
         [self.navigationController pushViewController:classTimeViewController animated:YES];
     } else {
     PFClassTimeViewController *classTimeViewController = [[PFClassTimeViewController alloc] initWithNibName:@"PFClassTimeViewController" bundle:nil];
         classTimeViewController.classId = [[[self.dict objectForKey:@"data"]objectAtIndex:indexPath.row]objectForKey:@"id"];
         classTimeViewController.titleBar = [[[self.dict objectForKey:@"data"]objectAtIndex:indexPath.row]objectForKey:@"name"];
         [self.navigationController pushViewController:classTimeViewController animated:YES];
     }
}
- (void)dealloc {
    [_navBg release];
    [super dealloc];
}
- (void)PFClassManager:(id)sender getClassResponse:(NSDictionary *)response {
    self.dict = response;
    [self.tableView reloadData];
    self.w.alpha = 0;
}
- (void)PFClassManager:(id)sender getClassErrorResponse:(NSString *)errorResponse {
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
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self.navigationController.visibleViewController isKindOfClass:[PFClassTimeViewController class]]) {
        
    } else {
        if (self.navigationController.visibleViewController != self) {
            if([self.delegate respondsToSelector:@selector(PFClassViewControllerBack)]){
                [self.delegate PFClassViewControllerBack];
            }
        }
    }
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
@end
