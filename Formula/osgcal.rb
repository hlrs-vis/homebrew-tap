class Osgcal < Formula
  desc "Cal3D adapter for OpenSceneGraph, imported from https://sourceforge.net/p/osgcal/code"
  homepage "http://osgcal.sourceforge.net"
  url 'https://github.com/hlrs-vis/osgcal.git', :using => :git, :revision => '66f92936b4783627b71ca640e38cc3789d6dc479'
  version '2022.5'
  head "git://github.com/hlrs-vis/osgcal.git"

  depends_on "cmake" => :build
  depends_on "open-scene-graph"
  depends_on "cal3d"

  def install
    Dir.chdir('osgCal')
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "cmake", ".", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    system "osgCalViewer", "-h"
  end
end
