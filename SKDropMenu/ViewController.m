//
//  ViewController.m
//  SKDropMenu
//
//  Created by 筇琼 on 2017/12/6.
//  Copyright © 2017年 筇琼. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+DropMenu.h"
@interface ViewController ()
/** <#注释#> */
@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor greenColor];

    UISegmentedControl *segmented = [[UISegmentedControl alloc] initWithItems:@[@"up", @"down", @"left", @"right"]];
    segmented.selectedSegmentIndex = 1;
    segmented.frame = CGRectMake(0, 20, 300, 30);
    [segmented addTarget:self action:@selector(segmentClicked:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmented];
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(50, 50, 60, 40);
    button.tag = 100;
    [button setTitle:@"button" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor cyanColor]];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.center = self.view.center;
    [self.view addSubview:button];
    [button dm_addDropMenu];
    button.dm_dropMenu.sourceView = self.view;
    button.dm_dropMenu.sourceRect = button.frame;
    [button dm_setTextArray:@[@"哈哈", @"呵   呵", @"嘿  嘿", @"嘻嘻"]];
    [button dm_show];
    _button = button;
}

- (void)buttonClicked:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender.dm_dropMenu show];
    } else {
        [sender.dm_dropMenu hide];
    }
    
}

- (void)segmentClicked:(UISegmentedControl *)segment {
    _button.dm_dropMenu.dropMenuDirection = segment.selectedSegmentIndex + 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
