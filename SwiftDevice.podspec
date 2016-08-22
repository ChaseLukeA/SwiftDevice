#
# Be sure to run `pod lib lint SwiftDevice.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftDevice'
  s.version          = '0.1.3'
  s.summary          = "Instantly get the type and orientation of your iOS device for doing different things in code!"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
"A simpler, friendlier way to access device type and orientation of iOS device for programatically doing things based on what device is being used and how its being held. A wrapper implementation of UIDevice.currentDevice().UIInterfaceOrientation and UIDevice.currentDevice().orientation."
                       DESC

  s.homepage         = 'https://github.com/ChaseLukeA/SwiftDevice'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ChaseLukeA' => 'chase.luke.a@gmail.com' }
  s.source           = { :git => 'https://github.com/ChaseLukeA/SwiftDevice.git', :tag => s.version.to_s }
  #s.social_media_url = 'https://twitter.com/Chase_Luke_A'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SwiftDevice/*'
  
  # s.resource_bundles = {
  #   'SwiftDevice' => ['SwiftDevice/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
