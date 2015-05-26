//
//  Volume.h
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/22/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Volume : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *title;

@end
