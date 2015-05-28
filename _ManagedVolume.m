// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ManagedVolume.m instead.

#import "_ManagedVolume.h"

const struct ManagedVolumeAttributes ManagedVolumeAttributes = {
	.identifier = @"identifier",
	.imageURL = @"imageURL",
	.insertionDate = @"insertionDate",
	.publisher = @"publisher",
	.title = @"title",
};

@implementation ManagedVolumeID
@end

@implementation _ManagedVolume

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ManagedVolume" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ManagedVolume";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ManagedVolume" inManagedObjectContext:moc_];
}

- (ManagedVolumeID*)objectID {
	return (ManagedVolumeID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"identifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"identifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic identifier;

- (int64_t)identifierValue {
	NSNumber *result = [self identifier];
	return [result longLongValue];
}

- (void)setIdentifierValue:(int64_t)value_ {
	[self setIdentifier:@(value_)];
}

- (int64_t)primitiveIdentifierValue {
	NSNumber *result = [self primitiveIdentifier];
	return [result longLongValue];
}

- (void)setPrimitiveIdentifierValue:(int64_t)value_ {
	[self setPrimitiveIdentifier:@(value_)];
}

@dynamic imageURL;

@dynamic insertionDate;

@dynamic publisher;

@dynamic title;

@end

