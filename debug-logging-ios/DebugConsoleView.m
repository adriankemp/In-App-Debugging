//
//  DebugConsoleView.m
//  MyFitLife
//
//  Created by Adrian Kemp on 2013-02-22.
//  Copyright (c) 2013 FitLife. All rights reserved.
//

#import "DebugConsoleView.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat const kConsoleAccessoryBarHeight = 44.0f;

@interface DebugConsoleView ()

@end

@implementation DebugConsoleView

- (id)init {
    self = [super init];
    if(self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.layer.shadowOffset = CGSizeMake(0.0f, -3.0f);
        self.layer.shadowOpacity = 0.5f;
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        [self addSubview: _textField = (UITextView *)[[UITextView alloc] init]];
        self.textField.editable = NO;
        self.textField.backgroundColor = self.backgroundColor;
        self.textField.font = [UIFont systemFontOfSize:8.0f];
        self.textField.text = @"Logging started";
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect textFieldFrame = CGRectMake(0.0f, 0.0f, self.bounds.size.width, self.bounds.size.height - kConsoleAccessoryBarHeight);
    UIViewUpdateFrameIfNeeded(self.textField, textFieldFrame);
}

@end
