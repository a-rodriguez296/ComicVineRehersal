//
//  Response.h
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Response : MTLModel<MTLJSONSerializing>



@property (nonatomic, copy, readonly) NSNumber  *statusCode;

@property (nonatomic, copy, readonly) NSString  *errorMessage;

@property (copy, nonatomic, readonly) NSNumber *numberOfTotalResults;

@property (nonatomic, copy, readonly) NSNumber  *offset;

@property (nonatomic, strong, readonly) id results;


+(instancetype) responseWithJSONDictionary:(NSDictionary *) dictionary resultClass:(Class) resultsClass;

@end
