
#import <Kiwi/Kiwi.h>
#import "RACHelpers.h"
#import "RACTransformableBinding.h"



SPEC_BEGIN(RACTransformableBindingSpec)

context(@"", ^{

    it(@"", ^{

//        RACTransformableBinding *binding_switch   = [RACTransformableBinding bindingWithTarget: self
//                                                                                       keyPath: @keypath(self.switch_mute.on)
//                                                                                     transform: ^NSNumber* (NSNumber *numOn) {
//                                                                                         NSNumber *inverted = @( numOn.boolValue ? NO : YES );
//                                                                                         lllog(Error, @"transform [switch_mute.on] // in = %@ / out = %@ //", numOn, inverted);
//                                                                                         return inverted;
//                                                                                     }];
//        RACTransformableBinding *binding_property = [RACTransformableBinding bindingWithTarget: self
//                                                                                       keyPath: @keypath(self.isMuted)
//                                                                                     transform:^NSNumber* (NSNumber* numIsMuted) {
//                                                                                         NSNumber *inverted = @( numIsMuted.boolValue ? NO : YES );
//                                                                                         lllog(Error, @"transform [isMuted] // in = %@ / out = %@ //", numIsMuted, inverted);
//                                                                                         return inverted;
//                                                                                     }];
//
//        RACDispatchTimer *timer = [RACDispatchTimer timerWithIntervalInNanoseconds: 5.0f * NSEC_PER_SEC
//                                                                            leeway: 0.01f * NSEC_PER_SEC];
//        [[timer onMainThreadScheduler] subscribeNext:^(id _) {
//            @strongify(self);
//            BOOL new = ! self.isMuted;
//            lllog(Success, @"auto-changing self.isMuted from %@ to %@", @(self.isMuted), @(new));
//            self.isMuted = new;
//        }];
//        [timer resume];
//
//
//        RACDispatchTimer *timer2 = [RACDispatchTimer timerWithIntervalInNanoseconds: 3.0f * NSEC_PER_SEC
//                                                                            leeway: 0.01f * NSEC_PER_SEC];
//        [[timer2 onMainThreadScheduler] subscribeNext:^(id _) {
//            @strongify(self);
//            BOOL new = ! self.switch_mute.on;
//            lllog(Success, @"auto-changing self.switch_mute.on from %@ to %@", @(self.switch_mute.on), @(new));
//            self.switch_mute.on = new;
//        }];
//        [timer2 resume];
//
//        RACDispatchTimer *timer3 = [RACDispatchTimer timerWithIntervalInNanoseconds: 1.1f * NSEC_PER_SEC
//                                                                            leeway: 0.01f * NSEC_PER_SEC];
//        srand(time(0)); //use current time as seed for random generator
//
//        [[timer3 onMainThreadScheduler] subscribeNext:^(id _) {
//            int random = rand();
//            lllog(Success, COLOR_PURPLE(@"random generated value ===== %@"), @(random));
//
//            Float32 randomNormalized = (Float32)random / (Float32)RAND_MAX;
//            lllog(Success, COLOR_PURPLE(@"auto-changing self.switch_mute.percentOn from %@ to %@"), @(self.switch_mute.percentOn), @(randomNormalized));
//
//            self.switch_mute.percentOn = randomNormalized;
//        }];
//        [timer3 resume];
//
//
//
//        [binding_switch bindTo: binding_property];
//        [binding_property bindTo: binding_switch];
    });
    
});

SPEC_END