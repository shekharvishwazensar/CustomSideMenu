Pod::Spec.new do |s|
    s.name             = 'SideMenuDrawer'
    s.version          = '1.0.0'
    s.summary          = 'Side Menu Drawer' 
  
    s.description      = "This library contains custom side menu drawer"
  
    s.homepage         = 'https://www.zensar.com/'
    s.license          = 'MIT'
    s.author           = { 'shekharvishwazensar' => 'shekhar.vishwakarma@zensar.com' }
    s.source           = {
      :git => 'https://github.com/shekharvishwazensar/CustomSideMenu',
      :tag => s.version.to_s }
  
    s.ios.deployment_target = '11.0'
    s.platform     = :ios, '11.0'
    s.requires_arc = true
    s.default_subspec = 'All'
    s.swift_versions = '5.0'
  
    s.subspec "All" do |sp|
      # Internal dependencies
      
      # Third Party Dependencies
     sp.source_files = 'SideMenuDrawer/**/*.{swift}'
     sp.resource_bundles = {
        'SideMenuDrawer' => ["SideMenuDrawer/*.{html,xib}"]
      }
    end
  end
  
  