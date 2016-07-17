//
//  MTMerchantViewController.m
//  美团
//
//  Created by lxy on 16/6/17.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "MTMerchantViewController.h"
#import <Masonry.h>
#import "MTCategoryViewController.h"
#import "MTDistrictViewController.h"
#import "MTMetaTool.h"
#import "MTCity.h"

@interface MTMerchantViewController ()

/** 菜单 */
@property (nonatomic, weak) UIView *menuView;

/** 类别 */
@property (nonatomic, weak) UIButton *categoryBtn;

/** 地址 */
@property (nonatomic, weak) UIButton *adressBtn;

/** 排序方式 */
@property (nonatomic, weak) UIButton *sortWayBtn;

/** 分类控制器 */
@property (nonatomic, strong) MTCategoryViewController *categoryVc;

/** 区域控制器 */
@property (nonatomic, strong) MTDistrictViewController *districtVc;

/** 当前选中的城市 */
@property (nonatomic, copy) NSString *selectCityName;

@end

@implementation MTMerchantViewController

static NSString * const reuseIdentifier = @"cell";

- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [UIPopoverController]
    
    // 初始化导航栏
    [self setupNav];
    
    // 设置菜单栏
    [self setupMenu];
    
    // UICollectionViewController跟其他控制器不一样，不是用view，而是collectionView
    self.collectionView.backgroundColor = MTGlobalBg;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityDidChange:) name:MTCityDidChangeNotification object:nil];
}

#pragma mark - 监听通知
- (void)cityDidChange:(NSNotification *)notification {
    self.selectCityName = notification.userInfo[MTSelectCityName];
    
    // 更换顶部区域名字
    [self.adressBtn setTitle:[NSString stringWithFormat:@"全城"] forState:UIControlStateNormal];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 设置菜单栏
- (void)setupMenu {
    
    // 初始化三个按钮
    UIView *menuView = [[UIView alloc] init];
    menuView.backgroundColor = [UIColor whiteColor];
    [self.collectionView addSubview:menuView];
    self.menuView = menuView;
    // 添加约束
    [menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.height.mas_equalTo(30);
    }];

    UIButton *categoryBtn = [[UIButton alloc] init];
    UIButton *adressBtn = [[UIButton alloc] init];
    UIButton *sortWayBtn = [[UIButton alloc] init];
    self.categoryBtn = categoryBtn;
    self.adressBtn = adressBtn;
    self.sortWayBtn = sortWayBtn;
    
    categoryBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    adressBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    sortWayBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    // 设置按钮内容
    [self setBtn:categoryBtn title:@"全部"];
    
    [self setBtn:adressBtn title:@"中关村"];
    
    [self setBtn:sortWayBtn title:@"好评优先"];
    
    [categoryBtn addTarget:self action:@selector(categoryClick) forControlEvents:UIControlEventTouchUpInside];
    
    [adressBtn addTarget:self action:@selector(adressClick) forControlEvents:UIControlEventTouchUpInside];
    
    [sortWayBtn addTarget:self action:@selector(sortWayClick) forControlEvents:UIControlEventTouchUpInside];
    
    [categoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(menuView.mas_left);
        make.right.equalTo(adressBtn.mas_left);
        make.bottom.equalTo(menuView.mas_bottom);
        make.top.equalTo(menuView.mas_top);
        make.width.equalTo(adressBtn.mas_width);
    }];
    
    [adressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(categoryBtn.mas_top);
        make.bottom.equalTo(categoryBtn.mas_bottom);
        make.right.equalTo(sortWayBtn.mas_left);
        make.width.equalTo(sortWayBtn.mas_width);
    }];
    
    [sortWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(adressBtn.mas_top);
        make.bottom.equalTo(adressBtn.mas_bottom);
        make.left.equalTo(adressBtn.mas_right);
        make.right.equalTo(menuView.mas_right);
        make.width.equalTo(categoryBtn.mas_width);
        
    }];
    
   
    

    
}

#pragma mark - 按钮点击事件
- (void)categoryClick {
    
    self.categoryBtn.selected = !self.categoryBtn.selected;
    
    if(self.categoryBtn.selected == 0) {
        // 隐藏
        [self.categoryVc.view removeFromSuperview];
    } else {
        // 总算解决之前不能放外面的原因了，category要用strong
        MTCategoryViewController *categoryVc = [[MTCategoryViewController alloc] init];
        categoryVc.menuView = self.menuView;
        self.categoryVc = categoryVc;
        // 显示
        [self.collectionView addSubview:self.categoryVc.view];
    }
   
    
}

- (void)adressClick {
    
    self.adressBtn.selected = !self.adressBtn.selected;

    if(self.adressBtn.selected == 0) {
        // 隐藏
        [self.districtVc.view removeFromSuperview];
    } else {
        MTDistrictViewController *districtVc = [[MTDistrictViewController alloc] init];
        districtVc.menuView = self.menuView;
        self.districtVc = districtVc;
        if (self.selectCityName) {
            // 获取当前选中的区域
            MTCity  *city = [[[MTMetaTool cities] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name = %@", self.selectCityName]] firstObject];
            self.districtVc.regions = city.regions;
        }
        // 显示
        [self.collectionView addSubview:self.districtVc.view];
    }
}

- (void)sortWayClick {

}

#pragma mark - 设置按钮内容(抽取的方法)
- (void)setBtn:(UIButton *)button title:(NSString *)title {
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:MTColor(86, 183, 187) forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:@"btn_homepage_hotdealMore_normal"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"btn_homepage_hotdealMore_selected"] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"gc_navi_arrow_down"] forState:UIControlStateNormal];
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -60, 0, 0);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -170);
    [self.menuView addSubview:button];
}

#pragma mark - 初始化导航栏
- (void)setupNav {
    
    // 设置状态栏的背景色， 用图片不能这样做
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, MTScreenW, 20)];
    statusBarView.backgroundColor = MTColor(179, 183, 187);
    [self.navigationController.navigationBar addSubview:statusBarView];
    
    // 设置导航栏的背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_navigationbar_center"] forBarMetrics:UIBarMetricsDefault];

    
    // 设置右边按钮
    self.navigationItem.rightBarButtonItems = @[
                                                
                                                [UIBarButtonItem itemWithImage:@"icon_navigationItem_search" highImage:@"icon_navigationItem_search_highlighted" target:self action:@selector(searchAction)],
                                                // 纯粹是为了扩充距离
                                                [UIBarButtonItem itemWithImage:nil highImage:nil target:nil action:nil],
                                                [UIBarButtonItem itemWithImage:nil highImage:nil target:nil action:nil],
                                                [UIBarButtonItem itemWithImage:@"icon_navigationItem_map" highImage:@"icon_navigationItem_map_highlighted" target:self action:@selector(mapAction)]
                                                
                                                ];

 
    
}

- (void)searchAction {
    MTLogFunc;
}

- (void)mapAction {
    MTLogFunc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
