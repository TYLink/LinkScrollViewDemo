//
//  ViewController.m
//  LinkScrollViewDemo
//
//  Created by Dnion on 2018/6/26.
//  Copyright © 2018年 Link_TianYang. All rights reserved.
//

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define TYColorFromHex(rgb)     [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0]
#define TYColorAlphaFromHex(rgb,a)     [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:a]


#import "ViewController.h"
#import "UITableView+Extension.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate>
@property (nonatomic, strong) UIView *navBarView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isBlack;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) UIButton *resetLocationBtn;

@property (nonatomic, strong) UIButton *placedBottomBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = TYColorFromHex(0XF5F5F5);
    
    [self.view addSubview:self.mapView];
    
    [self.view addSubview:self.resetLocationBtn];
    
    UIView *navBar = [UIView new];
    navBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    [self.view addSubview:navBar];
    self.navBarView = navBar;
    self.navBarView.backgroundColor = [UIColor whiteColor];
    
    [self.navBarView addSubview:self.titleLabel];
    
    [self.view addSubview:self.tableView];
    
    UITapGestureRecognizer *tapSuperGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(placedBottom)];
    [self.view addGestureRecognizer:tapSuperGesture];
    
    [self.view addSubview:self.placedBottomBtn];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 200)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(100, 27, SCREEN_WIDTH - 200, 30);
        _titleLabel.text = @"仿滴滴打车";
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        _titleLabel.textColor = TYColorFromHex(0X000000);
    }
    return _titleLabel;
}

-(MKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
        CLLocationCoordinate2D coordinate = {31.142958, 121.293939};
    
        [_mapView setCenterCoordinate:coordinate animated:YES];

        _mapView.showsUserLocation = YES;
    }
    return _mapView;
}

-(UIButton *)resetLocationBtn{
    if (!_resetLocationBtn) {
        _resetLocationBtn = [[UIButton alloc] init];
        [_resetLocationBtn setImage:[UIImage imageNamed:@"Location_Icon"] forState:UIControlStateNormal];
        [_resetLocationBtn addTarget:self action:@selector(resetLocation:) forControlEvents:UIControlEventTouchUpInside];
        _resetLocationBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 80, 50, 50);
    }
    return _resetLocationBtn;
}

-(UIButton *)placedBottomBtn{
    if (!_placedBottomBtn) {
        _placedBottomBtn = [[UIButton alloc] init];
        [_placedBottomBtn setImage:[UIImage imageNamed:@"placedBottom"] forState:UIControlStateNormal];
        [_placedBottomBtn addTarget:self action:@selector(placedBottom) forControlEvents:UIControlEventTouchUpInside];
        _placedBottomBtn.frame = CGRectMake(20, 30, 50, 50);
        _placedBottomBtn.hidden = YES;
    }
    return _placedBottomBtn;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *myCell = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:myCell];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试 - %ld",indexPath.row];
    cell.textLabel.textAlignment =NSTextAlignmentCenter;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        CGFloat offset = scrollView.contentOffset.y;
        if (offset>100 && !self.isBlack) {
            self.isBlack = YES;
            [UIView animateWithDuration:0.25 animations:^{
                self.tableView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
                self.navBarView.frame = CGRectMake(0, -64, SCREEN_WIDTH, 64);
                self.placedBottomBtn.hidden = NO;
            }];
        }
        if (offset<100 && self.isBlack) {
            self.isBlack = NO;
            [UIView animateWithDuration:0.25 animations:^{
                self.tableView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
                self.navBarView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
                self.placedBottomBtn.hidden = YES;
            }];
        }
    }
}

-(void)placedBottom{
    
    if (_isBlack) {
        [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
    }
}

- (void)resetLocation:(id)sender {
    // 定位到我的位置
    [_mapView setCenterCoordinate:_mapView.userLocation.coordinate animated:YES];
}

@end
