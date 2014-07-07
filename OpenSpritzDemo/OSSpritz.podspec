Pod::Spec.new do |s|
  s.name  = "OSSpritz"
  s.version = "0.0.8"
  s.summary = "An open-source implementation of Spritz reading system."
  s.homepage = "https://github.com/Fr4ncis/openspritz-ios.git"
  s.license = {:type => 'MIT', :file => 'OpenSpritzDemo/LICENSE'}
  s.author = { "Francesco Mattia" => "francesco.mattia@gmail.com" }
  s.social_media_url = "http://twitter.com/francescomattia"
  s.platform  = :ios, '7.0'
  s.requires_arc = true
  s.source  = { :git => "https://github.com/Fr4ncis/openspritz-ios.git", :tag => "0.0.8" }
  s.source_files  = 'OpenSpritzDemo/OSSpritz/', 'OpenSpritzDemo/OSSpritz/**/*.{h,m}'
end
