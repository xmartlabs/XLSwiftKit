Pod::Spec.new do |s|
  s.name = 'XLSwiftKit'
  s.version = '3.0.0'
  s.license = 'MIT'
  s.summary = 'Helpers and Extensions for Swift'
  s.homepage = 'https://github.com/xmartlabs/XLSwiftKit'
  s.social_media_url = 'http://twitter.com/xmartlabs'
  s.authors =  { "xmartlabs" => "getintouch@xmartlabs.com" }
  s.source = { :git => 'https://github.com/xmartlabs/XLSwiftKit.git', :tag => s.version }
  s.ios.deployment_target = '9.2'
  s.ios.frameworks = 'UIKit', 'Foundation'
  s.source_files = 'Sources/**/*.{h,m,swift}'
  s.requires_arc = true
end
