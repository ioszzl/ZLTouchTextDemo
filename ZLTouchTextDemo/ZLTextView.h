//
//  ZLTextView.h
//  ZLTouchTextDemo
//
//  Created by scasy_wang on 2016/12/1.
//  Copyright © 2016年 scasy_wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CharactorModel;
typedef void(^TouchesBlock)(NSString *string);
@interface ZLTextView : UIView
@property (nonatomic, copy) NSString *textString;
@property (nonatomic, strong) TouchesBlock didtouches;
+(instancetype)touchTextWithString:(NSString *)str origin:(CGFloat)x :(CGFloat)y width:(CGFloat)width font:(CGFloat)font interX:(CGFloat)interX leadingY:(CGFloat)leadingY completed:(TouchesBlock)block;
+(instancetype)touchTextWithString:(NSString *)str origin:(CGFloat)x :(CGFloat)y width:(CGFloat)width font:(CGFloat)font interX:(CGFloat)interX leadingY:(CGFloat)leadingY;

-(void)showTouchTextWithString:(NSString *)str width:(CGFloat)width font:(CGFloat)font interX:(CGFloat)interX leadingY:(CGFloat)leadingY;
-(BOOL)selectText:(CGPoint)point :(CharactorModel *)charM;
-(void)didTouchesText:(TouchesBlock)block;
@end
