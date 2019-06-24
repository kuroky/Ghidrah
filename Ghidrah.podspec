
Pod::Spec.new do |spec|
  
  spec.name         = "Ghidrah"
  spec.version      = "0.0.1"
  spec.summary      = "魔兽基多拉"
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = <<-DESC
  哥斯拉(Project)的基础库集合
  DESC
  
  spec.homepage     = "http://www.emucoo.com"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "kuroky" => "kuroky@emucoo.com" }
  
  spec.platform     = :ios, "11.0"
  
  spec.source       = { :git => "ssh://git@192.168.16.172:7990/em/ghidrah.git", :tag => "#{spec.version}" }
  
  spec.source_files = "Classes/**/*.{h,m}"
  #spec.public_header_files = "Classes/Ghidrah.h"
  
  spec.subspec "Model" do |ss|
    ss.source_files = "Classes/Model/*.{h,m}"
    ss.dependency "YYModel", "1.0.4"
  end
  
  spec.subspec "HUD" do |ss|
    ss.source_files = "Classes/HUD/*.{h,m}"
    ss.dependency "MBProgressHUD", "1.1.0"
  end
  
  spec.subspec "Category" do |ss|
    ss.source_files = "Classes/Category/*.{h,m}"
  end
  
  spec.subspec "Tool" do |ss|
    ss.source_files = "Classes/Tool/*.{h,m}"
    ss.dependency "CocoaLumberjack", "3.5.3"
  end
  
  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  spec.dependency "GHNetwork",  "1.0.0"
  spec.dependency "Masonry", "1.1.0"
  spec.dependency "IQKeyboardManager", "6.3.0"
  
end
