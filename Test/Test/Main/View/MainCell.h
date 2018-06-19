//
//  MainCell.h
//  Test
//
//  Created by FengZi on 2018/4/10.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *desLabel;


- (void)updateCellWithDesTitle:(NSString *)des;

@end
