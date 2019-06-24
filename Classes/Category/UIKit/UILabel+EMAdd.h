//
//  UILabel+EMAdd.h
//  Emucoo
//
//  Created by kuroky on 2017/7/3.
//  Copyright © 2017年 Emucoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (EMAdd)

/**
 UILabel富文本

 @param content 文字
 @param normalAtt 格式1 (@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]})
 @param strArr 格式字符 @[@"text1", @"text2", @"text3", ...]
 @param attArr 字符格式 @[@{Attributes1}, @{Attributes2}, @{Attributes3}, ...]
 @param lineSpace 行间距
 */
- (void)em_attributeContent:(NSString *)content
           normalAttributes:(NSDictionary *)normalAtt
             specialStrings:(NSArray *)strArr
          specialattributes:(NSArray *)attArr
                  lineSpace:(CGFloat)lineSpace;

/**
 UILabel增加行间距

 @param content 内容
 @param lineSpace 行间距
 */
- (void)em_addContentSpace:(NSString *)content
             withLineSpace:(CGFloat)lineSpace;

/**
 UILabel增加删除线

 @param content 内容
 */
- (void)em_addStrikethrough:(NSString *)content;

@end
