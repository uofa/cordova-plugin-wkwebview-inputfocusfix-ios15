#import <objc/runtime.h>
#import "CDVWKWebViewEngine+InputFocusFix.h"
#import <Cordova/CDV.h>

NS_ASSUME_NONNULL_BEGIN

@implementation WKWebViewInputFocusFix

-(void) pluginInitialize {
    [super pluginInitialize];
    
    if (![self.webView isKindOfClass:WKWebView.class])
        return;

    //WKWebView *wkWebView = (WKWebView *) self.webView;
    
    [self keyboardDisplayDoesNotRequireUserAction];
}

// https://github.com/Telerik-Verified-Plugins/WKWebView/commit/04e8296adeb61f289f9c698045c19b62d080c7e3
// https://stackoverflow.com/a/48623286/3297914
- (void) keyboardDisplayDoesNotRequireUserAction {
    Class class = NSClassFromString(@"WKContentView");
    NSOperatingSystemVersion iOS_11_3_0 = (NSOperatingSystemVersion){11, 3, 0};
    NSOperatingSystemVersion iOS_12_2_0 = (NSOperatingSystemVersion){12, 2, 0};
    NSOperatingSystemVersion iOS_13_0_0 = (NSOperatingSystemVersion){13, 0, 0};
    NSOperatingSystemVersion iOS_14_0_0 = (NSOperatingSystemVersion){14, 0, 0};
    NSOperatingSystemVersion iOS_15_0_0 = (NSOperatingSystemVersion){15, 0, 0};
    NSOperatingSystemVersion iOS_16_0_0 = (NSOperatingSystemVersion){16, 0, 0};

    char* methodSignature = "_startAssistingNode:userIsInteracting:blurPreviousNode:changingActivityState:userObject:";

    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion: iOS_12_2_0]) {
        methodSignature = "_elementDidFocus:userIsInteracting:blurPreviousNode:changingActivityState:userObject:";
    }

    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion: iOS_13_0_0]) {
        methodSignature = "_elementDidFocus:userIsInteracting:blurPreviousNode:activityStateChanges:userObject:";
    }
    
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion: iOS_14_0_0]) {
        methodSignature = "_elementDidFocus:userIsInteracting:blurPreviousNode:activityStateChanges:userObject:";
    }
    
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion: iOS_15_0_0]) {
        methodSignature = "_elementDidFocus:userIsInteracting:blurPreviousNode:activityStateChanges:userObject:";
    }
     if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion: iOS_16_0_0]) {
        methodSignature = "_elementDidFocus:userIsInteracting:blurPreviousNode:activityStateChanges:userObject:";
    }
    
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion: iOS_11_3_0]) {
        SEL selector = sel_getUid(methodSignature);
        Method method = class_getInstanceMethod(class, selector);
        IMP original = method_getImplementation(method);
        IMP override = imp_implementationWithBlock(^void(id me, void* arg0, BOOL arg1, BOOL arg2, BOOL arg3, id arg4) {
            ((void (*)(id, SEL, void*, BOOL, BOOL, BOOL, id))original)(me, selector, arg0, TRUE, arg2, arg3, arg4);
        });
        method_setImplementation(method, override);
    } else {
        SEL selector = sel_getUid("_startAssistingNode:userIsInteracting:blurPreviousNode:userObject:");
        Method method = class_getInstanceMethod(class, selector);
        IMP original = method_getImplementation(method);
        IMP override = imp_implementationWithBlock(^void(id me, void* arg0, BOOL arg1, BOOL arg2, id arg3) {
            ((void (*)(id, SEL, void*, BOOL, BOOL, id))original)(me, selector, arg0, TRUE, arg2, arg3);
        });
        method_setImplementation(method, override);
    }
}

@end

NS_ASSUME_NONNULL_END
