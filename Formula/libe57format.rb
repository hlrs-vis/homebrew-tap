class Libe57format < Formula
  desc "Library for reading & writing the E57 file format"
  homepage "https://github.com/asmaloney/libE57Format"
  #url "https://github.com/asmaloney/libE57Format.git", branch: "master", revision: "7707b6442e72edc9ea4ed088ab064b30bf1d557c"
  url "https://github.com/asmaloney/libE57Format.git", branch: "master", revision: "f28ea52517b65faf5bccfa2ec6f50e5156cf5f1c"
  #version "3.0.2"
  version "2.3.0"
  license "http://libe57.org/license.html"
  head "https://github.com/asmaloney/libE57Format.git", branch: "master"

  depends_on "cmake" => :build

  depends_on "xerces-c"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "test -x #{bin}/e57validate"
  end
end
