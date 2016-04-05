//
//  KPViewController.m
//  KPTableView
//
//  Created by kunal08pandey on 12/29/2015.
//  Copyright (c) 2015 kunal08pandey. All rights reserved.
//

#import "KPViewController.h"
#import "KPTable.h"
#import "KPCell.h"
@interface KPViewController ()<KPDataSource,KPDelegate>
  // Remove it when you are commiting

  //Remove it

@property(nonatomic,weak) IBOutlet KPTable *tableView;
@property(nonatomic,strong) NSArray *imageList;
@end

@implementation KPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _imageList = [[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"Images"];

  
    [self.tableView setDataSouce:self];
    [self.tableView setDelegate:self];
    [self.tableView reloadData];
  
  
  [[self.tableView layer] setBorderColor:[UIColor redColor].CGColor];
    [[self.tableView layer] setBorderWidth:1.0];
//   [self useScrollView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(KPTable *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_imageList count];
}

-(KPCell *)tableView:(KPTable *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier =@"Cell";
  KPCell *cell = [tableView dequeueCellWithResaubleIdentifier:cellIdentifier];
  if(cell == nil) {
    cell = [[KPCell alloc] initWithResuableIdentifier:cellIdentifier];
  }
  cell.textLabel.text = [NSString stringWithFormat:@"Data ( %d )",indexPath.row + 1];
  cell.imageView.image = [UIImage imageNamed:_imageList[indexPath.row]];
  
  return cell;
}

-(void)tableView:(KPTable *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"Cell Clicked at Index : %d",indexPath.row);
}

-(CGFloat)tableView:(KPTable *)tableView rowHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if(indexPath.row % 2 == 0)
    return 33;
  return 133;
}


//-(void)useScrollView {
//  
//    CGFloat y = 0;
//  int NumberOFCellToView = CGRectGetHeight(self.exScrollView.frame)/22.0;
//  int NumberOFCellGenerate = CGRectGetHeight(self.exScrollView.frame)/44.0;
//    for (int i = 0; i < NumberOFCellGenerate; i++) {
//      UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 320, 44.0)];
//      label.text = [NSString stringWithFormat:@"%0.0f",y/44.0];
//      [self.exScrollView addSubview:label];
//      y += 44.0;
//    }
//    _exScrollView.contentSize = CGSizeMake(320, y*2);
//    _exScrollView.delegate = self;
//  _exScrollView.bounces = NO;
//  
//  
//  }
//
//#pragma mark - UIScrollViewDelegate
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//  
//  int NumberOFCellToView = CGRectGetHeight(scrollView.frame)/44.0;
//  int y = scrollView.contentOffset.y/44.0;
// static int previousY = 0 ;
//  if(y > 0 && y < (NumberOFCellToView/2)) {
//  UILabel *label = [self.exScrollView subviews][y-1];
////  [label removeFromSuperview];
//    int j = (y>previousY) ?NumberOFCellToView +y : y;
//  label.frame = CGRectMake(label.frame.origin.x, j*44.0, label.frame.size.width, label.frame.size.height);
//    label.text = [NSString stringWithFormat:@"%d",j];
////  [self.exScrollView insertSubview:label atIndex:y-1];
//  }
//  NSRange range = NSMakeRange(y,NumberOFCellToView);
//  
//  NSLog(@"range = %@",NSStringFromRange(range));
//  previousY = y;
//}

//-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
//  scrollView.scrollEnabled = NO;
//}

@end
