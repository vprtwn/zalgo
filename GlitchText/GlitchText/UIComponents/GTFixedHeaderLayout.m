#import "GTFixedHeaderLayout.h"

@implementation GTFixedHeaderLayout

//Override shouldInvalidateLayoutForBoundsChange to require a layout update when we scroll 
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allItems = [[super layoutAttributesForElementsInRect:rect] mutableCopy];

    __block BOOL headerFound = NO;
    [allItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([[obj representedElementKind] isEqualToString:UICollectionElementKindSectionHeader]) {
            headerFound = YES;
            [self updateHeaderAttributes:obj];
        }
    }];


    // Flow layout will remove items from the list if they are supposed to be off screen, so we add them
    // back in in those cases.
    if (!headerFound) {
        [allItems addObject:[self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:[allItems count] inSection:0]]];
    }

    return allItems;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind withIndexPath:indexPath];
    attributes.size = CGSizeMake(self.collectionView.bounds.size.width, 44);
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        [self updateHeaderAttributes:attributes];
    }
    return attributes;
}


- (void)updateHeaderAttributes:(UICollectionViewLayoutAttributes *)attributes
{
    CGRect currentBounds = self.collectionView.bounds;
    attributes.zIndex = 1;
    attributes.hidden = NO;
    CGFloat yCenterOffset = currentBounds.origin.y + attributes.size.height/2.f;
    attributes.center = CGPointMake(CGRectGetMidX(currentBounds), yCenterOffset);
}


@end
