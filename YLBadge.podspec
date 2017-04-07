Pod::Spec.new do |s|
s.name = 'YLBadge'
s.version = '1.0.0'
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.summary = 'A delightful library for iOS to show a badge on UIView, UIBarButtonItem and UITabBarItem.'
s.homepage = 'https://github.com/ypli-chn/YLBadge'
s.authors = { "Yunpeng Li" => "ypli.chn@outlook.com" }
s.source = { :git => 'https://github.com/ypli-chn/YLBadge.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = 'YLBadge/*.{h,m}'
end