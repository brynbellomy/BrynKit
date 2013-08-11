#!/bin/sh

appledoc --project-name 'BrynKit 1.2.7' \
         --project-company 'bryn austin bellomy' \
         --company-id 'com.signalenvelope' \
         -o ../appledoc \
         --include ./Main/Bryn.h \
         --ignore .m \
         --keep-merged-sections \
         --keep-undocumented-objects \
         --keep-undocumented-members \
         --search-undocumented-doc \
         ./**/*.h
         #./CocoaLumberjack/*.h ./DCSlider/*.h ./EDColor/*.h ./FontasticIcons/*.h ./GCDThreadsafe/*.h ./Main/*.h ./MBProgressHUD/*.h ./MemoryLogging/*.h ./MGBoxHelpers/*.h ./RACDispatchTimer/*.h ./RACHelpers/*.h ./RRFPSBar/*.h ./SEDispatchSource/*.h ./SEGradientSwatch/*.h UIColor/*.h
