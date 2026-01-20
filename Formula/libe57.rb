class Libe57 < Formula
  desc "Software Tools for Managing E57 Point Cloud Files"
  homepage "http://libe57.org"
  url "https://github.com/hlrs-vis/libe57.git", branch: "main", revision: "aa6ecb82d0a50153425649889d6b2fb9e4f4fe79"
  version "1.1.337"
  license "http://libe57.org/license.html"
  head "https://github.com/hlrs-vis/libe57.git", branch: "main"

  depends_on "cmake" => :build

  depends_on "boost"
  depends_on "xerces-c"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "test -x #{bin}/e57validate"
  end
end
