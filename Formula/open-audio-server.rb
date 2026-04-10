class OpenAudioServer < Formula
  desc "Sound server for immersive environments"
  homepage "https://github.com/hlrs-vis/Open-Audio-Server"
  license "unknown"
  url "https://github.com/hlrs-vis/Open-Audio-Server.git", :using => :git, :revision => "57e7c50bb050c553f83fe15309093e5dd0260d41"
  version "2026.4"
  head "https://github.com/hlrs-vis/Open-Audio-Server.git"

  depends_on "cmake" => :build
  depends_on "freealut"
  depends_on "fltk"

  def install
    system "cmake", "-S", "server", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test Open-Audio-Server`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "OAS", "--version"
  end
end
