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

  postflight do
    puts "Installing .dylib files to #{ENV.fetch("HOMEBREW_PREFIX", "/opt/homebrew")}/lib"
    # Install .dylib files
    lib_dir = "#{appdir}/lovr.app/Contents/MacOS"
    target_dir = "#{ENV.fetch("HOMEBREW_PREFIX", "/opt/homebrew")}/lib"
    dylib_files = Dir["#{lib_dir}/*.dylib"]
    dylib_files.each do |dylib|
      # Symlink
      target_path = File.join(target_dir, File.basename(dylib))
      File.symlink(dylib, target_path) unless File.exist?(target_path)
    end
  end

  uninstall_postflight do
    # Remove .dylib files
    lib_dir = "#{appdir}/lovr.app/Contents/MacOS"
    dylib_files = Dir["#{lib_dir}/*.*"]
    dylib_files.each do |dylib|
      target_path = File.join(ENV.fetch("HOMEBREW_PREFIX", "/opt/homebrew"), "lib", File.basename(dylib))
      File.delete(target_path) if File.symlink?(target_path)
    end
  end

  zap trash: "~/Library/Saved Application State/org.bjornbytes.lovr.savedState"
end
