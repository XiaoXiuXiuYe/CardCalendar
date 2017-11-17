//
//  Adaption.h
//  CardCalendar
//
//  Created by Summer on 2017/9/8.
//  Copyright © 2017年 summer. All rights reserved.
//

#ifndef Adaption_h
#define Adaption_h

#pragma 尺寸

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#pragma 参照尺寸

#define WidthAdaption(width) kScreenWidth * width / 375.0
#define HeightAdaption(height) kScreenHeight * height / 667.0


#endif /* Adaption_h */
