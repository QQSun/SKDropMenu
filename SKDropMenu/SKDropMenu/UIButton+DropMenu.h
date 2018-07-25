//
//  UIButton+DropMenu.h
//  SKDropMenu
//
//  Created by 筇琼 on 2017/12/6.
//  Copyright © 2017年 筇琼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKDropMenu.h"

@interface UIButton (DropMenu)

/** <#注释#> */
@property (nonatomic, strong, readonly) SKDropMenu *dm_dropMenu;

- (void)dm_addDropMenu;

- (void)dm_setTextArray:(NSArray *)textArray;

- (void)dm_setDropMenuDirection:(SKDropMenuDirection)direction;

- (void)dm_show;

- (void)dm_hidden;

@end
