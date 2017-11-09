//
//  PullListModel.h
//  PullListView
//
//  Created by fns on 2017/11/9.
//  Copyright © 2017年 lsh726. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PullListModel : NSObject
@property (nonatomic, strong, nullable) NSString *name;//标题字段
@property (nonatomic, strong, nullable) NSString *extension;//扩展字段（如id之类的）

- (instancetype)initWithName:(NSString *)name extension:(NSString *)extension;
@end
