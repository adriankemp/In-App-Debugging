//
//  DebugWindow.h
//  MyFitLife
//
//  Created by Adrian Kemp on 2013-02-22.
//  Copyright (c) 2013 FitLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DebugConsoleViewController.h"

@interface DebugWindow : UIWindow <DebugConsoleViewControllerDelegate>

+ (DebugWindow *) sharedWindow;

@property (nonatomic, readonly) UIView *debugConsole;
@property (nonatomic, strong) DebugConsoleViewController *rootViewController;

@end
