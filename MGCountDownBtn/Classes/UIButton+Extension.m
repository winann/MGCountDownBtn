//
//  UIButton+Extension.m
//  MogoRenter
//
//  Created by Andrew on 15/10/30.
//  Copyright © 2015年 MogoRoom. All rights reserved.
//

#import "UIButton+Extension.h"
//#import "LRTextField.h"
#import <objc/runtime.h>


@implementation UIButton (Extension)

- (void)startTime
{
    for (UIView *obj in self.superview.subviews)
    {
        if ([obj isKindOfClass:[UITextField class]])
        {
            UITextField *inputView = (UITextField *)obj;
            NSRange range = [inputView.placeholder rangeOfString:@"验证码"];
            if (range.location != NSNotFound)
            {
                [inputView becomeFirstResponder];
                break;
            }
        }
    }
    
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                if ([[self titleForState:UIControlStateNormal] isEqualToString:@"1s"])
                {
                    [self setTitle:@"再次发送" forState:UIControlStateNormal];
                }
                else
                {
                    [self setTitle:@"发送验证码" forState:UIControlStateNormal];
                }
                timeout = 59;
                self.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%ds", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.titleLabel.text = strTime;
                [self setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}

@end
