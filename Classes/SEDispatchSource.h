

#import "Bryn.h"

@interface SEDispatchSource : NSObject

@property (atomic, assign, readonly) dispatch_source_t          source;
@property (atomic, assign, readonly) dispatch_queue_t           queue;
@property (atomic, assign, readonly) BrynKitDispatchSourceState state;

- (instancetype) initWithSource:(dispatch_source_t)source onQueue:(dispatch_queue_t)queue;
- (void) stop;
- (void) resume;

@end