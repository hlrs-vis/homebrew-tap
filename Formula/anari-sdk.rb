# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class AnariSdk < Formula
  desc "ANARI Software Development Kit (SDK)"
  homepage "https://github.com/KhronosGroup/ANARI-SDK"
  url "https://github.com/KhronosGroup/ANARI-SDK/archive/refs/tags/v0.15.0.tar.gz"
  head "https://github.com/KhronosGroup/ANARI-SDK.git", :using => :git
  sha256 "8fe0fa1a7eea6768fe69a46313ba405b62b2667b1bae5e843bc751a90a53fad3"
  license "Apache-2.0"

  depends_on "cmake" => :build

  # Additional dependency
  # resource "" do
  #   url ""
  #   sha256 ""
  # end

  def install
    cmake_args = std_cmake_args
    mkdir "build.anari-sdk" do
      system "cmake", "..", *cmake_args
      system "make install"
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test anari-sdk`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "false"
  end
end
