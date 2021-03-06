//
//  IFlightAlignmentLeftFlowLayout.m
//  TCTFlight
//
//  Created by le tong on 2018/6/29.
//  Copyright © 2018年 www.ly.com. All rights reserved.
//

#import "leftFlowLayout.h"

@implementation leftFlowLayout
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    
    if (arr.count <= 0) {
        return nil;
    }
    //第一行只有一行的时候让其也居左显示
    UICollectionViewLayoutAttributes *firstLayoutAttributes = [arr firstObject];
    CGRect frame = firstLayoutAttributes.frame;
    frame.origin.x = self.sectionInset.left;
    firstLayoutAttributes.frame = frame;
    
    for (int i = 1; i < [arr count]; i++) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = arr[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = arr[i - 1];
        
        if (prevLayoutAttributes.frame.origin.y == currentLayoutAttributes.frame.origin.y) {
            NSInteger interitemSpacing = self.minimumInteritemSpacing;
            NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
            
            if(origin + interitemSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
                CGRect frame = currentLayoutAttributes.frame;
                frame.origin.x = origin + interitemSpacing;
                currentLayoutAttributes.frame = frame;
            }
        }
        else {
            //一行只有一行的时候让其也居左显示
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = self.sectionInset.left;
            currentLayoutAttributes.frame = frame;
        }
    }
    return arr;
}
@end
