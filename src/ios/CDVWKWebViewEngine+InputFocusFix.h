#import <objc/runtime.h>
#import <Cordova/NSDictionary+CordovaPreferences.h>
#import "CDVWebViewEngine.h"

@interface CDVWebViewEngine (InputFocusFix)
+ (void) load;
- (void) swizzleWKContentViewForInputFocus;
- (void) keyboardDisplayDoesNotRequireUserAction;
@end
