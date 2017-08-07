#
# Be sure to run `pod lib lint AddressGeocoder.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "AddressGeocoder"
  s.version          = "0.0.2"
  s.summary          = "Geocoding Helper"

  s.description      = <<-DESC
Geocoding helper. Can provide a locality, coordinates and state based on a ZIP code.
                       DESC

  s.homepage         = "https://github.com/prolificinteractive/AddressGeocoder"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Thibault Klein" => "thibault@prolificinteractive.com" }
  s.source           = { :git => "https://github.com/prolificinteractive/AddressGeocoder.git", :tag => s.version.to_s }

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Sources/**/*.{swift}'
end
