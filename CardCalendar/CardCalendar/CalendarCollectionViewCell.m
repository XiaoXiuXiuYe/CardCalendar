//
//  CalendarCollectionViewCell.m
//  CardCalendar
//
//  Created by Summer on 2017/9/6.
//  Copyright © 2017年 summer. All rights reserved.
//

#import "CalendarCollectionViewCell.h"
#import "Adaption.h"
#import "CalendarDefine.h"

@implementation CalendarCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    {
        [self createCell];
    }
    return self;
}

- (void)createCell{
    
    _circleLabel = [[UILabel alloc]init];
    _circleLabel.frame = CGRectMake(0, 0, WidthAdaption(22), WidthAdaption(22) );
    _circleLabel.center = CGPointMake(self.contentView.frame.size.width / 2, (self.frame.size.height - 10)/2);
    _circleLabel.layer.masksToBounds = YES;
    _circleLabel.layer.cornerRadius = WidthAdaption(11) ;
    [self.contentView addSubview:_circleLabel];
    
    _dateBtn = [[UIButton alloc]initWithFrame:CGRectIntegral(CGRectMake(0, 0, self.contentView.frame.size.width,self.frame.size.height - 10))];
    [_dateBtn setTitleColor:DateLabeDefaultTextColor forState:UIControlStateNormal];
    _dateBtn.titleLabel.font = DateLabeDefaultTextFont;
    [_dateBtn addTarget:self action:@selector(respondsToButton:) forControlEvents:UIControlEventTouchUpInside];
    _dateBtn.backgroundColor = DateLabeDefaultBackGroundColor;
    [self.contentView addSubview:_dateBtn];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.contentView.frame.size.width - WidthAdaption(4)) / 2, CGRectGetMaxY(_dateBtn.frame), WidthAdaption(4), WidthAdaption(4))];
    _imageView.image = [UIImage imageNamed:@"chidao"];
    [self.contentView addSubview:_imageView];
   
}
- (void)respondsToButton:(UIButton *)sender{
    if (_block) {
        sender.selected = !sender.selected;
        if (_model.isAfterDayTouch && _model.isAfterDay){
            _model.isSelect = sender.selected;
            self.model = _model;
            if (![sender.titleLabel.text isEqualToString:@""] && _model.isSelect) {
                _block(sender);
            }
        }else if (_model.isBeforeDayTouch && _model.isBeforeDay){
            _model.isSelect = sender.selected;
            self.model = _model;
            if (![sender.titleLabel.text isEqualToString:@""] && _model.isSelect) {
                _block(sender);
            }
        }else if (_model.isTodayTouch && _model.isToday){
            _model.isSelect = sender.selected;
            self.model = _model;
            if (![sender.titleLabel.text isEqualToString:@""] && _model.isSelect) {
                _block(sender);
            }
        }
    }
}
-(void)setModel:(CalendarModel *)model{
    _model = model;
    if (_model) {
        if (model.day == -1) {
            [_dateBtn setTitle:@"" forState:UIControlStateNormal];
        }else{
          [_dateBtn setTitle:[NSString stringWithFormat:@"%ld",model.day] forState:UIControlStateNormal];
        }
        if ([_dateBtn.titleLabel.text isEqualToString:@""]) {
            _dateBtn.hidden = YES;
            _imageView.hidden = YES;
        }else{
            _dateBtn.hidden = NO;
            _imageView.hidden = !_model.isShowImage;
        }
        
        if (_model.isToday || _model.isSelect) {
            if (_model.isToday) {
                [_dateBtn setTitleColor:DateLabeTodayTextColor forState:UIControlStateNormal];
            }
            if (_model.isSelect) {
               [_dateBtn setTitleColor:DateLabeSelectTextColor forState:UIControlStateNormal];
            }
        }else if(_model.isBeforeDay){
            [_dateBtn setTitleColor:DateLabeBeforeDayTextColor forState:UIControlStateNormal];
        }else{
            [_dateBtn setTitleColor:DateLabeDefaultTextColor forState:UIControlStateNormal];
        }
        if (_model.isToday) {
            if (_model.isSelect) {
                _circleLabel.backgroundColor =  CircleLabeSelectBackGroundColor;

            }else{
                _circleLabel.backgroundColor = CircleLabeTodayBackGroundColor;
            }
        }else if (_model.isSelect) {
            _circleLabel.backgroundColor =  CircleLabeSelectBackGroundColor;
        }else{
            _circleLabel.backgroundColor =  CircleLabeDefaultBackGroundColor;

        }
    }
}

@end
