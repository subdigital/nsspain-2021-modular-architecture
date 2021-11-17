Pod::Spec.new do |spec|
  spec.name         = "SeriesListFeature"
  spec.version      = "0.0.1"
  spec.summary      = "SeriesListFeature"
  spec.description  = <<-DESC
    Series List Feature
                   DESC
  spec.homepage     = "https://example.com/SeriesListFeature"
  spec.license      = "Private"
  spec.author       = "Ben Scheirman"

  spec.platform     = :ios, "15.0"
  
  # Normally this would be a reference to a real repo, but since we're doing everything
  # in the same repo, we can just fake it here
  spec.source       = { :git => "https://example.com/repo/SeriesListFeature.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources/**/*.swift"

  spec.dependency "Models"
  spec.dependency "Networking"
  spec.dependency "DataFlow"

end
