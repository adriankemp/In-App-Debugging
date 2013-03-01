//
//  DebugWindow.m
//  MyFitLife
//
//  Created by Adrian Kemp on 2013-02-22.
//  Copyright (c) 2013 FitLife. All rights reserved.
//

#import "DebugWindow.h"
#import "DebugConsoleViewController.h"


@interface DebugWindow ()

@property (nonatomic, weak) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) DebugConsoleViewController *debugConsoleViewController;
@property (nonatomic, weak) UIWindow *presentingWindow;

@end

@implementation DebugWindow

static DebugWindow *sharedWindow;
+ (DebugWindow *)sharedWindow {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedWindow = [[DebugWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return sharedWindow;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    [self addGestureRecognizer: self.tapGestureRecognizer = (UITapGestureRecognizer *)[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recievedTapGesture:)]];
    self.tapGestureRecognizer.enabled = NO;
    
    self.rootViewController = [DebugConsoleViewController defaultController];
    self.rootViewController.delegate = self;
    _debugConsole = self.rootViewController.view;
    self.debugConsole.backgroundColor = [UIColor lightGrayColor];
    return self;
}

- (void)makeKeyAndVisible {
    self.presentingWindow = [UIApplication sharedApplication].keyWindow;
    [super makeKeyAndVisible];
}

- (void)becomeKeyWindow {
    [super becomeKeyWindow];
    self.tapGestureRecognizer.enabled = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect debugConsoleFrame = CGRectMake(0.0f, self.bounds.size.height, self.bounds.size.width, kDebugConsoleHeight);
    UIViewUpdateFrameIfNeeded(self.debugConsole, debugConsoleFrame);
    [self bringSubviewToFront:self.debugConsole];
}


- (void)recievedTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer {
    CGPoint location = [tapGestureRecognizer locationInView:self.debugConsole];
    switch (tapGestureRecognizer.state) {
        case UIGestureRecognizerStateEnded:
            if(location.y < 0) {
                [self.rootViewController hideDebugConsole];
            }
            break;
        default:
            break;
    }
}

- (void)debugConsoleDidHide {
    [self.presentingWindow makeKeyAndVisible];
}

@end
