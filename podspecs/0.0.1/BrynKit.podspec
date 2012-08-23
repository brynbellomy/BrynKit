Pod::Spec.new do |s|
  s.name         = "BrynKit"
  s.version      = "0.0.1"
  s.source       = { :git => "https://github.com/brynbellomy/Bryn.h-iOS.git" }
  s.source_files = '*.{h,m}'
  s.requires_arc = true
  s.xcconfig = { 'PUBLIC_HEADERS_FOLDER_PATH' => 'include/$(TARGET_NAME)' }
  s.prefix_header_contents = "#import <BrynKit/Bryn.h>"
  s.preferred_dependency = 'main'

  s.subspec 'main' do |c|
  end

  s.subspec 'contracts' do |c|
    c.dependency 'ObjC-DesignByContract', '>= 0.0.1'
    # c.source_files   = ''
    # c.compiler_flags = '-Wno-incomplete-implementation -Wno-protocol -Wno-missing-prototypes'
  end

  s.subspec 'objc-runtime' do |c|
    c.dependency 'MAObjCRuntime', '>= 0.0.1'
  end

  s.subspec 'underscore' do |c|
    c.dependency 'Underscore.m', '>= 0.1.0'
  end

  s.subspec 'concise' do |c|
    c.dependency 'ConciseKit', '>= 0.1.2'
  end

end
