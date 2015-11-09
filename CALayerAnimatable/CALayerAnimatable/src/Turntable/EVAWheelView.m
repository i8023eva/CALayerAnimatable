//
//  EVAWheelView.m
//  CALayerAnimatable
//
//  Created by lyh on 15/11/8.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "EVAWheelView.h"
#import "EVAWheelButton.h"
 
#define angle2radian(x) ((x) / 180.0 * M_PI)
@interface EVAWheelView ()
@property (weak, nonatomic) IBOutlet UIImageView *rotateImageView;

@property (nonatomic, weak) UIButton *selectedButton;

@property (nonatomic, strong) CADisplayLink *link;

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
    //需要被裁减的图片
    UIImage *bigImage = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *selectedImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    
    CGFloat imageH = bigImage.size.height * [UIScreen mainScreen].scale;
    CGFloat imageW = bigImage.size.width / 12 * [UIScreen mainScreen].scale;
    
    for (int i = 0; i < 12; i++) {
        EVAWheelButton *button = [EVAWheelButton buttonWithType:UIButtonTypeCustom];
        
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
        //选中状态
        CGImageRef selectedSmallImage =  CGImageCreateWithImageInRect(selectedImage.CGImage, clipRect);
        [button setImage:[UIImage imageWithCGImage:selectedSmallImage] forState:UIControlStateSelected];
        
//        button.adjustsImageWhenHighlighted = NO; 高亮状态还存在, 只是黑色字体消失
        
        
        [button setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchDown];
        
        if (i == 0) {
            [self didClick:button];//默认选中第一个
        }
        
        [self.rotateImageView addSubview:button];
    }
}

-(void) didClick: (UIButton *)sender {
    _selectedButton.selected = NO;//取消上一次 button 的选中
    sender.selected = YES;
    
    _selectedButton = sender;
}

-(CADisplayLink *)link {
    if (_link == nil) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _link;
}
/**
 *  核心动画的暂时位置与真实位置不符合
 */
-(void)startRotating {
    self.link.paused = NO;
}

-(void) update {
    self.rotateImageView.transform = CGAffineTransformRotate(self.rotateImageView.transform, angle2radian(45 / 60.f));
}

-(void)stopRotating {
    self.link.paused = YES;
}

- (IBAction)didClickSelected:(UIButton *)sender {
    //不需要用户交互
    self.rotateImageView.userInteractionEnabled = NO;
    //暂停上一个的旋转动画
    [self stopRotating];
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    anim.keyPath = @"transform.rotation";
    
    anim.toValue = @(M_PI * 2 * 3);
    
    anim.duration = 0.5;
    
    anim.delegate = self;
    
    [self.rotateImageView.layer addAnimation:anim forKey:nil];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.rotateImageView.userInteractionEnabled = YES;
    
    
    // 让选中按钮到中间位置
    //计算旋转角度
    CGFloat angle = atan2(_selectedButton.transform.b, _selectedButton.transform.a);
    //使转盘反向旋转
    self.rotateImageView.transform = CGAffineTransformMakeRotation(-angle);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startRotating];
    });
    
}

@end
