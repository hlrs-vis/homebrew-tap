class Osgephemeris < Formula
  desc "A sky dome and ephemeris model for OSG - Automatically exported from code.google.com/p/osgephemeris"
  homepage "http://osgcal.sourceforge.net"
  url 'https://github.com/hlrs-vis/osgephemeris.git', :using => :git, :revision => 'ef923a437831e0f3b574b5e802e3aa0e74b4df58'
  version '2016.3'
  head "git://github.com/hlrs-vis/osgephemeris.git"

  depends_on "cmake" => :build
  depends_on "open-scene-graph"

  def install

    args = %w[
      -DCMAKE_MACOSX_RPATH=FALSE
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

  end

  test do
    system "osgEphemerisViewer"
  end
end
