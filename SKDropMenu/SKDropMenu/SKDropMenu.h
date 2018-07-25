//
//  SKDropMenu.h
//  SKDropMenu
//
//  Created by 筇琼 on 2017/12/6.
//  Copyright © 2017年 筇琼. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SKDropMenuDirection) {
    SKDropMenuDirectionDefault,
    SKDropMenuDirectionUp,
    SKDropMenuDirectionDown,
    SKDropMenuDirectionLeft,
    SKDropMenuDirectionRight
};

NS_ASSUME_NONNULL_BEGIN
@class SKDropMenu;
@protocol SKDropMenuDelegate

@optional
- (void)dropMenu:(SKDropMenu *)dropMenu didClickedIndexPath:(NSIndexPath *)indexPath;

@end

@interface SKDropMenu : UITableView

/** <#注释#> */
@property (nonatomic, strong) NSMutableArray *textArray;
/** <#注释#> */
@property (nonatomic, weak) UIButton *button;
/** <#注释#> */
@property (nonatomic, assign) CGFloat dropMenuWidth;
/** <#注释#> */
@property (nonatomic, assign) CGFloat dropMenuHeight;
/** <#注释#> */
@property (nonatomic, assign) SKDropMenuDirection dropMenuDirection;
/** <#注释#> */
@property (nonatomic, strong) UIView *sourceView;
/** <#注释#> */
@property (nonatomic, assign) CGRect sourceRect;
/** <#注释#> */
@property (nonatomic, weak) id <SKDropMenuDelegate> dropMenuDelegate;

- (void)show;
- (void)hide;
- (void)showWithAnimated:(BOOL)animated;
- (void)hideWithAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
