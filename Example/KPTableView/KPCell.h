//
//  KPCell.h
//  KPTableView
//
//  Created by Kunal Pandey on 21/03/16.
//  Copyright © 2016 kunal08pandey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPCell : UIView
@property(nonatomic,strong) NSString *reuasbleIdentifier;
-(id)initWithResuableIdentifier:(NSString *)reuasbleIdentifier;
@property(nonatomic,strong) UILabel *textLabel;
@property(nonatomic,strong) UILabel *textDetailLabel;
@property(nonatomic,strong) UITapGestureRecognizer *tapGestureRecognizer;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic) BOOL selected;
@end
