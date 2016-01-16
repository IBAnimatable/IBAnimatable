Pod::Spec.new do |s|
  s.name         = "IBAnimatable"
  s.version      = "1.0.1"
  s.summary      = "Design and prototype UI, interaction, navigation, transition and animation for App Store ready Apps in Interface Builder with IBAnimatable."
  s.homepage     = "https://github.com/JakeLin/IBAnimatable"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Jake Lin" => "JakeLinAu@gmail.com" }
  s.platform     = :ios, '9.0'
  s.source       = { :git => "https://github.com/JakeLin/IBAnimatable.git", tag: "V#{s.version}" }
  s.source_files  = "IBAnimatable/*.swift"
end
