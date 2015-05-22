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
    [fr setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ManagedVolumeAttributes.insertionDate ascending:YES]]];
    [fr setFetchBatchSize:20];
    return fr;
}

+(void) deleteAllVolumesInManagedObjectContext:(NSManagedObjectContext *) context{
    NSFetchRequest *fr = [self fetchRequestForAllVolumes];
    
    //Esto se hace para que los atributos de la clase vengan en fault
    [fr setIncludesPropertyValues:NO];
    
    NSArray *volumes = [context executeFetchRequest:fr error:NULL];
    for (ManagedVolume *volume in volumes) {
        [context deleteObject:volume];
    }
}


@end
