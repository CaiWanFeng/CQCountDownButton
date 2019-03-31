Pod::Spec.new do |spec|


  spec.name         = "CQCountDownButton"
  spec.version      = "1.1"
  spec.summary      = "A simple and easy use countdown button."

  spec.description  = <<-DESC
                     实用又好用的倒计时button，可用于获取验证码等场景。
                   DESC

  spec.homepage     = "https://github.com/CaiWanFeng/CQCountDownButton"
  spec.license      = "MIT"

  spec.author             = { "caiqiang" => "caiqiang.developer@gmail.com" }
  spec.social_media_url   = "https://www.jianshu.com/u/4212f351f6b5"


  spec.platform     = :ios
  spec.platform     = :ios, "8.0"


  spec.source       = { :git => "https://github.com/CaiWanFeng/CQCountDownButton.git", :tag => "#{spec.version}" }
  spec.source_files  = "CQCountDownButton", "CQCountDownButton/**/*.{h,m}"

end
