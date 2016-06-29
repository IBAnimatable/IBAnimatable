Pod::Spec.new do |s|
  s.name         = "IBAnimatable"
  s.version      = "2.4"
  s.summary      = "Design and prototype UI, interaction, navigation, transition and animation for App Store ready Apps in Interface Builder with IBAnimatable."
  s.homepage     = "https://github.com/JakeLin/IBAnimatable"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Jake Lin" => "JakeLinAu@gmail.com" }
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/JakeLin/IBAnimatable.git", tag: "#{s.version}" }
  s.source_files = "IBAnimatable/*.swift"
end
