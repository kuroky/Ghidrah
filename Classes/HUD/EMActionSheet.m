//
//  EMActionSheet.m
//  Emucoo
//
//  Created by kuroky on 2017/7/20.
//  Copyright © 2017年 Emucoo. All rights reserved.
//

#import "EMActionSheet.h"
#import "UIView+EMAdd.h"
#import "UIImage+EMAdd.h"
#import "UIViewController+EMAdd.h"

#define LineColor   [UIColor colorWithRed:210.0/255 green:210.0/255 blue:214.0/255 alpha:1.0]

#define BtnTitleColor  [UIColor colorWithRed:32.0/255 green:34.0/255 blue:53.0/255 alpha:1.0]
#define BtnTitleHighColor  [UIColor colorWithRed:34.0/255 green:162.0/255 blue:228.0/255 alpha:1.0]

#define CancelBtnTitleColor  [UIColor colorWithRed:143.0/255 green:144.0/255 blue:154.0/255 alpha:1.0]

#define BtnNormalImageColor [UIColor colorWithRed:243.0/255 green:243.0/255 blue:244.0/255 alpha:1.0]

static CGFloat const KPopSheetCellHeight          =   50;
NSInteger const EMPopSheetCancel         =   403;

@interface EMActionSheet () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, weak) UIView *buttonsView;
@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, weak) UIView *backView;

/**
 *  操作按钮titles
 */
@property (nonatomic, strong) NSMutableArray *titles;

/**
 *  内容高度
 */
@property (nonatomic, assign) NSInteger containerHeight;
@property (nonatomic, copy) PopSheetActionHandler actionHandler;

@end

@implementation EMActionSheet

+ (EMActionSheet *)showPopSheet:(UIView *)view
                buttonTitles:(NSArray *)buttonTitles {
    if (!view) {
        view = [UIViewController em_currentViewController].view;
    }
    
    [view endEditing:YES];
    EMActionSheet *actionSheet = [[self alloc] initWithFrame:view.bounds];
    [view addSubview:actionSheet];
    actionSheet.titles = [NSMutableArray arrayWithArray:buttonTitles];
    return actionSheet;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    if (!_backView) {
        self.backView = [self setupBackView];
    }
    
    if (!_containerView) {
        self.containerView = [self setupContentView];
    }
    
    if (!_buttonsView) {
        self.buttonsView = [self setupButtonsView];
    }
    self.contentWidth = self.em_width - 56;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}

#pragma mark - back View
- (UIView *)setupBackView {
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [self addSubview:backView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePopSheet)];
    tapGesture.delegate = self;
    [backView addGestureRecognizer:tapGesture];
    return backView;
}

#pragma mark - 容器View
- (UIView *)setupContentView {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:contentView];
    contentView.backgroundColor = [UIColor clearColor];
    return contentView;
}

- (UIView *)setupButtonsView {
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectZero];
    buttonView.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:buttonView];
    return buttonView;
}

- (void)pan:(UIPanGestureRecognizer *)g {
    
}

#pragma mark - Content frame
- (void)setTitles:(NSMutableArray *)titles {
    if (!titles.count || !titles) {
        return;
    }
    _titles = [NSMutableArray arrayWithArray:titles];
    [_titles addObject:@"取消"];
    self.containerHeight = _titles.count * KPopSheetCellHeight + 10 + 15;
    
    self.containerView.frame = CGRectMake(28, self.em_height, self.contentWidth, self.containerHeight);
    
    self.buttonsView.frame = CGRectMake(0, 0, self.contentWidth, titles.count * KPopSheetCellHeight);
    [self.buttonsView em_drawCorner:UIRectCornerAllCorners
                         withRadius:4.0
                         withBounds:CGRectMake(0, 0, self.contentWidth, titles.count * KPopSheetCellHeight)];
    
    [_titles enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx + 1 == _titles.count) {
            UIButton *btn = [self addCancelButton:idx];
            btn.tag = EMPopSheetCancel;
            [self.containerView addSubview:btn];
            btn.frame = CGRectMake(0, idx * KPopSheetCellHeight + 10, self.contentWidth, KPopSheetCellHeight);
        }
        else {
            UIButton *btn = [self addConfirmButton:idx];
            btn.tag = idx;
            [self.buttonsView addSubview:btn];
            btn.frame = CGRectMake(0, idx * KPopSheetCellHeight, self.contentWidth, KPopSheetCellHeight);
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, idx * KPopSheetCellHeight, self.contentWidth, 0.5)];
            lineView.backgroundColor = LineColor;
            [self.buttonsView addSubview:lineView];
        }
    }];
}

#pragma mark - Action buttons
- (UIButton *)addActionButton:(NSString *)title
                  normalImage:(UIImage *)normalImage
                    highImage:(UIImage *)highImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectZero;
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    
    [btn setTitleColor:BtnTitleColor forState:UIControlStateNormal];
    [btn setTitleColor:BtnTitleHighColor forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (UIButton *)addConfirmButton:(NSInteger)idx {
    UIImage *normalImage = [UIImage em_imageWithColor:[UIColor whiteColor]];
    UIImage *highImage = [UIImage em_imageWithColor:BtnNormalImageColor];
    return [self addActionButton:_titles[idx]
                     normalImage:normalImage
                       highImage:highImage];
}

- (UIButton *)addCancelButton:(NSInteger)idx {
    UIImage *normalImage = [UIImage em_imageWithColor:[UIColor whiteColor]];
    UIImage *highImage = [UIImage em_imageWithColor:BtnNormalImageColor];
    UIButton *btn = [self addActionButton:_titles[idx]
                              normalImage:normalImage
                                highImage:highImage];
    [btn setTitleColor:CancelBtnTitleColor forState:UIControlStateNormal];
    [btn setTitleColor:BtnTitleColor forState:UIControlStateHighlighted];
    btn.layer.cornerRadius = 4.0;
    btn.layer.masksToBounds = YES;
    return btn;
}

- (void)clickAction:(UIButton *)sender {
    [self hidePopSheet];
    if (sender.tag == self.titles.count - 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.actionHandler) {
                self.actionHandler(sender.titleLabel.text, EMPopSheetCancel);
            }
        });
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.actionHandler) {
            self.actionHandler(sender.titleLabel.text, sender.tag);
        }
    });
}

#pragma mark - show/hide
- (void)showPopSheet {
    [UIView animateWithDuration:0.25f
                     animations:^{
                         self.backView.alpha = 1.0;
                         self.containerView.em_bottom = self.em_height;
                     }];
}

- (void)showPopSheetWithAction:(PopSheetActionHandler)handler {
    [self showPopSheet];
    self.actionHandler = handler;
}

- (void)hidePopSheet {
    [UIView animateWithDuration:0.25f
                     animations:^{
                         self.backView.alpha = 0.0f;
                         self.containerView.em_bottom = self.em_height + self.containerHeight;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.containerView]) {
        return NO;
    }
    return YES;
}

- (void)dealloc {
    
}

@end
