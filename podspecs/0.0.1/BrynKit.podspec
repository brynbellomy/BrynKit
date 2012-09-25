Pod::Spec.new do |s|
  s.name         = "BrynKit"
  s.version      = "0.0.1"
  s.source       = { :git => "https://github.com/brynbellomy/BrynKit.git" }
  s.source_files = '*.{h,m}'
  s.requires_arc = true
  s.xcconfig = { 'PUBLIC_HEADERS_FOLDER_PATH' => 'include/$(TARGET_NAME)' }
  s.prefix_header_contents = "#ifndef BRYNKIT_MB_PROGRESS_HUD_INCLUDED\n#define BRYNKIT_MB_PROGRESS_HUD_INCLUDED 0\n#endif\n#import <BrynKit/BrynKit.h>"
  s.preferred_dependency = 'main'
end
