Pod::Spec.new do |s| 
s.name = "FJUtils" # 名称 （同工程名，写错了就用不了了）
s.version = "0.0.8" # 代码库的版本
s.summary = "公共方法" # 简介
s.description = "公共方法，方便以后调用" # 描述
s.homepage = "https://github.com/KONGFANJI" # 开发者主页
s.license = "MIT" #开源协议，与创建时相同
s.author = { "KFJ" => "392843367@qq.com" } # 作者名称 和 邮箱
s.platform = :ios, "9.0" # 代码库最低支持的版本
s.source = { :git => "https://github.com/KONGFANJI/FJUtils.git",:tag => s.version}   # 代码的Clone 地址 和 tag 版本
s.requires_arc = true # 框架是否使用的ARC
s.source_files = 'FJUtils/Classes/FJUtils.h'


s.subspec 'Storyboard' do |ss|
ss.source_files = 'FJUtils/Classes/Storyboard/*.*'
end


s.resources = 'FJUtils/Classes/FJPublicTools/DAAppsViewController/DAAppsViewController.bundle'

s.subspec 'FJPublicTools' do |ss|
ss.source_files =
'FJUtils/Classes/FJPublicTools/*.*',
'FJUtils/Classes/FJPublicTools/DAAppsViewController/*.*',
'FJUtils/Classes/FJPublicTools/FJRouter/*.*'

end



s.frameworks = "Foundation","UIKit"
s.pod_target_xcconfig = {'ENABLE_BITCODE' => 'NO'}   # 编译flag
#s.libraries = 'libicucore' #依赖第三方库文件。（libicucore.tbd文件为系统定义的库文件，直接使用该命令导入无效，仍需手动在Xcode中导入，原因待查）
s.static_framework  =  true

end
