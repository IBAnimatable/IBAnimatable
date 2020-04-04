Pod::Spec.new do |s|
  s.name         = "IBAnimatable"
  s.version      = "6.1.0"
  s.summary      = "Design and prototype UI, interaction, navigation, transition and animation for App Store ready Apps in Interface Builder with IBAnimatable."
  s.homepage     = "https://github.com/IBAnimatable/IBAnimatable"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "IBAnimatable" => "JakeLinAu@gmail.com" }
  s.platform     = :ios, '9.0'
  s.source       = { :git => "https://github.com/IBAnimatable/IBAnimatable.git", tag: "#{s.version}" }
  s.source_files = "Sources/**/*.swift"
end
