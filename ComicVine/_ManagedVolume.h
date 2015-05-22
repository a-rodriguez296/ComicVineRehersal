// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ManagedVolume.h instead.

@import CoreData;

extern const struct ManagedVolumeAttributes {
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *imageURL;
	__unsafe_unretained NSString *insertionDate;
	__unsafe_unretained NSString *publisher;
	__unsafe_unretained NSString *title;
} ManagedVolumeAttributes;

@interface ManagedVolumeID : NSManagedObjectID {}
@end

@interface _ManagedVolume : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ManagedVolumeID* objectID;

@property (nonatomic, strong) NSNumber* identifier;

@property (atomic) int64_t identifierValue;
- (int64_t)identifierValue;
- (void)setIdentifierValue:(int64_t)value_;

//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* imageURL;

//- (BOOL)validateImageURL:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* insertionDate;

//- (BOOL)validateInsertionDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* publisher;

//- (BOOL)validatePublisher:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@end

@interface _ManagedVolume (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (int64_t)primitiveIdentifierValue;
- (void)setPrimitiveIdentifierValue:(int64_t)value_;

- (NSString*)primitiveImageURL;
- (void)setPrimitiveImageURL:(NSString*)value;

- (NSDate*)primitiveInsertionDate;
- (void)setPrimitiveInsertionDate:(NSDate*)value;

- (NSString*)primitivePublisher;
- (void)setPrimitivePublisher:(NSString*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

@end
