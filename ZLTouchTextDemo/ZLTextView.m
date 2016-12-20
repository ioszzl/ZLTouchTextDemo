//
//  ZLTextView.m
//  ZLTouchTextDemo
//
//  Created by scasy_wang on 2016/12/1.
//  Copyright © 2016年 scasy_wang. All rights reserved.
//

#import "ZLTextView.h"
#import "CharactorModel.h"

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height
@interface ZLTextView ()
@property (nonatomic, strong) NSMutableArray *strMuArr;
@property (nonatomic, strong) NSArray *charactorModelArr;
@end
@implementation ZLTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)touchTextWithString:(NSString *)str origin:(CGFloat)x :(CGFloat)y width:(CGFloat)width font:(CGFloat)font interX:(CGFloat)interX leadingY:(CGFloat)leadingY{
    
    ZLTextView *zltouchTextV = [[ZLTextView alloc]init];
    [zltouchTextV showTouchTextWithString:str width:width font:font interX:interX leadingY:leadingY];
    CGFloat height=[(CharactorModel *)[zltouchTextV.charactorModelArr lastObject] y]+font;
    zltouchTextV.frame = CGRectMake(x, y, width, height);
    return zltouchTextV;
    
}

+(instancetype)touchTextWithString:(NSString *)str origin:(CGFloat)x :(CGFloat)y width:(CGFloat)width font:(CGFloat)font interX:(CGFloat)interX leadingY:(CGFloat)leadingY completed:(TouchesBlock)block{
    ZLTextView *zltouchTextV = [self touchTextWithString:str origin:x :y width:width font:font interX:interX leadingY:leadingY];
    
    [zltouchTextV didTouchesText:block];
    return zltouchTextV;
}

-(void)didTouchesText:(TouchesBlock)block{
    
    self.didtouches = block;
}

/**
 将要显示的文字排列展示到界面上，将单个文字转成charactorModel对象，装到数组里返回
 
 @param str 要显示的一段文字
 @param width 展示的宽度
 @param font 单个字的大小
 @param interX 两个字间的间隔
 @param leadingY 行间距
 
 */
-(void)showTouchTextWithString:(NSString *)str width:(CGFloat)width font:(CGFloat)font interX:(CGFloat)interX leadingY:(CGFloat)leadingY{
    NSArray *strArr = [NSArray array];
    NSMutableArray *charModelMuArr = [NSMutableArray array];
    if ([str containsString:@"\n"]) {
        strArr = [str componentsSeparatedByString:@"\n"];
    }else{
        strArr = @[str];
    }
    int m = (int)((width+interX)/(font+interX));
    int a=0,b=0;
    for (int t=0; t<strArr.count; t++) {
        NSString *string = strArr[t];
        
        for (int i=0; i<string.length; i++) {
            CharactorModel *charModel = [[CharactorModel alloc]init];
            charModel.string = [string substringWithRange:NSMakeRange(i, 1)];
            b=i/m;
            
            charModel.x = i*(font + interX) - b*(m*(font+interX)) ;//((int)(WIDTH/font)*(font+interX)-(WIDTH-font))
            charModel.y = (t+a+b) * (font + leadingY);
            charModel.font = font;
            [charModelMuArr addObject:charModel];
        }
        a=a+b;
    }
    for (CharactorModel *charM in charModelMuArr) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(charM.x, charM.y, charM.font, charM.font)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:15];
        //        lab.backgroundColor = [UIColor colorWithRed:charM.selectRGBColor.r green:charM.selectRGBColor.g blue:charM.selectRGBColor.b alpha:1];
        charM.lab = lab;
        lab.backgroundColor = [UIColor orangeColor];
        lab.text = charM.string;
        [self addSubview:lab];
    }
    self.charactorModelArr = charModelMuArr;
    
    //    return [NSArray arrayWithArray:charModelMuArr];
}
//判断一个点的位置是否在该charM上
-(BOOL)selectText:(CGPoint)point :(CharactorModel *)charM{
    
    CGFloat X =point.x ;
    CGFloat Y =point.y;
    //    NSLog(@"%f--%f  %f-%f",X,Y ,oneM.x,oneM.y);
    if ((X>charM.x && X<charM.x+charM.font) && (Y>charM.y && Y<charM.y+charM.font)) {
        return YES;
    }else{
        return NO;
    }
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    for (CharactorModel *m in self.charactorModelArr) {
        if ([self selectText:point :m]) {
            if (![self.strMuArr containsObject:m]) {
                [self.strMuArr addObject:m];
                
                m.lab.backgroundColor = [UIColor blueColor];
            }
            
            break;
        }
        
    }
    //    [self.pointMuArr addObject:[NSValue valueWithCGPoint:point]];
    
    //    NSLog(@"%f-%f",point.x,point.y);
    //    NSLog(@"move");
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //是否将响应传递到下一个响应者
//    [super touchesBegan:touches withEvent:event];
//    [[self nextResponder] touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    for (CharactorModel *m in self.charactorModelArr) {
        if ([self selectText:point :m]) {
            if (![self.strMuArr containsObject:m]) {
                [self.strMuArr addObject:m];
                m.lab.backgroundColor = [UIColor blueColor];
            }
            break;
        }
        
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSString *string = @"";
    //    for (CharactorModel *m in self.charactorModelArr) {
    //        for (NSValue *pointValue in self.pointMuArr) {
    //            if ([self selectText:[pointValue CGPointValue] :m]) {
    //               string = [string stringByAppendingString:m.string];
    //                break;
    //            }
    //        }
    //
    //    }
    //    [self.pointMuArr removeAllObjects];
    
    for (CharactorModel *m in self.strMuArr) {
        string = [string stringByAppendingString:m.string];
        m.lab.backgroundColor=[UIColor orangeColor];
    }
    
    [self.strMuArr removeAllObjects];
    
    if (self.didtouches != nil) {
        self.didtouches(string);
    }
    //    [self speechWithString:string];
    
}
-(NSMutableArray *)strMuArr{
    if (!_strMuArr) {
        _strMuArr = [NSMutableArray array];
    }
    return _strMuArr;
}

@end
