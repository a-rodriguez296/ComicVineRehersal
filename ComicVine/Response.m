//
//  Response.m
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "Response.h"

@interface Response ()

@property (nonatomic, strong) id results;

@end


@implementation Response

+(instancetype) responseWithJSONDictionary:(NSDictionary *) dictionary resultClass:(Class) resultsClass{
    
    Response *response = [MTLJSONAdapter modelOfClass:self fromJSONDictionary:dictionary error:NULL];

    id results = dictionary[@"results"];
    if (resultsClass != Nil) {
        if ([results isKindOfClass:[NSArray class]]) {
            response.results = [MTLJSONAdapter modelOfClass:resultsClass fromJSONDictionary:results error:NULL];
        }
        else{
            response.results = [MTLJSONAdapter modelsOfClass:resultsClass fromJSONArray:results error:NULL];
        }
    }
    
    response.results = results;
    return response;
}





+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"statusCode":@"status_code",
             @"errorMessage":@"error",
             @"numberOfTotalResults":@"number_of_total_results",
             @"offset":@"offset"};
}

@end
