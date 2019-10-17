#
# Be sure to run `pod lib lint LayoutUtilities.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                    = 'LayoutUtilities'
  s.version                 = '1.0.1'
  s.summary                 = 'A simple collection of helper methods used to ease working with AutoLayout in code.'
  s.homepage                = 'https://www.climacell.co'
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.author                  = { 'itamar.biton@climacell.co' => 'itamar.biton@climacell.co' }
  s.source                  = { :git => 'https://github.com/itamar.biton@climacell.co/LayoutUtilities.git', :tag => s.version.to_s }
  s.ios.deployment_target   = '11.0'
  s.source_files            = 'LayoutUtilities/Classes/**/*'
  s.frameworks              = 'UIKit', 'MapKit'
  s.swift_version           = '4.2'

  s.description      = <<-DESC
  This is nothing but a collection of simple helper methods and extensions used to make
  working with Apple's AutoLayout system a bit easier.
  DESC
  
  # s.resource_bundles = {
  #   'LayoutUtilities' => ['LayoutUtilities/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.dependency 'AFNetworking', '~> 2.3'
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
end
