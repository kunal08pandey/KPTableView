//
//  KPTable.m
//  KPTableView
//
//  Created by Kunal Pandey on 21/03/16.
//  Copyright © 2016 kunal08pandey. All rights reserved.
//

#import "KPTable.h"
#import "KPCell.h"

#define ROWHEIGHT 100

@interface KPTable ()<UIScrollViewDelegate>

@end

@implementation KPTable
{
  NSInteger numberOfCell;
  NSInteger numberOfVisibleCell;
  NSInteger startRowNumber;
  NSInteger lastRowNumber;
  CGRect visibleRect;
  __weak id<KPDelegate> tableViewDelegate;
}

@synthesize delegate = tableViewDelegate;

-(void)awakeFromNib {
  
//  [self reloadData];
  self.cellSelectionColor = [UIColor blueColor];
  
}

-(void)reloadData {
  [super setDelegate:self];
  numberOfCell = [self.dataSouce tableView:self numberOfRowsInSection:0];
  numberOfVisibleCell =  (400/ROWHEIGHT) + 2;
  self.contentSize = CGSizeMake(320, numberOfCell*ROWHEIGHT);
  CGFloat yPos = 0;
  startRowNumber = 0;
  lastRowNumber = numberOfVisibleCell;
  for (int i = startRowNumber; i < numberOfVisibleCell; i++) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
    [self generateCell:indexPath yPos:yPos];
    yPos += ROWHEIGHT;
      }
}

-(void) generateCell:(NSIndexPath *)indexPath yPos:(CGFloat)yPos{
  KPCell *cell = [self.dataSouce tableView:self cellForRowAtIndexPath:indexPath];
  cell.textDetailLabel.text = [NSString stringWithFormat:@"( %d - %d )",startRowNumber,lastRowNumber];
  cell.backgroundColor = [UIColor whiteColor];
  cell.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnCell:)];
  [cell addGestureRecognizer:cell.tapGestureRecognizer];
  cell.frame = CGRectMake(0, yPos, 320, ROWHEIGHT);
  if(![self.subviews containsObject:cell]) {
  [self addSubview:cell];
  }
  cell.layer.borderColor = [UIColor greenColor].CGColor;
  cell.layer.borderWidth = 1.0;
  [self.reusableCellPool addObject:cell];
  [self.reusableCellPoolDictionary setObject:self.reusableCellPool forKey:cell.reuasbleIdentifier];
}


-(void)tapOnCell:(UITapGestureRecognizer *)sender {
  KPCell *cell = (KPCell *)sender.view; 
  cell.selected = !cell.selected;
  NSIndexPath *indexPath = [self indexPathForCell:cell];
  if(cell.selected) {
    cell.backgroundColor = self.cellSelectionColor;
  if([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
  [self.delegate tableView:self didSelectRowAtIndexPath:indexPath];
  } else {
    cell.backgroundColor = [UIColor whiteColor];
    if([self.delegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)])
      [self.delegate tableView:self didDeselectRowAtIndexPath:indexPath];
  }
}


-(NSIndexPath *)indexPathForCell:(KPCell *)cell {
  NSInteger rowNum = floor(cell.frame.origin.y/ROWHEIGHT);
  
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowNum inSection:0];
  return indexPath;

}

-(KPCell *)tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath {
  return nil;
}


-(NSMutableArray *)reusableCellPool {
  if(!_reusableCellPool) {
    _reusableCellPool = [NSMutableArray new];
  }
  return _reusableCellPool;
}

-(NSMutableDictionary *)reusableCellPoolDictionary {
  if(! _reusableCellPoolDictionary){
    _reusableCellPoolDictionary = [[NSMutableDictionary alloc] init];
  }
  return _reusableCellPoolDictionary;
}

-(KPCell *)dequeueCellWithResaubleIdentifier:(NSString *)cellIdenifier {
  NSMutableArray *cells = [self.reusableCellPoolDictionary objectForKey:cellIdenifier];
  if([cells count] == numberOfVisibleCell) {
  KPCell *cell = [cells firstObject];
  [cells removeObject:cell];
  return cell;
  }
  else {
    return nil;
  }
}


-(void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated {
  NSLog(@"%@",NSStringFromCGRect(rect));
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
  CGFloat cellHeight = ROWHEIGHT;
  visibleRect = CGRectMake(self.contentOffset.x, self.contentOffset.y, self.frame.size.width, self.frame.size.height);
  NSInteger rowNum = floor((self.contentOffset.y - cellHeight)/ cellHeight) + 1;
  [self makeDecision:rowNum];
  NSLog(@"%d",numberOfVisibleCell);
}

-(void)makeDecision:(NSInteger)rowNum {
  static  NSInteger previousRowNum = 0;
  if(previousRowNum != rowNum) {
    if(previousRowNum < rowNum) {
      [self scrollDownward:rowNum];
    } else {
      [self scrollUpward:rowNum];
    }
    previousRowNum = rowNum;
    
  }
}

-(void)scrollUpward:(NSInteger)rowNum {
  NSLog(@"Scroll Upward");
  if(rowNum != startRowNumber  && rowNum > -1){
  startRowNumber = rowNum;
  lastRowNumber = numberOfVisibleCell + rowNum;
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:startRowNumber inSection:0];
  [self generateCell:indexPath yPos:startRowNumber *ROWHEIGHT];
  }
}


-(void)scrollDownward:(NSInteger)rowNum {
   NSLog(@"Scroll Downward");
  if(rowNum != startRowNumber  && (rowNum < (numberOfCell - numberOfVisibleCell))) {
    startRowNumber = ((numberOfVisibleCell + rowNum) < numberOfCell) ? rowNum : (numberOfCell - numberOfVisibleCell);
    lastRowNumber = ((numberOfVisibleCell + rowNum) < numberOfCell) ? (numberOfVisibleCell + rowNum) : numberOfCell;
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
  [self generateCell:indexPath yPos:lastRowNumber *ROWHEIGHT];
  }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
  
    //find the page number you are on
  CGFloat cellHeight = ROWHEIGHT;
 NSInteger rowNum = floor((self.contentOffset.y - cellHeight)/ cellHeight) + 1;
  
    [self makeDecision:rowNum];
//     NSLog(@"Scrolling - You are now on rowNumber %i",rowNum);
  
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *) targetContentOffset {
  
    //find the page number you are on
  CGFloat cellHeight = ROWHEIGHT;
 NSInteger rowNum = floor((self.contentOffset.y - cellHeight)/ cellHeight) + 1;
    [self makeDecision:rowNum];
//     NSLog(@"Dragging - You are now on rowNumber %i",rowNum);
  
}



@end
