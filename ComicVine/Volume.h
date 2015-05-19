//
//  Volume.h
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>

@interface Volume : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *title;

@end
