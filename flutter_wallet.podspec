
Pod::Spec.new do |spec|

  spec.name         = "flutter_wallet"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of flutter_wallet."

  spec.description  = <<-DESC
                   DESC

  spec.homepage     = "https://github.com/viabtc/viawallet_flutter"

  spec.license      = { :type => 'MIT', :file => 'LICENSE' }

  spec.author             = { "wDemonX" => "364960358@qq.com" }

  spec.platform     = :ios, "11.0"
  
  spec.requires_arc = true
  
  spec.source        = { :git => '', :tag => "#{spec.version}" }
  
  spec.ios.vendored_frameworks = "**/*.framework"

end
