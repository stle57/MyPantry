
/*
     File: SubCategoryHeaderView.h
 
 */

#import <Foundation/Foundation.h>

@protocol SubCategoryHeaderViewDelegate;


@interface SubCategoryHeaderView : UIView 

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *disclosureButton;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, weak) id <SubCategoryHeaderViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame title:(NSString*)title section:(NSInteger)sectionNumber delegate:(id <SubCategoryHeaderViewDelegate>)delegate;
-(void)toggleOpenWithUserAction:(BOOL)userAction;

@end



/*
 Protocol to be adopted by the section header's delegate; the section header tells its delegate when the section should be opened and closed.
 */
@protocol SubCategoryHeaderViewDelegate <NSObject>

@optional
-(void)SubCategoryHeaderView:(SubCategoryHeaderView*)SubCategoryHeaderView sectionOpened:(NSInteger)section;
-(void)SubCategoryHeaderView:(SubCategoryHeaderView*)SubCategoryHeaderView sectionClosed:(NSInteger)section;

@end

