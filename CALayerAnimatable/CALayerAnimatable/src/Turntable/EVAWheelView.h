//
//  EVAWheelView.h
//  CALayerAnimatable
//
//  Created by lyh on 15/11/8.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EVAWheelView : UIView

+(instancetype) wheelView;

// 开始旋转
- (void)startRotating;

// 停止旋转
- (void)stopRotating;
@end
