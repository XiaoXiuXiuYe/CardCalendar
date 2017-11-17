//
//  CalendarModel.h
//  CardCalendar
//
//  Created by Summer on 2017/9/7.
//  Copyright © 2017年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarModel : NSObject

@property (nonatomic , assign)NSInteger year;
@property (nonatomic , assign)NSInteger month;
@property (nonatomic , assign)NSInteger day;
@property( nonatomic, assign)BOOL isSelect;
@property( nonatomic, assign)BOOL isToday;
@property( nonatomic, assign)BOOL isAfterDay;
@property( nonatomic, assign)BOOL isBeforeDay;
@property( nonatomic, assign)BOOL isTodayTouch;
@property( nonatomic, assign)BOOL isAfterDayTouch;
@property( nonatomic, assign)BOOL isBeforeDayTouch;
@property( nonatomic, assign)BOOL isShowImage;

@end
