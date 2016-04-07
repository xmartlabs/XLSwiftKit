//
//  UIBarButtonItem+Swift.m
//  Estate


#import "UINavigationBar+Swift.h"

@implementation UINavigationBar (Swift)

+ (instancetype)swiftAppearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass
{
    return [self appearanceWhenContainedInInstancesOfClasses:@[containerClass]];
}

@end
