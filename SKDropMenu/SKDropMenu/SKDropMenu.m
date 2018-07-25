//
//  SKDropMenu.m
//  SKDropMenu
//
//  Created by 筇琼 on 2017/12/6.
//  Copyright © 2017年 筇琼. All rights reserved.
//

#import "SKDropMenu.h"
//#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface SKDropMenu () <UITableViewDelegate, UITableViewDataSource>

/** 显示时的frame */
@property (nonatomic, assign) CGRect showFrame;
/** 隐藏时的frame */
@property (nonatomic, assign) CGRect hideFrame;



@end

@implementation SKDropMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    if (CGRectEqualToRect(CGRectZero, frame)) {
        frame = CGRectMake(0, 0, 70, 100);
    }
    self = [super initWithFrame:frame];
    if (self) {
        self.dropMenuWidth = frame.size.width == 0 ?: 70;
        self.dropMenuHeight = frame.size.height == 0 ?: 100;
        self.dropMenuDirection = SKDropMenuDirectionUp;
        self.delegate = self;
        self.dataSource = self;
        self.separatorInset = UIEdgeInsetsZero;
    }
    return self;
}

- (NSMutableArray *)textArray {
    if (_textArray == nil) {
        _textArray = [[NSMutableArray alloc] init];
    }
    return _textArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _textArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = _textArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_button setTitle:_textArray[indexPath.row] forState:UIControlStateNormal];
    [self hideWithAnimated:false];
    if (self.dropMenuDelegate && [(NSObject *)self.dropMenuDelegate respondsToSelector:@selector(dropMenu:didClickedIndexPath:)]) {
        [self.dropMenuDelegate dropMenu:self didClickedIndexPath:indexPath];
    }
}

- (void)setSourceView:(UIView *)sourceView {
    _sourceView = sourceView;
    [sourceView addSubview:self];
}

- (void)setSourceRect:(CGRect)sourceRect {
    _sourceRect = sourceRect;
    [self calculatorShowFrame];
    [self calculatorHideFrame];
    
}

- (void)setDropMenuDirection:(SKDropMenuDirection)dropMenuDirection {
    _dropMenuDirection = dropMenuDirection;
    [self calculatorShowFrame];
    [self calculatorHideFrame];
}

- (void)calculatorShowFrame {
    switch (_dropMenuDirection) {
        case SKDropMenuDirectionUp: {
            self.showFrame = CGRectMake(CGRectGetMinX(_sourceRect), CGRectGetMinY(_sourceRect) - _dropMenuHeight, _dropMenuWidth, _dropMenuHeight);
        } break;
        case SKDropMenuDirectionDown: {
            self.showFrame = CGRectMake(CGRectGetMinX(_sourceRect), CGRectGetMaxY(_sourceRect), _dropMenuWidth, _dropMenuHeight);
        } break;
        case SKDropMenuDirectionLeft: {
            self.showFrame = CGRectMake(CGRectGetMinX(_sourceRect) - _dropMenuWidth, CGRectGetMidY(_sourceRect) - _dropMenuHeight / 2.0, _dropMenuWidth, _dropMenuHeight);
        } break;
        case SKDropMenuDirectionRight: {
            self.showFrame = CGRectMake(CGRectGetMaxX(_sourceRect), CGRectGetMidY(_sourceRect) - _dropMenuHeight / 2.0, _dropMenuWidth, _dropMenuHeight);
        } break;
        case SKDropMenuDirectionDefault: {
            self.showFrame = CGRectMake(CGRectGetMinX(_sourceRect), CGRectGetMaxY(_sourceRect), _dropMenuWidth, _dropMenuHeight);
        } break;
    }
}

- (void)calculatorHideFrame {
    switch (_dropMenuDirection) {
        case SKDropMenuDirectionUp: {
            self.hideFrame = CGRectMake(CGRectGetMinX(_sourceRect), CGRectGetMinY(_sourceRect), _dropMenuWidth, 0);
        } break;
        case SKDropMenuDirectionDown: {
            self.hideFrame = CGRectMake(CGRectGetMinX(_sourceRect), CGRectGetMaxY(_sourceRect), _dropMenuWidth, 0);
        } break;
        case SKDropMenuDirectionLeft: {
            self.hideFrame = CGRectMake(CGRectGetMinX(_sourceRect), CGRectGetMidY(_sourceRect), 0, 0);
        } break;
        case SKDropMenuDirectionRight: {
            self.hideFrame = CGRectMake(CGRectGetMaxX(_sourceRect), CGRectGetMidY(_sourceRect), 0, 0);
        } break;
        case SKDropMenuDirectionDefault: {
            self.hideFrame = CGRectMake(self.showFrame.origin.x, self.showFrame.origin.y, self.showFrame.size.width, 0);
        } break;
    }
    self.frame = self.hideFrame;
}

- (void)show {
    [self showWithAnimated:true];
}
- (void)hide {
    [self hideWithAnimated:true];
}
- (void)showWithAnimated:(BOOL)animated {
    [self.superview bringSubviewToFront:self];
    self.hidden = false;
    if (animated) {
        [UIView animateWithDuration:0.15 animations:^{
            self.frame = self.showFrame;
        }];
    } else {
        self.frame = self.showFrame;
    }
}

- (void)hideWithAnimated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.15 animations:^{
            self.frame = self.hideFrame;
        } completion:^(BOOL finished) {
            [self.superview sendSubviewToBack:self];
            self.hidden = true;
        }];
    } else {
        self.frame = CGRectMake(self.showFrame.origin.x, self.showFrame.origin.y, self.showFrame.size.width, 0);
        [self.superview sendSubviewToBack:self];
        self.hidden = true;
    }
    
}

- (void)dealloc {
    NSLog(@"dropMenu");
}

@end

