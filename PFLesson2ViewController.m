//
//  PFLesson2ViewController.m
//  DanceZone
//
//  Created by aOmMiez on 9/2/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFLesson2ViewController.h"

@interface PFLesson2ViewController ()

@end

@implementation PFLesson2ViewController

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
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:@"Video"];
    [self.navigationItem setTitleView:myLabel];
    UIView *topView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)]autorelease];;
    self.tableView.tableHeaderView = topView;
    self.tableData = [NSArray arrayWithObjects:@"HIPHOP", @"JAZZ", @"COVER", @"BBOY", @"bla bla bla", nil];
    PFLessonManager *lessonManager = [[PFLessonManager alloc] init];
    lessonManager.delegate = self;
    [lessonManager getVideolistByChapterId:self.capterId lessonId:self.lessonId];
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
    return [[self.videoObj objectForKey:@"length"] integerValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 132;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PFLesson2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Lesson2Cell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Lesson2Cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.tag = [[[[self.videoObj objectForKey:@"data"] objectAtIndex:indexPath.row]objectForKey:@"id"] integerValue];
    cell.videoDes.text = [[[self.videoObj objectForKey:@"data"] objectAtIndex:indexPath.row]objectForKey:@"description"];
    cell.nameLabel.text = [[[self.videoObj objectForKey:@"data"] objectAtIndex:indexPath.row]objectForKey:@"name"];
    
    NSString *urlStr = [[[self.videoObj objectForKey:@"data"] objectAtIndex:indexPath.row]objectForKey:@"thumb"];
    NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle]  resourcePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Documents"]];
    NSString *nameId = [[NSString alloc] initWithFormat:@"%@",[[[self.videoObj objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"video_link"]];
    NSString *filePath = [resourceDocPath stringByAppendingPathComponent:nameId];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    cell.downloadBut.tag = [[[[[self.videoObj objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"video_link"] stringByReplacingOccurrencesOfString:@".mp4" withString:@""] intValue];
    
    if (fileExists) {
        cell.downloadBut.alpha = 0;
        cell.delFile.alpha = 1;
    } else {
        cell.delFile.alpha = 0;
        cell.downloadBut.alpha = 1;
    }
    if ([[[[self.videoObj objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"can_see"] intValue] == 0){
        cell.lockImg.alpha = 1;
        cell.downloadBut.alpha = 0;
    } else {
        cell.imgView.alpha = 0;
    }
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    [cell.myImageView loadImageFromURL:url];
    cell.myImageView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    cell.myImageView.layer.shadowOffset = CGSizeMake(2, 2);
    cell.myImageView.layer.shadowOpacity = 1;
    cell.myImageView.layer.shadowRadius = 1;
    cell.myImageView.clipsToBounds = NO;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[[self.videoObj objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"can_see"] intValue] == 0){
        
        if (IS_WIDESCREEN) {
            PFLessonRegisterViewController *lessonRegister = [[PFLessonRegisterViewController alloc] initWithNibName:@"PFLessonRegisterViewController_Wide" bundle:nil];
            [self.navigationController pushViewController:lessonRegister animated:YES];
        } else {
            PFLessonRegisterViewController *lessonRegister = [[PFLessonRegisterViewController alloc] initWithNibName:@"PFLessonRegisterViewController" bundle:nil];
            [self.navigationController pushViewController:lessonRegister animated:YES];
        }
    } else {
        if (IS_WIDESCREEN) {
            PFLesson3ViewController *lesson3 = [[PFLesson3ViewController alloc] initWithNibName:@"PFLesson3ViewController_Wide" bundle:nil];
            lesson3.videoObj = [[self.videoObj objectForKey:@"data"] objectAtIndex:indexPath.row];
            lesson3.delegate = self;
            [self.navigationController pushViewController:lesson3 animated:YES];
        } else {
            PFLesson3ViewController *lesson3 = [[PFLesson3ViewController alloc] initWithNibName:@"PFLesson3ViewController" bundle:nil];
            lesson3.videoObj = [[self.videoObj objectForKey:@"data"] objectAtIndex:indexPath.row];
            lesson3.delegate = self;
            [self.navigationController pushViewController:lesson3 animated:YES];
        }
    }
}
- (void)PFLessonManager:(id)sender getVideolistByChapterIdResponse:(NSDictionary *)response {
    self.videoObj = response;
    [self.tableView reloadData];
    self.w.alpha = 0;
}
- (void)PFLessonManager:(id)sender getVideolistByChapterIdErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}
- (void)PFLesson3ViewControllerDelegateResetVideo {
    PFLesson3ViewController *lesson3 = [[PFLesson3ViewController alloc] init];
    [lesson3 resetVideo];
}
@end
