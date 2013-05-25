//
//  BrynKitMemoryLogging.h
//  BrynKit
//
//  Created by bryn austin bellomy on 2/27/2013
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import "SEDispatchSource.h"

typedef void(^MemoryLogDispatchBlock)(natural_t freeMemBytes);

extern natural_t         BrynKit_GetFreeMemory();
extern SEDispatchSource* BrynKit_StartOccasionalMemoryLog(Float32 intervalInSeconds, MemoryLogDispatchBlock dispatchTheLog);

