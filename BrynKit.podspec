#
# BrynKit
# CocoaPods podspec
#

Pod::Spec.new do |s|
  s.platform     = :ios, '5.1'
  s.name         = 'BrynKit'
  s.version      = '1.2.1'
  s.author       = { 'bryn austin bellomy' => 'bryn.bellomy@gmail.com' }
  s.summary      = 'Macros and helpers for logging, debugging, and metaprogramming.'
  s.homepage     = 'http://brynbellomy.github.com/BrynKit'
  s.license      = { :type => 'WTFPL', :file => 'LICENSE.md' }

  s.source       = { :git => 'https://github.com/brynbellomy/BrynKit.git', :tag => "v#{s.version.to_s}" }
  s.requires_arc = true
  s.xcconfig = { 'PUBLIC_HEADERS_FOLDER_PATH' => 'include/$(TARGET_NAME)' }

  s.dependency 'libextobjc/EXTScope', '>= 0.2.5'

  #
  # main subspec
  #
  s.preferred_dependency = 'Main'
  s.subspec 'Main' do |subspec|
    subspec.source_files = 'Classes/{Bryn.{h,m},BrynKit.h,BrynKitDebugging.h,BrynKitLogging.h}'
  end

  #
  # subspecs
  #
  s.subspec 'MBProgressHUD' do |subspec|
    subspec.source_files = 'Classes/BrynKitMBProgressHUD.{h,m}'
    subspec.dependency 'MBProgressHUD'
  end

  s.subspec 'RACHelpers' do |subspec|
    subspec.source_files = 'Classes/RAC*.{m,h}'
  end

  s.subspec 'GCDThreadsafe' do |subspec|
    subspec.source_files = 'Classes/GCDThreadsafe.{h,m}'
  end

  s.subspec 'SEDispatchSource' do |subspec|
    subspec.source_files = 'Classes/SEDispatchSource.{h,m}'
  end

  s.subspec 'MemoryLogging' do |subspec|
    subspec.source_files = 'Classes/BrynKitMemoryLogging.{h,m}'
  end

  s.subspec 'EDColor' do |subspec|
    subspec.source_files = 'Classes/BrynKitEDColor.h'
    subspec.dependency 'EDColor'
  end

  s.subspec 'CocoaLumberjack' do |subspec|
    subspec.source_files = 'Classes/{BrynKitCocoaLumberjack.h,BrynKitDDLogColorFormatter.{m,h}}'
    subspec.dependency 'CocoaLumberjack'
  end

  s.subspec 'RRFPSBar' do |subspec|
    subspec.source_files = 'Classes/RRFPSBar/*.{h,m}'
  end
end





