Pod::Spec.new do |s|
  s.name         = "BrynKit"
  s.version      = "0.0.1"
  # s.summary      = "A short description of BrynKit."
  # s.homepage     = "http://github.com/brynbellomy/BrynKit"

  # s.author       = { "Bryn Austin Bellomy" => "bryn@signals.io" }
  s.source       = { :git => "/Users/bryn/repo/BrynKit.git" }
  # s.platform     = :ios, '4.3'
  s.source_files = '*.{h,m}'

  s.requires_arc = true

  s.xcconfig = { 'PUBLIC_HEADERS_FOLDER_PATH' => 'include/$(TARGET_NAME)' }



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
