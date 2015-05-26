//
//  ComicVineClient.m
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/22/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ComicVineClient.h"
#import "Response.h"
#import "Volume.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <AFNetworking/AFNetworking.h>

@interface ComicVineClient ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;

@end


static NSString *const APIKey = @"75d580a0593b7320727309feb6309f62def786cd";
static NSString *const format = @"json";


@implementation ComicVineClient


- (instancetype)init
{
    self = [super init];
    if (self) {
        _requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://comicvine.com/api"]];
    }
    return self;
}

#pragma  mark Public
-(RACSignal *) fetchSuggestedVolumesWithQuery:(NSString *) query{
    
    NSDictionary *parameters = @{@"api_key":APIKey,
                                 @"format": format,
                                 @"field_list":@"name",
                                 @"limit":@10,
                                 @"page":@1,
                                 @"query":query,
                                 @"resources":@"volume"};
    
    
    
    return [self GET:@"search" parameters:parameters class:[Volume class]];
}



#pragma mark Private




-(RACSignal *) GET:(NSString *) path parameters:(NSDictionary *) parameters class:(Class) resultClass{
    return [[self GET:path parameters:parameters] map:^id(NSDictionary * JSONDictionary) {
        
       Response * res = [Response responseWithJSONDictionary:JSONDictionary resultClass:resultClass];
        return res;
    }];
}


-(RACSignal *) GET:(NSString *) path parameters:(NSDictionary *)parameters{
    
    return  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        AFHTTPRequestOperation *operation = [self.requestManager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
        
    }];
}
@end
