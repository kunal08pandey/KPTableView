//
//  KPCell.m
//  KPTableView
//
//  Created by Kunal Pandey on 21/03/16.
//  Copyright © 2016 kunal08pandey. All rights reserved.
//

#import "KPCell.h"

#define ROWHEIGHT 44

@interface KPCell ()



@end

@implementation KPCell

-(id)initWithResuableIdentifier:(NSString *)reuasbleIdentifier {
  if(self = [super initWithFrame:CGRectMake(0, 0, 320, ROWHEIGHT)]) {
    self.reuasbleIdentifier = reuasbleIdentifier;
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 200, 14)];
    self.textDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, 200, 16)];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self addSubview:self.textLabel];
    [self addSubview:self.textDetailLabel];
    [self addSubview:self.imageView];
  }
  return self;
}



@end
