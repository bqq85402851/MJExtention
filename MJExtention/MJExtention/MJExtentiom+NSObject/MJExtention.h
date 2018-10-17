//
//  NSObject+MJExtention.h
//  MJExtention
//
//  Created by mac on 2018/10/17.
//  Copyright © 2018年 毕小强. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MJExtention)
/**
 自动解析

 @param value json数据
 @return 数据模型
 */
-(id)mj_objectWithValue:(id)value;

@property(nonatomic,strong)NSDictionary *arrayKeyWithValue;
@end

NS_ASSUME_NONNULL_END
