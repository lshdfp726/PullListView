//
//  PullListModel.m
//  PullListView
//
//  Created by fns on 2017/11/9.
//  Copyright © 2017年 lsh726. All rights reserved.
//

#import "PullListModel.h"

@implementation PullListModel
- (instancetype)initWithName:(NSString *)name extension:(NSString *)extension {
    self = [super init];
    if (self) {
        _name = name;
        _extension = extension;
    }
    return self;
}
@end
