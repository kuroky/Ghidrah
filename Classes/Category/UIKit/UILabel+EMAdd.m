//
//  UILabel+EMAdd.m
//  Emucoo
//
//  Created by kuroky on 2017/7/3.
//  Copyright © 2017年 Emucoo. All rights reserved.
//

#import "UILabel+EMAdd.h"

@implementation UILabel (EMAdd)

//MARK:- UILabel富文本
- (void)em_attributeContent:(NSString *)content
           normalAttributes:(NSDictionary *)normalAtt
             specialStrings:(NSArray *)strArr
          specialattributes:(NSArray *)attArr
                  lineSpace:(CGFloat)lineSpace {
    
    if (!content || !content.length) {
        return;
    }
    
    if (!strArr || !strArr.count || !attArr || !attArr.count) {
        return;
    }
    
    if (strArr.count != attArr.count) {
        return;
    }
    
    NSMutableDictionary *nattributes = [NSMutableDictionary dictionaryWithDictionary:normalAtt];
    NSMutableParagraphStyle *style;
    if (lineSpace > 0) {
        style = [NSMutableParagraphStyle new];
        style.lineSpacing = lineSpace;
        [nattributes setValue:style forKey:NSParagraphStyleAttributeName];
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:content
                                                                            attributes:nattributes];
    [strArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [content localizedStandardRangeOfString:obj];
        if (NSNotFound == range.location || range.length <= 0) {
            return;
        }
        NSMutableDictionary *attribute = [NSMutableDictionary dictionaryWithDictionary:attArr[idx]];
        [attribute setValue:style forKey:NSParagraphStyleAttributeName];
        [str setAttributes:attribute range:range];
    }];
    self.attributedText = str;
}

//MARK:- UILabel增加行间距
- (void)em_addContentSpace:(NSString *)content
             withLineSpace:(CGFloat)lineSpace {
    if (!content || !content.length) {
        return;
    }
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = lineSpace;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName: style};
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:content
                                                                            attributes:attributes];
    self.attributedText = str;
}

//MARK:- UILabel增加删除线
- (void)em_addStrikethrough:(NSString *)content {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:content];
    [str addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)
                     range:NSMakeRange(0, str.length)];
    self.attributedText = str;
}

@end
