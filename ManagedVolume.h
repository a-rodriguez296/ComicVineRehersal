#import "_ManagedVolume.h"

@interface ManagedVolume : _ManagedVolume {}

+(NSFetchRequest *) fetchRequestForAllVolumes;
+(void) deleteAllVolumesInManagedContext:(NSManagedObjectContext *) context;


@end
