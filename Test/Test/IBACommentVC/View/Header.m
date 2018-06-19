
//
//  Header.m
//  MasonryDemo
//
//  Created by FengZi on 09/11/2017.
//  Copyright © 2017 yang. All rights reserved.
//

#import "Header.h"

@implementation Header
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *desLabel = [[UILabel alloc]init];
        desLabel.frame = CGRectMake(20, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        desLabel.textColor = [UIColor colorWithRed:153/255 green:153/255 blue:153/255 alpha:1.0];

        desLabel.font = [UIFont systemFontOfSize:13];
        desLabel.text = @"无图无真相，给小伙伴晒晒吧...";
        [self addSubview:desLabel];
    }
    return self;
}

@end
