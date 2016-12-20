//
//  CharactorModel.h
//  TTS_运用
//
//  Created by scasy_wang on 2016/11/29.
//  Copyright © 2016年 scasy_wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>


//RGBColor RGBColoraaa(CGFloat r, CGFloat g, CGFloat b)
//{
//    RGBColor color; color.r = r; color.g = g; color.b = b; return color;
//}

@interface CharactorModel : NSObject
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat font;
@property (nonatomic, copy) NSString *string;

@property (nonatomic, strong) UILabel *lab;

@end
                                                                                                                  
