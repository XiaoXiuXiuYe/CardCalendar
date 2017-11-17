//
//  CalendarCollectionViewCell.h
//  CardCalendar
//
//  Created by Summer on 2017/9/6.
//  Copyright © 2017年 summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarModel.h"

typedef void(^buttonBlock)(UIButton *sender);

@interface CalendarCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIButton *dateBtn;
@property (nonatomic , strong)  UILabel *circleLabel;
@property (nonatomic , copy)buttonBlock block;
@property (nonatomic , strong)  CalendarModel *model;

@end
