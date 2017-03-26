Pod::Spec.new do |s|

  s.name         = "SwiftCake"
  s.version      = "0.1.5"
  s.summary      = "Complex library of various views, components and utils I use across apps"

  s.homepage     = "https://github.com/Rovalx/SwiftCake"
  s.license      = "MIT"

  s.author             = { "Dominik Majda" => "ddmajda@gmail.com" }

  s.platform     = :ios
  s.ios.deployment_target = "9.0"


  s.source = { :git => "https://github.com/Rovalx/SwiftCake.git", :tag => "#{s.version}"}
  s.source_files  = "SwiftCake/**/*.{h,m,swift}"

  s.framework  = "UIKit"

end
