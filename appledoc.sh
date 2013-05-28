#!/bin/sh

appledoc --project-name 'BrynKit 1.2.5' \
         --project-company 'bryn austin bellomy' \
         -o ../appledoc \
         ./CocoaLumberjack/*.h ./DCSlider/*.h ./EDColor/*.h ./FontasticIcons/*.h ./GCDThreadsafe/*.h ./Main/*.h ./MBProgressHUD/*.h ./MemoryLogging/*.h ./MGBoxHelpers/*.h ./RACDispatchTimer/*.h ./RACHelpers/*.h ./RRFPSBar/*.h ./SEDispatchSource/*.h ./SEGradientSwatch/*.h 
