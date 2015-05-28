#import "_ManagedVolume.h"

@interface ManagedVolume : _ManagedVolume {}

+(void) deleteAllVolumesInManagedContext:(NSManagedObjectContext *) context;


@end
