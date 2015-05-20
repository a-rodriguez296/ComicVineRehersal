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
    
    
    return [self GET:@"search" parameters:parameters class:[Volume class]];
}


-(RACSignal *) fetchVolumesWithQuery:(NSString *) query page:(NSUInteger) page{
    
    NSDictionary *parameters = @{
                                 @"api_key": APIKey,
                                 @"format": format,
                                 @"field_list": @"id,image,name,publisher",
                                 @"limit": @20,
                                 @"page": @(page),
                                 @"query": query,
                                 @"resources": @"volume"};
    
    return  [self GET:@"search" parameters:parameters class:Nil];;
}

-(RACSignal *) GET:(NSString *) path parameters:(NSDictionary *) parameters{
    
    @weakify(self);
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        @strongify(self);
        AFHTTPRequestOperation * operation = [self.requestManager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        
        //Esto se hace para manejar el caso en el que el subscriptor, en este caso el SuggestionsVC, deje de existir. Esto es una especie de 'removeObserver'
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
        
        //deliverOn se hace para que la respuesta de AFNetworking y todo el parseo del JSON se haga en background
    }] deliverOn:[RACScheduler scheduler]];
}

-(RACSignal *) GET:(NSString *) path parameters:(NSDictionary *) parameters class:(Class) class{
    
    return [[self GET:path parameters:parameters] map:^id(NSDictionary * jsonDictionary) {
        return [Response responseWithJSONDictionary:jsonDictionary resultClass:class];
    }];
}


@end
