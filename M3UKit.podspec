Pod::Spec.new do |spec|
  spec.name         = 'M3UKit'
  spec.version      = '1.2.0'
  spec.summary      = 'The extended M3U playlist parser.'

  spec.description  = <<-DESC
  Parse your extended M3U playlist with ease using the M3UKit framework.
                   DESC

  spec.homepage     = 'https://github.com/SwiftExtensions/M3UKit'
  spec.license      = { :type => 'Commercial', :file => 'LICENSE' }
  spec.author       = { 'Alexander Algashev' => 'algashev@mail.ru' }
  
  spec.platform     = :ios, '11.0'
  spec.swift_version = '5.7'

  spec.source       = { :git => 'https://github.com/SwiftExtensions/M3UKit.git', :tag => "#{spec.version}" }

  spec.source_files  = 'Sources/M3UKit/**/*.{h,m,swift}'
end
