//
//  ViewController.m
//  CardCalendar
//
//  Created by Summer on 2017/9/6.
//  Copyright © 2017年 summer. All rights reserved.
//

#import "ViewController.h"
#import "CalendarCollectionViewCell.h"
#import "JKCategories.h"
#import "CalendarModel.h"
#import "CalendarCollectionReusableView.h"
#import "Adaption.h"


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong)  UICollectionView *collectionView;
@property (nonatomic , strong)  UILabel *dateLabel;

@property (nonatomic , strong)  NSDate *date;//计算出的当前日期
@property (nonatomic , strong)  NSDate *firstDate;//显示月的第一天
@property( nonatomic, assign)NSInteger allDays;//某月的总天数
@property( nonatomic, assign)NSInteger dayInWeek;//1号是一个星期的第几天
@property( nonatomic, assign)BOOL isTodayTouch;//今天是否可以点击
@property( nonatomic, assign)BOOL isAfterDayTouch;//之后的日期是否可以点击
@property( nonatomic, assign)BOOL isBeforeDayTouch;//之前的日期是否可以点击
@property( nonatomic, assign)BOOL isShowImage;//是否显示图片
@property( nonatomic, assign)BOOL isMultChoice;//是否多选

@property (nonatomic , strong)  NSMutableArray<CalendarModel*> *dataSource;//数据源



@end

#define CellWidth ([UIScreen mainScreen].bounds.size.width / 7)


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 40, 20, 30)];
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:@"<" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(previous) forControlEvents:UIControlEventTouchUpInside
     ];
    [self.view addSubview:button];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(130, 40, 100, 30)];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label];
    self.dateLabel = label;
    
    

    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(230, 40, 20, 30)];
    button2.backgroundColor = [UIColor clearColor];
    [button2 setTitle:@"> " forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside
     ];
    [self.view addSubview:button2];

    
    [self.view addSubview:self.collectionView];
    
    self.isAfterDayTouch = YES;
    self.isTodayTouch = YES;
    self.isBeforeDayTouch = YES;
    self.isShowImage = YES;
    self.isMultChoice = NO;
    
    [self caculateData:[NSDate date]];
    
    
}


- (void)caculateData:(NSDate *)date{
    self.dateLabel.text = [NSDate jk_stringWithDate:date format:@"YYYY年MM月"];
    //计算月份的总天数
    self.allDays = [NSDate jk_daysInMonth:date];
    //给当前日期赋值
    self.date = date;
    //这个月的第一天
    NSDate *firstDate = [date jk_beginningOfMonth] ;
    self.firstDate = firstDate;
    //1号是一个星期的第几天，如星期六是一个星期的第七天
    self.dayInWeek = [NSDate jk_weekday:firstDate];
    
    self.dataSource = [NSMutableArray array];
    //给数据源赋值
    for (NSInteger index = 0; index < self.allDays + self.dayInWeek - 1; index++) {
        CalendarModel *model = [[CalendarModel alloc]init];
        if (index < self.dayInWeek - 1) {
            model.year = -1;
            model.month = -1;
            model.day = -1;
        }else{
            model.year = [date jk_year];
            model.month = [date jk_month];
            model.day = index - self.dayInWeek + 2;
            NSDate *temp = [NSDate jk_dateWithYear:(int)model.year month:(int)model.month day:(int)model.day];
            model.isToday = [temp jk_isToday];
            model.isAfterDay = [temp jk_isInFuture];
            model.isBeforeDay = [temp jk_isInPast];
            model.isBeforeDayTouch = self.isBeforeDayTouch;
            model.isAfterDayTouch = self.isAfterDayTouch;
            model.isTodayTouch = self.isTodayTouch;
            model.isShowImage = self.isShowImage;
        }
        [self.dataSource addObject:model];
    }
    [self.collectionView reloadData];

    
}

- (void)next{
    [self.dataSource removeAllObjects];
    [self caculateData:[self.date jk_nextMonth]];
    
}
- (void)previous{
    
    [self.dataSource removeAllObjects];
    [self caculateData:[self.date jk_previousMonth]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
      CalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell) {
        CalendarModel *model = self.dataSource[indexPath.row];
        cell.model = model;
        cell.block = ^(UIButton *sender) {
            if (!self.isMultChoice) {
                for (NSInteger index = 0; index < self.dataSource.count; index++) {
                    self.dataSource[index].isSelect = NO;
                }
                self.dataSource[self.dayInWeek - 1  + model.day - 1].isSelect = YES;
            }
            [self.collectionView reloadData];
            NSLog(@"date = %@",[NSDate jk_dateWithYear:model.year month:model.month day:model.day]);
        };
    }
    return cell;
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CalendarCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        return headerView;
    }
    return nil;
}

//设置header的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(CellWidth * 7, WidthAdaption(50));
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        // 1: collection view  的布局
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        // 滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // itemSize
        flowLayout.itemSize = CGSizeMake(CellWidth, WidthAdaption(40));
        // 设置item之间的间距
        flowLayout.minimumInteritemSpacing = 0; //仅仅是参考，会根据间距，还有屏幕宽度来动态的调整，解决方法，设置内偏移量
        //设置item之间的行距
        flowLayout.minimumLineSpacing = 0;
        //2 实例化一个 CollectionView
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.dateLabel.frame), CellWidth * 7, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(self.dateLabel.frame)) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //设置内偏移量
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //实现可重用机制，只有注册的这一种方式，item，header,footer 都需要重用
        [_collectionView registerClass:[CalendarCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[CalendarCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return _collectionView;
}


@end
