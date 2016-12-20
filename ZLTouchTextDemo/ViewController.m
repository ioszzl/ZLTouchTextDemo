//
//  ViewController.m
//  ZLTouchTextDemo
//
//  Created by scasy_wang on 2016/12/1.
//  Copyright © 2016年 scasy_wang. All rights reserved.
//

#import "ViewController.h"
#import "CharactorModel.h"
#import "ZLTextView.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
@property(nonatomic, strong) NSMutableArray *strMuArr;
@property (nonatomic, strong) NSArray *charactorModelArr;
@property (nonatomic, strong) NSMutableArray *pointMuArr;
@property (nonatomic, strong) UIView *textLabView;
@property (weak, nonatomic) IBOutlet ZLTextView *zlTextVeiw;

@property (nonatomic, strong) AVSpeechSynthesizer *speechSyn;//语音合成
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pointMuArr = [NSMutableArray array];
    self.strMuArr = [NSMutableArray array];
    self.speechSyn = [[AVSpeechSynthesizer alloc]init];
    NSString *textStr = @"锄禾日当午，\n汗滴禾下土，谁知盘中餐，粒粒皆辛苦。";
    ZLTextView *textV=[ZLTextView touchTextWithString:textStr origin:100 :100 width:300 font:40 interX:10 leadingY:10 completed:^(NSString *string) {
        NSLog(@"---- %@",string);
        AVSpeechUtterance *speechUtt = [AVSpeechUtterance speechUtteranceWithString:string];
        AVSpeechSynthesisVoice *speechVoice = [AVSpeechSynthesisVoice voiceWithLanguage:nil];
        speechUtt.volume = 1;
        speechUtt.voice = speechVoice;
        speechUtt.rate = 0.2;
        speechUtt.pitchMultiplier = 1;
        
        [self.speechSyn speakUtterance:speechUtt];
    }];
    textV.center = self.view.center;
    [self.view addSubview:textV];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
