//
//  EVAWheelView.m
//  CALayerAnimatable
//
//  Created by lyh on 15/11/8.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "EVAWheelView.h"

#define angle2radian(x) ((x) / 180.0 * M_PI)
@interface EVAWheelView ()
@property (weak, nonatomic) IBOutlet UIImageView *rotateImageView;

@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation EVAWheelView

+(instancetype) wheelView {
    return [[NSBundle mainBundle] loadNibNamed:@"EVAWheelView" owner:nil options:nil].firstObject;
}

//还没连线
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        NSLog(@"%@", _rotateImageView); ///null
    }
    return self;
}

-(void)awakeFromNib {
    UIImage *bigImage = [UIImage imageNamed:@"LuckyAstrology"];
    
    CGFloat imageH = bigImage.size.height * [UIScreen mainScreen].scale;
    CGFloat imageW = bigImage.size.width / 12 * [UIScreen mainScreen].scale;
    
    for (int i = 0; i < 12; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.layer.anchorPoint = CGPointMake(0.5, 1.f);
        
        button.layer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        
        button.bounds = CGRectMake(0, 0, 68, 143);
        
        button.layer.transform = CATransform3DMakeRotation(angle2radian(i * 30), 0, 0, 1);
        
        //设置前景图片
        //1>截取图片
        CGRect clipRect = CGRectMake(i * imageW, 0, imageW, imageH);
        /**
         *  Retina 屏
         *
         *  @param bigImage.CGImage 传的是像素
         *  @param clipRect         像素点
         *
         *  @return <#return value description#>
         */
        CGImageRef smallImage =  CGImageCreateWithImageInRect(bigImage.CGImage, clipRect);
        
        [button setImage:[UIImage imageWithCGImage:smallImage] forState:UIControlStateNormal];
        
        [button setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchDown];
        
        [self.rotateImageView addSubview:button];
    }
}

-(void) didClick: (UIButton *)sender {
    _selectedButton.selected = NO;//取消上一次 button 的选中
    sender.selected = YES;
    
    _selectedButton = sender;
}

@end
