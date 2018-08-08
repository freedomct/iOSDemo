//
//  Footer.h
//  MasonryDemo
//
//  Created by FengZi on 09/11/2017.
//  Copyright © 2017 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SubmitBlock)(void);
@interface Footer : UICollectionReusableView


@property (nonatomic, copy) SubmitBlock submitBlock;

@end
