//
//  NSKeyedUnarchiver+Animatable.m
//  IBAnimatableApp
//
//  Created by Lex on 1/21/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@implementation NSKeyedUnarchiver (IBAnimatable)

- (void)mysetValue:(id)value forUndefinedKey:(NSString *)key {
  if ([key isEqualToString:@"animationType"]) {
    [self setValue:value forKey:@"animationTypeRaw"];
  }
}

+ (void) load
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    SEL origM = @selector( setValue:forUndefinedKey: );
    SEL newM = @selector( mysetValue:forUndefinedKey: );
    method_exchangeImplementations(
                                   class_getInstanceMethod( self, origM ),
                                   class_getInstanceMethod( self, newM )
                                   );
  });
}

@end