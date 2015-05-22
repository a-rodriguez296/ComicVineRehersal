//
//  Volume.m
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/22/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "Volume.h"

@implementation Volume


#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"title":@"name"};
}

@end
