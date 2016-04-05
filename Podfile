# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
# Uncomment this line if you're using Swift
use_frameworks!

target 'ProductHunter' do
  pod 'Koloda'
  pod 'Alamofire'
  pod 'RealmSwift'
  pod 'SwiftyJSON'
  pod 'PromiseKit', '~> 3.0'
end

post_install do |installer|
    `find Pods -regex 'Pods/pop.*\\.h' -print0 | xargs -0 sed -i '' 's/\\(<\\)pop\\/\\(.*\\)\\(>\\)/\\"\\2\\"/'`
end

target 'ProductHunterTests' do

end

target 'ProductHunterUITests' do

end

