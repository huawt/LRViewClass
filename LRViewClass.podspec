
Pod::Spec.new do |s|
  s.name             = 'LRViewClass'
  s.version          = '1.0.6'
  s.summary          = 'LRViewClass'
  s.description      = <<-DESC
  LRViewContoller:普通控制器
  LRNavigationControll:导航控制器
  LRTabBarViewController: 底部 TabBar 控制器
  LRNavigationBar: 导航条
  ControllerPopByInteractivePopGestureRecognizer: 滑动返回监听
                       DESC
  s.homepage         = 'https://github.com/huawt/LRViewClass'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'huawt' => 'ghost263sky@163.com' }
  s.source           = { :git => 'https://github.com/huawt/LRViewClass.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'LRViewClass/Classes/**/*'
  s.resource = 'LRViewClass/LRImage.bundle'
  s.public_header_files = 'LRViewClass/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
end
