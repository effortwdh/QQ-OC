//
//  WDHInputView.m
//  QQ
//
//  Created by 敦豪魏 on 2020/7/30.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "WDHInputView.h"
@interface WDHInputView()
@property(nonatomic,strong)UIButton *firstButton;
@property(nonatomic,strong)UIButton *secondButton;
@property(nonatomic,strong)UIButton *thirdButton;
@property(nonatomic,strong)UIButton *fourButton;
@property(nonatomic,strong)UIButton *fiveButton;
@property(nonatomic,strong)UIButton *sixButton;


@end
@implementation WDHInputView
- (void)drawRect:(CGRect)rect {
    
    //其他按钮
    self.firstButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 45, 80, 30)];
    self.firstButton.backgroundColor = [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:0.5];
    [self.firstButton.layer setCornerRadius:8.0];
    [self addSubview:self.firstButton];
    
    //其他按钮
    self.secondButton = [[UIButton alloc] initWithFrame:CGRectMake(90, 45, 80, 30)];
    self.secondButton.backgroundColor = [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:0.5];
    [self.secondButton.layer setCornerRadius:8.0];
    [self addSubview:self.secondButton];
    
    //其他按钮
    self.thirdButton = [[UIButton alloc] initWithFrame:CGRectMake(175, 45, 80, 30)];
    self.thirdButton.backgroundColor = [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:0.5];
    [self.thirdButton.layer setCornerRadius:8.0];
    [self addSubview:self.thirdButton];
    
    //其他按钮
    self.fourButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 45, 80, 30)];
    self.fourButton.backgroundColor = [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:0.5];
    [self.fourButton.layer setCornerRadius:8.0];
    [self addSubview:self.fourButton];
    
    //其他按钮
//    self.fiveButton = [[UIButton alloc] initWithFrame:CGRectMake(325, 45, 80, 30)];
//    [self.fiveButton setTitle:@"发送" forState:UIControlStateNormal];
//    self.fiveButton.backgroundColor = [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:0.5];
//    [self.fiveButton.layer setCornerRadius:8.0];
//    [self addSubview:self.fiveButton];
    
//    //其他按钮
//    self.firstButton = [[UIButton alloc] initWithFrame:CGRectMake(310, 4, 375-310-5, 30)];
//    [self.firstButton setTitle:@"发送" forState:UIControlStateNormal];
//    self.firstButton.backgroundColor = [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:0.5];
//    [self.firstButton.layer setCornerRadius:8.0];
//    [self addSubview:self.firstButton];
//
//    //其他按钮
//    self.sixButton = [[UIButton alloc] initWithFrame:CGRectMake(310, 4, 375-310-5, 30)];
//    [self.sixButton setTitle:@"发送" forState:UIControlStateNormal];
//    self.sixButton.backgroundColor = [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:0.5];
//    [self.sixButton.layer setCornerRadius:8.0];
//    [self addSubview:self.sixButton];
    
}
//// 返回NO禁止编辑
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    return YES;
//}
////开始编辑时触发，文本字段将成为first responder
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    NSLog(@"textFieldDidBeginEditing");
//    self.sendButton.backgroundColor = [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:1];
//}
////返回BOOL值，指定是否允许文本字段结束编辑，当编辑结束，文本字段会让出first responder
////要想在用户结束编辑时阻止文本字段消失，可以返回NO
////这对一些文本字段必须始终保持活跃状态的程序很有用，比如即时消息
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    NSLog(@"%@",textField.text);
//    
//    return YES;
//}
////即使shouldEndEditing返回否（例如，从窗口中删除视图）或endEditing：YES也可能被强制调用
////- (void)textFieldDidEndEditing:(UITextField *)textField{
////    //self.sendButton.backgroundColor = [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:0.5];
////    NSLog(@"textFieldDidEndEditing");
////}
////如果已实现，则代替textFieldDidEndEditing调用：
//- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason API_AVAILABLE(ios(10.0)){
//    NSLog(@"textFieldDidEndEditing");
//}
// // return NO to not change text
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSLog(@"shouldChangeCharactersInRange");
//    return YES;
//}
////文本输入后 在这里处理
//- (void)textFieldDidChangeSelection:(UITextField *)textField API_AVAILABLE(ios(13.0), tvos(13.0)){
//    if([textField.text  isEqual: @""]){
//        self.sendButton.backgroundColor = [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:0.5];
//    }
//    NSLog(@"textFieldDidChangeSelection");
//}
////按下清除按钮时调用。 返回NO以忽略（无通知）
//- (BOOL)textFieldShouldClear:(UITextField *)textField{
//    NSLog(@"textFieldShouldClear");
//    return YES;
//}
////按下“返回”键时调用。 返回NO即可忽略。
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    NSLog(@"textFieldShouldReturn");
//    return YES;
//}
//点击空白处回收键盘
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.nextResponder touchesBegan:touches withEvent:event];
//}
@end
