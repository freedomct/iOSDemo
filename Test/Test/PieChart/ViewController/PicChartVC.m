//
//  PicChartVC.m
//  Test
//
//  Created by FengZi on 2018/4/11.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "PicChartVC.h"
#import "PieChartView.h"
@interface PicChartVC ()

@property (nonatomic, assign) CGRect bounds;



@end

@implementation PicChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    PieChartView *pie = [[PieChartView alloc]initWithFrame:CGRectMake(0, 100, 200, 200)];
    [self.view addSubview:pie];
    return;
    self.bounds = CGRectMake(50, 50, 200, 200);
    
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

    
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:100.0f startAngle:5 endAngle:10 clockwise:YES];
//    [path addLineToPoint:CGPointMake(50, 50)];
//    [path closePath];
//
//    // 可自定义饼图填充颜色(根据自己需求添加)
//    NSArray *redArray = @[@"46",@"255",@"62",@"254",@"253",@"153",@"110", @"173",@"223",@"196"];
//    NSArray *greenArray = @[@"191",@"48",@"209",@"199",@"109",@"208",@"123", @"110",@"142",@"193"];
//    NSArray *blueArray = @[@"238",@"145",@"185",@"17",@"31",@"60",@"254", @"157",@"36",@"48"];
//    // 填充色
//    for (int i = 0; i < redArray.count; i ++) {
//        UIColor *customColor = [UIColor colorWithRed:[[redArray objectAtIndex:i] intValue]/255.0  green:[[greenArray objectAtIndex:i] intValue]/255.0 blue:[[blueArray objectAtIndex:i] intValue]/255.0 alpha:1];
        // 渲染
//        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//        shapeLayer.lineWidth = 1;
//        // 填充色
//        shapeLayer.fillColor = customColor.CGColor;
//        shapeLayer.path = bezierPath.CGPath;
//        [self.layer addSublayer:shapeLayer];
//
//    }
    
    // 饼图引出点
//    CGFloat pieX = point.x + (radius)*cos(startAngle+(endAngle-startAngle)/2);
//    CGFloat pieY = point.y + (radius)*sin(startAngle+(endAngle-startAngle)/2);
//    // 指引线引出点
//    CGFloat X = point.x + (radius+20)*cos(startAngle+(endAngle-startAngle)/2);
//    CGFloat Y = point.y + (radius+20)*sin(startAngle+(endAngle-startAngle)/2);
//    CGFloat lineWidth = 80;
//    // 绘制小圆点
//    CAShapeLayer *circleLayer = [CAShapeLayer layer];
//    circleLayer.frame = CGRectMake(0, 0, 1, 1); // 指定frame，只是为了设置宽度和高度
//    circleLayer.position = CGPointMake(X, Y); // 设置居中显示
//    circleLayer.fillColor = [UIColor clearColor].CGColor; // 设置填充颜色
//    circleLayer.lineWidth = 2.0;
//    circleLayer.strokeColor = customColor.CGColor;
//    // 使用UIBezierPath创建路径
//    CGRect frame = CGRectMake(0, 0, 2, 2);
//    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:frame];
//    // 设置CAShapeLayer与UIBezierPath关联
//    circleLayer.path = circlePath.CGPath;
//    // 将CAShaperLayer放到某个层上显示
//    [self.layer addSublayer:circleLayer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
