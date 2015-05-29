//
//  Response.m
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/22/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "Response.h"
#import "Volume.h"

@interface Response ()

@property (nonatomic, strong) id results;

@end

@implementation Response


+(instancetype) responseWithJSONDictionary:(NSDictionary *) JSONDictionary resultClass:(Class) resultsClass{
    
    Response *response = [MTLJSONAdapter modelOfClass:self fromJSONDictionary:JSONDictionary error:NULL];
    
    id results = JSONDictionary[@"results"];
    if (resultsClass != Nil) {
        if ([results isKindOfClass:[NSArray class]]) {
            response.results = [MTLJSONAdapter modelsOfClass:resultsClass fromJSONArray:results error:NULL];
        }
        else{
            response.results = [MTLJSONAdapter modelOfClass:resultsClass fromJSONDictionary:results error:NULL];
        }
    }
    else{
        response.results = results;
    }

    
    return response;
}

-(NSError *) error{
    
    if (self.statusCode.integerValue == 1) {
        return nil;
    }
    
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey : self.errorMessage};
    return [NSError errorWithDomain:@"ComicVineErrorDomain" code:self.statusCode.integerValue userInfo:userInfo];
}

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    
    return @{@"statusCode": @"status_code",
             @"errorMessage": @"error",
             @"numberOfTotalResults":@"number_of_total_results",
             @"offset": @"offset"};
}

@end
