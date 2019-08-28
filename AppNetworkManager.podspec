#
#  Be sure to run `pod spec lint AppNetworkManager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = 'AppNetworkManager'
  spec.version      = '1.0.1'
  spec.license      = 'MIT'
  spec.author       = { "Quan Li" => "1083099465@qq.com" }
  spec.summary      = 'iOS 网络请求工具类'
  spec.homepage     = 'https://github.com/lqIphone/AppNetworkManager'
  spec.source       = { :git => 'https://github.com/lqIphone/AppNetworkManager.git', :tag => '1.0.1' }
  spec.source_files  = "AppNetworkManager/Classes/*.swift"
  spec.requires_arc = true
  spec.platform     = :ios, "9.0"
  spec.swift_version = '4.2'
  spec.framework  = "Security"
  spec.dependency 'HandyJSON', '~> 5.0.0'
  spec.dependency 'Moya/RxSwift' , '~> 13.0.1'
  spec.dependency 'RxSwift','~>4.5.0'
  spec.dependency 'RxCocoa','~>4.5.0'
end
