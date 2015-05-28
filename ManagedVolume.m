#import "ManagedVolume.h"

@interface ManagedVolume ()

// Private interface goes here.

@end

@implementation ManagedVolume

-(void)awakeFromInsert{
    [super awakeFromInsert];
    
    self.insertionDate = [NSDate date];
}

+(NSFetchRequest *) fetchRequestForAllVolumes{
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:[ManagedVolume entityName]];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:ManagedVolumeAttributes.insertionDate ascending:YES];
    [fr setSortDescriptors:@[sortDescriptor]];
    [fr setFetchBatchSize:20];
    return fr;
}


+(void) deleteAllVolumesInManagedContext:(NSManagedObjectContext *) context{
    
    NSFetchRequest *fr = [self fetchRequestForAllVolumes];
    [fr setIncludesPropertyValues:NO];
    
    NSArray *volumes = [context executeFetchRequest:fr error:NULL];
    
    for (NSManagedObject *object in volumes) {
        [context deleteObject:object];
    }
}

@end
