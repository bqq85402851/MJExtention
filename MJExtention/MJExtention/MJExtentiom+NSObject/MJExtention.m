//
//  NSObject+MJExtention.m
//  MJExtention
//
//  Created by mac on 2018/10/17.
//  Copyright © 2018年 毕小强. All rights reserved.
//

#import "MJExtention.h"
#import "objc/runtime.h"

static NSString *arrKey = @"arrKey";

@implementation NSObject (MJExtention)
-(id)mj_objectWithValue:(id)value{
    
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i=0; i<outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSString *propertyAttribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        NSLog(@"名称:%@ 类型:%@\n",propertyName,propertyAttribute);
        
        if([value objectForKey:propertyName] == nil) continue;
        
        NSLog(@"值：%@",[value objectForKey:propertyName]);
        if ([propertyAttribute containsString:@"T@"]) {
            //对象
            if ([propertyAttribute containsString:NSStringFromClass(NSNumber.class)]) {
                //数字
                [self setValue:[value objectForKey:propertyName] forKey:propertyName];
            }else if ([propertyAttribute containsString:NSStringFromClass(NSString.class)]){
                //字符串
                [self setValue:[value objectForKey:propertyName] forKey:propertyName];
            } else if ([propertyAttribute containsString:NSStringFromClass(NSArray.class)]||[propertyAttribute containsString:NSStringFromClass(NSMutableArray.class)]) {
                //数组
                NSString *className = [self.arrayKeyWithValue objectForKey:propertyName];
                if (className.length==0) {
                    continue;
                }
                NSArray *arr = [value objectForKey:propertyName];
                NSMutableArray *marr = [NSMutableArray array];
                for (id obj in arr) {
                    Class class = NSClassFromString(className);
                    id instance = [[class alloc] init];
                    [instance performSelector:@selector(mj_objectWithValue:) withObject:obj];
                    [marr addObject:instance];
                }
                [self setValue:[NSArray arrayWithArray:marr] forKey:propertyName];
            }else{
                //数据模型
                NSString *className = [propertyAttribute componentsSeparatedByString:@","].firstObject;
                className = [className stringByReplacingOccurrencesOfString:@"T" withString:@""];
                className = [className stringByReplacingOccurrencesOfString:@"@" withString:@""];
                className = [className stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                if (className.length==0) {
                    continue;
                }
                
                Class class = NSClassFromString(className);
                id instance = [[class alloc] init];
                [instance performSelector:@selector(mj_objectWithValue:) withObject:[value objectForKey:propertyName]];
                [self setValue:instance forKey:propertyName];
            }
        }else{
            //基本数据
            [self setValue:[value objectForKey:propertyName] forKey:propertyName];
        }
    }
    return self;
}

-(void)setArrayKeyWithValue:(NSDictionary *)arrayKeyWithValue{
    objc_setAssociatedObject(self, &arrKey, arrayKeyWithValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSDictionary*)arrayKeyWithValue{
    return objc_getAssociatedObject(self, &arrKey);
}
@end
