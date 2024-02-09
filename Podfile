# Uncomment the next line to define a global platform for your project
  platform :ios, '15.0'

target 'App-Form' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for App-Form
  pod 'JGProgressHUD'
  pod 'LBTATools'
  pod 'MaterialComponents/TextControls+FilledTextFields'
  pod 'RealmSwift'


end

post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
  end
end
