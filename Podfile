platform :ios, '10.3'

target 'BattleApp' do
  use_frameworks!

  pod 'Crashlytics'

  target 'BattleAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'BattleAppUITests' do
    inherit! :search_paths
  end
end

# TEMP: Resolves the following warning in 1.5.0 from the new Xcode build system.
# Target Pods-BattleApp product Pods_BattleApp cannot link framework Foundation.framework
# https://github.com/CocoaPods/CocoaPods/issues/7251#issuecomment-382044151
post_install do |installer|
  podsTargets = installer.pods_project.targets.find_all { |target| target.name.start_with?('Pods') }
  podsTargets.each do |target|
      target.frameworks_build_phase.clear
  end
end
