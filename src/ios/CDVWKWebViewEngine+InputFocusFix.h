#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebViewInputFocusFix : CDVPlugin<WKScriptMessageHandler, NSURLSessionDelegate>

- (void) keyboardDisplayDoesNotRequireUserAction;


@end

NS_ASSUME_NONNULL_END