//
//  CalendarCollectionReusableView.m
//  CardCalendar
//
//  Created by Summer on 2017/9/8.
//  Copyright © 2017年 summer. All rights reserved.
//

#import "CalendarCollectionReusableView.h"
#import "CalendarDefine.h"

@implementation CalendarCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createReusableView];
    }
    return self;
}

- (void)createReusableView
{
    NSArray *weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
    for (NSInteger index = 0; index < 7; index++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectIntegral(CGRectMake(self.frame.size.width / 7 * index ,0,self.frame.size.width / 7,self.frame.size.height))];
        label.text = weekArray[index];
        label.textColor = ResusableWeekLabelTextColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = ResusableWeekLabelBackGroundColor;
        label.font = ResusableWeekLabelTextFont;
        [self addSubview:label];
    }

    
}

@end
