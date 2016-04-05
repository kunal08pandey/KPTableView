//
//  KPTable.h
//  KPTableView
//
//  Created by Kunal Pandey on 21/03/16.
//  Copyright © 2016 kunal08pandey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KPTable;
@class KPCell;
@protocol KPDataSource <NSObject>

-(NSInteger)tableView:(KPTable *)tableView numberOfRowsInSection:(NSInteger)section;
-(KPCell *)tableView:(KPTable *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

@end

@protocol KPDelegate <UIScrollViewDelegate>

-(void)tableView:(KPTable *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
-(void)tableView:(KPTable *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

-(CGFloat)tableView:(KPTable *)tableView rowHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

@end



@interface KPTable : UIScrollView

@property(strong,nonatomic) NSMutableArray *reusableCellPool;
@property(strong,nonatomic) NSMutableDictionary *reusableCellPoolDictionary;

@property(strong,nonatomic) UIColor *cellSelectionColor;

@property(weak,nonatomic) id<KPDataSource> dataSouce;
@property(weak,nonatomic) id<KPDelegate> delegate;

-(NSIndexPath *)indexPathForCell:(KPCell *)cell;
-(KPCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(KPCell *)dequeueCellWithResaubleIdentifier:(NSString *)cellIdenifier;
-(void)reloadData;

@end
