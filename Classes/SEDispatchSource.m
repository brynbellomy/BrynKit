#import "SEDispatchSource.h"
#import "Bryn.h"

/**
 * # SEDispatchSource
 */

@implementation SEDispatchSource {
    BrynKitDispatchSourceState _state;
    dispatch_queue_t           _queue;
    dispatch_source_t          _source;
}

/**
 * #### initWithSource:onQueue:
 *
 * @param {dispatch_source_t} source
 * @param {dispatch_queue_t} queue
 */

- (instancetype) initWithSource: (dispatch_source_t)source
                        onQueue: (dispatch_queue_t)queue
{
    self = [super init];

    if (self) {
        _queue = queue;
        dispatch_retain(_queue);
        _state  = BrynKitDispatchSourceState_Canceled;
        _source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_OR, 0, 0, _queue);
    }

    return self;
}



/**
 * #### dealloc
 *
 * Automatically cancels the `dispatch_source_t` correctly upon `dealloc`-ing.
 */

- (void) dealloc
{
    // when cancelling, must make sure we resume first if we're suspended
    if (_state == BrynKitDispatchSourceState_Suspended) {
        dispatch_resume(_source);
    }

    dispatch_source_cancel(_source);
    dispatch_release(_source);
    _source = nil;

    dispatch_release(_queue);
    _queue = nil;

    _state = BrynKitDispatchSourceState_Canceled;
}



/**
 * #### state
 */

- (BrynKitDispatchSourceState) state
{
    BrynKitDispatchSourceState state;

    @synchronized(self) {
        state = _state;
    }
    return state;
}



/**
 * #### stop
 */

- (void) stop
{
    @synchronized(self) {
        if (_state == BrynKitDispatchSourceState_Resumed) {
            dispatch_suspend(_source);
            _state = BrynKitDispatchSourceState_Suspended;
        }
    }
}



/**
 * #### resume
 */

- (void) resume
{
    @synchronized(self) {
        if ((_state == BrynKitDispatchSourceState_Suspended) || (_state == BrynKitDispatchSourceState_Canceled)) {
            dispatch_resume(_source);
            _state = BrynKitDispatchSourceState_Resumed;
        }
    }
}



@end
