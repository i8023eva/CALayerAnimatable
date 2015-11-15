//
//  EVASnowView.m
//  CALayerAnimatable
//
//  Created by lyh on 15/11/15.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "EVASnowView.h"

@interface EVASnowView ()
{
    CGFloat _snowY;
}
@end

@implementation EVASnowView

- (void)awakeFromNib
{
    //    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
    
    // 每次屏幕刷新 就会触发事件
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
    
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (_snowY > [UIScreen mainScreen].bounds.size.height) {
        _snowY = 0;
    }
    
    _snowY += 10;
    
    // 加载雪花
    UIImage *image = [UIImage imageNamed:@"雪花"];
    
    // 画到左上角
    [image drawAtPoint:CGPointMake(0, _snowY)];
}

@end
