//
//  PieChartView.m
//  Test
//
//  Created by FengZi on 2018/4/11.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "PieChartView.h"

@implementation PieChartView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    //数据数组
    NSArray *array = @[@25,@30,@45];
    //颜色数组
    NSArray *colorArray = @[[UIColor redColor], [UIColor greenColor], [UIColor yellowColor]];
    
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    
    //中心点
    CGPoint center = CGPointMake(w * 0.5, h * 0.5);
    //半径
    CGFloat radius = w * 0.5 - 5;
    
    //起点角度
    CGFloat startA = 0;
    //终点角度
    CGFloat endA = 0;
    //扫过角度范围
    CGFloat angle = 0;
    
    for (int i = 0; i < array.count; i ++) {
        
        startA = endA;
        angle = [array[i] integerValue] / 100.0 * M_PI * 2;
        endA = startA + angle;
        
        //弧形路径
        //clockwise: 是否是按照时钟的方向旋转(是否顺时针)
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        //连接中心, 构成扇形
        [path addLineToPoint:center];
        
        //填充颜色
        [(UIColor *)colorArray[i] set];
        
        CGContextAddPath(ctx, path.CGPath);
        
        // 将上下文渲染到视图
        CGContextFillPath(ctx);
    }

}


@end
