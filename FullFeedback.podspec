
Pod::Spec.new do |s|
  s.name             = 'FullFeedback'
  s.version          = '0.1.8'
  s.summary          = 'Full feedback is a framework which bring a customizable feedback view to integrate in your application and to send the feedback using looptodo (smile)'

  s.homepage         = 'https://github.com/karthikAdaptavant/FullFeedback-ios.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'karthikAdaptavant' => 'karthik.samy@a-cti.com' }

  s.source           = { :git => 'https://github.com/karthikAdaptavant/FullFeedback-ios.git', :tag => s.version.to_s }



  s.platform = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'FullFeedback/Classes/**/*.{swift}'

  s.resource_bundles = {
  'FullFeedback' => ['FullFeedback/Classes/**/*.{storyboard,png}']
  }

  s.dependency 'Alamofire', '~> 4.7'
  s.dependency 'MBProgressHUD', '1.0.0'
  s.dependency 'SwiftyJSON'

end
