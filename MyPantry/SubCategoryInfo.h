
/*
     File: SubCategoryInfo.h

 
 */

#import <Foundation/Foundation.h>

@class SubCategoryHeaderView;
@class SubCategory;


@interface SubCategoryInfo : NSObject 

@property (assign) BOOL open;
@property (strong) SubCategory* subCategory;
@property (strong) SubCategoryHeaderView* headerView;

@property (nonatomic,strong,readonly) NSMutableArray *rowHeights;

- (NSUInteger)countOfRowHeights;
- (id)objectInRowHeightsAtIndex:(NSUInteger)idx;
- (void)insertObject:(id)anObject inRowHeightsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRowHeightsAtIndex:(NSUInteger)idx;
- (void)replaceObjectInRowHeightsAtIndex:(NSUInteger)idx withObject:(id)anObject;
- (void)insertRowHeights:(NSArray *)rowHeightArray atIndexes:(NSIndexSet *)indexes;
- (void)removeRowHeightsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceRowHeightsAtIndexes:(NSIndexSet *)indexes withRowHeights:(NSArray *)rowHeightArray;

@end
