Pod::Spec.new do |s|
  s.name         = "IBAnimatable"
  s.version      = "2.7"
  s.summary      = "Design and prototype UI, interaction, navigation, transition and animation for App Store ready Apps in Interface Builder with IBAnimatable."
  s.homepage     = "https://github.com/IBAnimatable/IBAnimatable"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Jake Lin" => "JakeLinAu@gmail.com" }
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/IBAnimatable/IBAnimatable.git", tag: "#{s.version}" }
  s.source_files = "IBAnimatable/*.swift"
end
