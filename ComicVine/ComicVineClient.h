//
//  ComicVineClient.h
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/18/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  RACSignal;

@interface ComicVineClient : NSObject

-(RACSignal *) fetchSuggestedVolumeswithQuery:(NSString *) query;
-(RACSignal *) fetchVolumesWithQuery:(NSString *) query page:(NSUInteger) page;
@end
