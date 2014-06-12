Pod::Spec.new do |s|
  s.name        = "PMUtils"
  s.version     = "0.0.52"
  s.summary     = "Categories on Foundation and UIKit classes that offer extended functionality."
  s.homepage    = "https://github.com/petermeyers1/#{s.name}"
  s.license     = 'MIT'
  s.author      = { "Peter Meyers" => "petermeyers1@gmail.com" }
  s.source      = { :git => "https://github.com/petermeyers1/#{s.name}.git", :tag => s.version.to_s }
  s.platform    = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  s.public_header_files = 'Classes/**/PMUtils.h'
  s.source_files = 'Classes/**/PMUtils.{h,m}'
  s.requires_arc = true
    
    
  s.subspec 'UIKit+PMUtils' do |ss|
  	ss.source_files = 'Classes/ios/UIKit+PMUtils/*.{h,m}'
  end  
  
  s.subspec 'Foundation+PMUtils' do |ss|
  	ss.source_files = 'Classes/ios/Foundation+PMUtils/*.{h,m}'
  	ss.frameworks   = 'CoreData'
  end
  	
  s.subspec 'PMAnimationQueue' do |ss|
  	ss.source_files = 'Classes/ios/PMAnimationQueue/PMAnimationQueue.{h,m}'
  end
  
  s.subspec 'PMOrderedDictionary' do |ss|
  	ss.source_files = 'Classes/ios/PMOrderedDictionary/PMOrderedDictionary.{h,m}'
  end
  
  s.subspec 'PMPair' do |ss|
  	ss.source_files = 'Classes/ios/PMPair/PMPair.{h,m}'
  end
  
  s.subspec 'PMProtocolInterceptor' do |ss|
  	ss.source_files = 'Classes/ios/PMProtocolInterceptor/PMProtocolInterceptor.{h,m}'
  end
  
  s.subspec 'PMImageFilmstrip' do |ss|
  	ss.source_files = 'Classes/ios/PMImageFilmstrip/PMImageFilmstrip.{h,m}'
  end
  
end
