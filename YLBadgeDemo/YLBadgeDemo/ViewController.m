//
//  ViewController.m
//  YLBadgeDemo
//
//  Created by Yunpeng Li on 2017/4/5.
//  Copyright © 2017年 Yunpeng. All rights reserved.
//

#import "ViewController.h"
#import "YLBadge.h"

#import "UIView+YLBadge.h"
#import "UIBarItem+YLBadge.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet UIView *testView2;
@property (weak, nonatomic) IBOutlet UIView *textView3;
@property (nonatomic, strong) YLBadge *badgeView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.testView yl_showBadge];
    [self.testView2 yl_showBadgeNumber:23];
    [self.textView3 yl_showBadgeText:@"new"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_message_icon"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self.navigationItem.rightBarButtonItem yl_showBadge];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tabBarController.tabBar.items[0] yl_showBadgeNumber:5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
