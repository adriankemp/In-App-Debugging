//
//  DebugConsoleViewController.h
//  MyFitLife
//
//  Created by Adrian Kemp on 2013-02-22.
//  Copyright (c) 2013 FitLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DebugConsoleView.h"


typedef enum {
    LogLevelDebug,
    LogLevelWarning,
    LogLevelCritical
} LogLevel;


void Log(LogLevel severity, NSString *format, ...);
@protocol DebugConsoleViewControllerDelegate;


@protocol DebugConsoleViewControllerDelegate <NSObject>
    @required
        - (void)debugConsoleDidHide;
@end


@interface DebugConsoleViewController : UIViewController
    @property (nonatomic, strong) DebugConsoleView *view;
    @property (nonatomic, weak) id <DebugConsoleViewControllerDelegate> delegate;
    @property (nonatomic, assign) LogLevel minimumLoggingLevel;

    - (void)presentDebugConsole;
    - (void)hideDebugConsole;
    - (void)addStringToConsoleLog:(NSString *)stringToAdd;
    + (DebugConsoleViewController *)defaultController;
@end
