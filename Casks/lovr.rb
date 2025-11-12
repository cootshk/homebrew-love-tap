cask "lovr" do
  version "0.18.0"
  sha256 "683b0ed094b689858e11d825c3a83994d61e66485dd9a071f501b53e656dbe77"

  url "https://github.com/bjornbytes/lovr/releases/download/v#{version}/lovr-v#{version}.app.zip",
      verified: "github.com/bjornbytes/lovr/"
  name "LOVR"
  desc "Open source Lua framework for building 3D games and VR experiences"
  homepage "https://lovr.org/"

  app "lovr.app"
  binary "#{appdir}/lovr.app/Contents/MacOS/lovr"

  zap trash: "~/Library/Saved Application State/org.bjornbytes.lovr.savedState"
end
