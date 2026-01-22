class Osgcal < Formula
  desc "Cal3D adapter for OpenSceneGraph, imported from https://sourceforge.net/p/osgcal/code"
  homepage "http://osgcal.sourceforge.net"
  url 'https://github.com/hlrs-vis/osgcal.git', :using => :git, :revision => '8042a64f7f1bf9db1098c167408673002221e607'
  version '2026.1'
  head "git://github.com/hlrs-vis/osgcal.git"

  depends_on "cmake" => :build
  depends_on "open-scene-graph"
  depends_on "cal3d"

  def install

    args = %w[
      -DCMAKE_MACOSX_RPATH=FALSE
    ]

    #Dir.chdir('osgCal')

    system "cmake", "-S", "osgCal", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "osgCalViewer", "-h"
  end
end
