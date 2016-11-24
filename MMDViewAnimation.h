//
//  MMDCardAnimation.h
//  MiMe
//
//  Created by Apple on 16/11/17.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MMDViewAnimationpProtocol

@optional
- (void)animationDidFinish;

@end

@interface MMDViewAnimation : NSObject

+ (MMDViewAnimation*)shareInstance;

/**
 *  将某个view或者layer从起点抛到终点
 *
 *  @param obj          需要动画的View
 *  @param pathArray    动画经过的坐标
 *  @param isRotation   是否需要旋转
 *  @param endScale     动画之后的大小 （0～1）；
 */
- (void)animationWithObject:(UIView *)obj pathArray:(NSArray *)pathArray isRotation:(BOOL)isRotation endScale:(CGFloat)endScale;

@property (weak, nonatomic) id delegate;

@end
