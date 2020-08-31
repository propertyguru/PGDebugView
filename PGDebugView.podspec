Pod::Spec.new do |s|
  s.name = 'PGDebugView'
  s.version = '0.6.5'

  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'PGDebugView converts Plist into a visual editor'

  s.social_media_url = 'http://twitter.com/ioscook'
  s.homepage = 'https://github.com/propertyguru/PGDebugView'
  s.authors = { 'Suraj Pathak' => 'freesuraj@gmail.com' }
  s.source = { :git => 'git@github.com:propertyguru/PGDebugView.git', :tag => s.version }

  s.ios.deployment_target = '9.0'
  s.swift_version   = '5.0'

  s.source_files = 'Source/**/*.{swift}'
  s.resources = ['Source/**/*.{xib}']
end