//
//  EVAWheelButton.m
//  CALayerAnimatable
//
//  Created by lyh on 15/11/8.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "EVAWheelButton.h"

@implementation EVAWheelButton

-(CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = 40;
    CGFloat imageH = 47;
    CGFloat imageX = (contentRect.size.width - imageW) * 0.5;
    CGFloat imageY = 20;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}
#pragma mark - 重写父类方法
-(void)setHighlighted:(BOOL)highlighted {
//    [super setHighlighted:highlighted];
}

@end
