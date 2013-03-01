//
//  DebugConsoleViewController.m
//  MyFitLife
//
//  Created by Adrian Kemp on 2013-02-22.
//  Copyright (c) 2013 FitLife. All rights reserved.
//

#import "DebugConsoleViewController.h"
NSString *NSStringFromLogLevel(LogLevel severity);


@interface DebugConsoleViewController ()

@end

@implementation DebugConsoleViewController

@synthesize minimumLoggingLevel = _minimumLoggingLevel;
@synthesize delegate = _delegate;

static DebugConsoleViewController *defaultController;
+ (DebugConsoleViewController *)defaultController {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultController = [[DebugConsoleViewController alloc] init];
    });
    return defaultController;
}

- (LogLevel)minimumLoggingLevel {
    return LogLevelWarning;
}

- (void)loadView {
    self.view = [[DebugConsoleView alloc] init];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

- (void)presentDebugConsole {
    [UIView animateWithDuration:0.2f animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0.0f, -kDebugConsoleHeight);
    }];
}

- (void)hideDebugConsole {
    [UIView animateWithDuration:0.2f animations:^{
        self.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.delegate debugConsoleDidHide];
    }];
}

- (void)addStringToConsoleLog:(NSString *)stringToAdd {
    NSString *logText = self.view.textField.text;
    logText = [logText stringByAppendingFormat:@"\n%@",stringToAdd];
    self.view.textField.text = logText;
}

@end

NSString *NSStringFromLogLevel(LogLevel severity) {
    switch (severity) {
        case LogLevelCritical:
            return @"Critical: ";
        case LogLevelDebug:
            return @"Debug: ";
        case LogLevelWarning:
            return @"Warning: ";
        default:
            [NSException raise:NSInternalInconsistencyException format:@"invalid enum value"];
            break;
    }
    return @"NoLevel: ";
}

void Log(LogLevel severity, NSString *format, ...) {
    DebugConsoleViewController *debugConsoleViewController = [DebugConsoleViewController defaultController];
    if (severity < debugConsoleViewController.minimumLoggingLevel)
        return;
    
    va_list fullArgumentList, runtimeArgumentList;
    va_start(fullArgumentList, format);
    va_copy(runtimeArgumentList, fullArgumentList);
    va_end(runtimeArgumentList);
    va_end(fullArgumentList);
    
    
    NSString *logString = NSStringFromLogLevel(severity);
    logString = [logString stringByAppendingString:[[NSString alloc] initWithFormat:format arguments:runtimeArgumentList]];
    
    NSLog(@"%@", logString);
    [debugConsoleViewController addStringToConsoleLog:logString];
}
