//
//  ComicVineClient.m
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/18/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ComicVineClient.h"
#import "Response.h"
#import "Volume.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <AFNetworking/AFNetworking.h>


static NSString *const APIKey = @"75d580a0593b7320727309feb6309f62def786cd";
static NSString *const format = @"json";

@interface ComicVineClient ()

@property(nonatomic, strong) AFHTTPRequestOperationManager * requestManager;

@end

@implementation ComicVineClient



- (instancetype)init
{
    if (self == [super init]) {
        _requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.comicvine.com/api"]];
    }
    return self;
}

-(RACSignal *) fetchSuggestedVolumeswithQuery:(NSString *) query{
    
    NSDictionary *parameters = @{@"api_key":APIKey,
                                 @"format": format,
                                 @"field_list":@"name",
                                 @"limit":@10,
                                 @"page":@1,
                                 @"query":query,
                                 @"resources":@"volume"};
    
    
    return [self GET:@"search" parameters:parameters];
}


-(RACSignal *) GET:(NSString *) path parameters:(NSDictionary *) parameters{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        AFHTTPRequestOperation * operation = [self.requestManager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [subscriber sendNext:[Response responseWithJSONDictionary:responseObject resultClass:[Volume class]]];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        
        //Esto se hace para manejar el caso en el que el subscriptor, en este caso el SuggestionsVC, deje de existir. Esto es una especie de 'removeObserver'
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }];
    
}

@end
