//
//  MMDCardAnimation.m
//  MiMe
//
//  Created by Apple on 16/11/17.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MMDViewAnimation.h"

@implementation MMDViewAnimation

+ (MMDViewAnimation*)shareInstance {
    static MMDViewAnimation *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[MMDViewAnimation alloc]init];
    });
    
    return obj;
}

- (void)animationWithObject:(UIView *)obj pathArray:(NSArray *)pathArray isRotation:(BOOL)isRotation endScale:(CGFloat)endScale {
    
    if (!obj || pathArray.count == 0) {
        return;
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i=0;i<pathArray.count;i++) {
         CGPoint point= CGPointFromString([pathArray objectAtIndex:i]);
        if (i==0) {
            [path moveToPoint:point];
        } else {
            [path addLineToPoint:point];
        }
    }

    //    缩放动画
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    动画总时间
    narrowAnimation.duration = 0.5f;
//    narrowAnimation.beginTime = 0.5f;

    narrowAnimation.fillMode = kCAFillModeForwards;
    //    开始图片大小
    narrowAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    //    结束图片大小
    narrowAnimation.toValue = [NSNumber numberWithFloat:0.2];
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAKeyframeAnimation *animation=nil;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.removedOnCompletion = NO;
//    保存动画之后的状态
    animation.fillMode = kCAFillModeForwards;
    animation.path = path.CGPath;
    animation.duration = 1.0f;
    animation.beginTime = 0.5f;
//    kCAAnimationPaced 使得动画均匀进行,而不是按keyTimes设置的或者按关键帧平分时间,此时keyTimes和
    animation.calculationMode = kCAAnimationPaced;
    //旋转的模式,auto就是沿着切线方向动，autoReverse就是转180度沿着切线动
    animation.rotationMode = kCAAnimationRotateAuto;
    
    //    缩放动画
    CABasicAnimation *LastnarrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    动画总时间
    LastnarrowAnimation.duration = 1.0f;
    LastnarrowAnimation.beginTime = 0.5f;
    LastnarrowAnimation.fillMode = kCAFillModeForwards;
    //    开始图片大小
    LastnarrowAnimation.fromValue = [NSNumber numberWithFloat:0.2];
    //    结束图片大小
    LastnarrowAnimation.toValue = [NSNumber numberWithFloat:0.05];
    LastnarrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[narrowAnimation,animation,LastnarrowAnimation];
    groups.duration = 1.5f;
    groups.delegate = self;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    [obj.layer addAnimation:groups forKey:@"group"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(animationDidFinish)]) {
        [self.delegate performSelector:@selector(animationDidFinish) withObject:nil];
    }
}

@end
