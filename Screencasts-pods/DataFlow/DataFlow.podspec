Pod::Spec.new do |spec|
  spec.name         = "DataFlow"
  spec.version      = "0.0.1"
  spec.summary      = "Data flow architecture"
  spec.description  = <<-DESC
    Data flow architecture with stores, reducers, and actions
                   DESC
  spec.homepage     = "https://example.com/DataFlow"
  spec.license      = "Private"
  spec.author       = "Ben Scheirman"

  spec.platform     = :ios, "15.0"
  
  # Normally this would be a reference to a real repo, but since we're doing everything
  # in the same repo, we can just fake it here
  spec.source       = { :git => "https://example.com/repo/DataFlow.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources/**/*.swift"

end
