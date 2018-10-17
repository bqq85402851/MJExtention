//
//  Person.h
//  MJExtention
//
//  Created by mac on 2018/10/17.
//  Copyright © 2018年 毕小强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Student;
@interface Person : NSObject
@property (assign, nonatomic) int intValue;
@property (assign,nonatomic) float floatValue;
@property (copy,nonatomic) NSString *stringValue;
@property (strong,nonatomic) NSNumber *numValue;
@property (strong,nonatomic) NSArray *arrValue;
@property (strong,nonatomic) NSDictionary *dicValue;
@property (strong,nonatomic) NSMutableDictionary *mutableDicValue;
@property (strong,nonatomic) Student *student;
@property (strong,nonatomic) NSArray *mans;
@end

@interface Student : NSObject
@property(copy,nonatomic)NSString *age;
@end
