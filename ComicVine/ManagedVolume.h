#import "_ManagedVolume.h"

@interface ManagedVolume : _ManagedVolume {}


+(void) deleteAllVolumesInManagedObjectContext:(NSManagedObjectContext *) context;


@end
