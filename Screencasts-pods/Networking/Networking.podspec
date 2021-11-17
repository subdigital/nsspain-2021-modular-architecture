Pod::Spec.new do |spec|
  spec.name         = "Networking"
  spec.version      = "0.0.1"
  spec.summary      = "Networking, APIs"
  spec.description  = <<-DESC
    Apis and networking
                   DESC
  spec.homepage     = "https://example.com/Networking"
  spec.license      = "Private"
  spec.author       = "Ben Scheirman"

  spec.platform     = :ios, "15.0"
  
  # Normally this would be a reference to a real repo, but since we're doing everything
  # in the same repo, we can just fake it here
  spec.source       = { :git => "https://example.com/repo/Networking.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources/**/*.swift"

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"
  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"

  # Pod dependencies
  spec.dependency "Models"

end
