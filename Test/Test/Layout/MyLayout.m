//
//  MyLayout.m
//  Test
//
//  Created by FengZi on 2018/4/6.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "MyLayout.h"

@implementation MyLayout

- (void)prepareLayout {
    [super prepareLayout];
    //  做一些准备工作
    _items = [self.collectionView numberOfItemsInSection:0];
    NSLog(@"prepareLayout");
    
    
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
- (CGSize)collectionViewContentSize {
    
//    return self.collectionView.frame.size;
    return CGSizeMake((self.collectionView.contentSize.width), 10000);
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //  获取rect中的布局信息 然后重新设置布局
    NSMutableArray *attributes = [NSMutableArray array];
    
    NSInteger section = [self.collectionView numberOfSections];
    for (int j = 0; j < section; j ++) {
        for (int i = 0; i < [self.collectionView numberOfItemsInSection:j]; i ++) {
            NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:j];
            UICollectionViewLayoutAttributes *att = [self layoutAttributesForItemAtIndexPath:index];
            [attributes addObject:att];
        }

    }
//    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
//    [attributes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        UICollectionViewLayoutAttributes *attribute = (UICollectionViewLayoutAttributes *)obj;
//
//    }];
    NSIndexPath *headIndex = [NSIndexPath indexPathForItem:0 inSection:1];
    UICollectionViewLayoutAttributes *headerAttribute = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:headIndex];
    [attributes addObject:headerAttribute];
    
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //  获取当前index 中的item 布局信息
    UICollectionViewLayoutAttributes *la = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;

    CGFloat width = CGRectGetWidth(self.collectionView.frame);
    if (section == 0) {
        switch (row) {
            case 0:
            {
                la.frame = CGRectMake(20, 20, (width - 50) / 2, (width - 50) / 2);
            }
                break;
            case 1:
            {
                la.frame = CGRectMake((width - 50) / 2 + 30, 20, (width - 50) / 2, ((width - 50) / 3));
            }
                break;
            case 2:
            {
                la.frame = CGRectMake((width - 50) / 2 + 30, 20 + ((width - 50) / 3) + 5, (width - 50) / 2, ((width - 50) / 3));
            }
                break;
            case 3:
            {
                la.frame = CGRectMake(20, (width - 50) / 2 + 30, (width - 50) / 2, (width - 50) / 2);
            }
                break;
            case 4:
            {
                la.frame = CGRectMake((width - 50) / 2 + 30, 20 + ((width - 50) / 3 * 2)  + 5 + 5, (width - 50) / 2, ((width - 50) / 3));
            }
                break;
            default:
            {
                la.size = CGSizeMake(40 , 40);
                la.center = CGPointMake(10 * row, 100 * row);
            }
                break;
        }

    }else if (section == 1){
        la.size = CGSizeMake((width - 40 - 20) / 3 , 50);
        CGFloat itemWidth = (CGRectGetWidth(self.collectionView.frame) - 40  - 20) / 3;
        la.center = CGPointMake(20 + (itemWidth /2) + ((row % 3) * (10 + itemWidth)),600 +  20 + 25/* w/2 */ + (row / 3) * 60);

    }
    return la;

}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
        attribute.size = CGSizeMake(CGRectGetWidth(self.collectionView.frame), 50);
        attribute.center = CGPointMake(CGRectGetWidth(self.collectionView.frame) / 2, 500);
        

        return attribute;
    }
    return nil;
}


// ========================================================
//  返回collectionview 的内容尺寸
//- (void)prepareLayout {
//    
//}
//
////  collection 所占据的尺寸
//- (CGSize)collectionViewContentSize {
//    return CGSizeMake(100, 100);
//}
////  返回rect 中所有元素的布局属性
//- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//    
//    //  获取当前屏幕内(rect内)所有的布局属性
//    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
//    
//    return arr;
//}
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    //  生成空白的attribute 其中只记录了  cell 和index
//    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    attri.center = CGPointMake(100, 100);
//    return attri;
//}

@end
