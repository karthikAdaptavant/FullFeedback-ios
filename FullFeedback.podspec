
Pod::Spec.new do |s|
  s.name             = 'FullFeedback'
  s.version          = '0.1.0'
  s.summary          = 'Full feedback is a framwork which bring a customizable feedback view to integrate in your application and to send the feedback using looptodo (smile)'

  s.homepage         = 'https://github.com/karthikAdaptavant/FullFeedback'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'karthikAdaptavant' => 'karthik.samy@a-cti.com' }
  s.source           = { :git => 'https://github.com/karthikAdaptavant/FullFeedback.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'FullFeedback/Classes/**/*'
  s.dependency 'Alamofire', '~> 4.5'
  s.dependency 'MBProgressHUD'

  s.resource_bundles = {
     'FullFeedback' => ['FullFeedback/Classes/*.{storyboard}']
}
end
