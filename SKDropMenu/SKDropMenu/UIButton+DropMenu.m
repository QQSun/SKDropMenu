//
//  UIButton+DropMenu.m
//  SKDropMenu
//
//  Created by 筇琼 on 2017/12/6.
//  Copyright © 2017年 筇琼. All rights reserved.
//

#import "UIButton+DropMenu.h"
#import "SKDropMenu.h"
#import <objc/runtime.h>
static const void* SKDropMenuKey = &SKDropMenuKey;

@implementation UIButton (DropMenu)

- (void)setDm_dropMenu:(SKDropMenu *)dm_dropMenu {
    [self willChangeValueForKey:@"dm_dropMenu"];
    objc_setAssociatedObject(self, SKDropMenuKey, dm_dropMenu, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"dm_dropMenu"];
}

- (SKDropMenu *)dm_dropMenu {
    return objc_getAssociatedObject(self, SKDropMenuKey);
}

- (void)dm_addDropMenu{

    SKDropMenu *dropMenu = [[SKDropMenu alloc] init];
    self.dm_dropMenu = dropMenu;
    dropMenu.button = self;
    dropMenu.hidden = true;
    dropMenu.sourceView = self.superview;
    dropMenu.sourceRect = self.frame;
}

- (void)dm_setDropMenuDirection:(SKDropMenuDirection)direction {
    self.dm_dropMenu.dropMenuDirection = direction;
}

- (void)dm_setTextArray:(NSArray *)textArray {
    [self.dm_dropMenu.textArray removeAllObjects];
    [self.dm_dropMenu.textArray addObjectsFromArray:textArray];
    [self.dm_dropMenu reloadData];
}

- (void)dm_show {
    [self.dm_dropMenu show];
}

- (void)dm_hidden {
    [self.dm_dropMenu hide];
}

- (void)dealloc {
    [self.dm_dropMenu removeFromSuperview];
    self.dm_dropMenu = nil;
    NSLog(@"dealloc");
}

@end
