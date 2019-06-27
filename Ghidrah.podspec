
Pod::Spec.new do |spec|
  
  spec.name         = "Ghidrah"
  spec.version      = "1.0.0"
  spec.summary      = "项目框架基础"
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = <<-DESC
                  基础库集合
                    DESC
  
  spec.homepage     = "https://github.com/kuroky"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "kuroky" => "kuro2007cumt@gmail.com" }
  
  spec.platform     = :ios, "11.0"
  
  spec.source       = { :git => "ssh://https://github.com/kuroky/Ghidrah.git", :tag => "#{spec.version}" }
  
  spec.source_files = "Classes/**/*.{h,m}"
  
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
  
  spec.dependency "GHNetwork",  "1.0.0"
  spec.dependency "Masonry", "1.1.0"
  spec.dependency "IQKeyboardManager", "6.3.0"
  spec.dependency "MXCaches", "1.0.0"
  spec.dependency "MXImageManager", "1.1.1"
  
end
