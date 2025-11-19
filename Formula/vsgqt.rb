class Vsgqt < Formula
  desc "Qt integration with VulkanSceneGraph"
  homepage "http://www.vulkanscenegraph.org/"
  url "https://github.com/vsg-dev/vsgQt/archive/refs/tags/v0.4.0.tar.gz"
  version "0.4.0"
  sha256 "31756a513ec1e703296e5d256daaa0c8d49af7a1b605ff3fc9fbc902e5be1c8d"
  license "MIT"
  head "https://github.com/vsg-dev/vsgQt.git", :using => :git

  depends_on "cmake" => :build
  depends_on "qtbase"

  def install
    args = %W[
      -DCMAKE_MACOSX_RPATH=FALSE
      -DBUILD_SHARED_LIBS:BOOL=ON
      -DCMAKE_CXX_STANDARD=17
      -DQT_PACKAGE_NAME=Qt6
    ]

      #-DCMAKE_INSTALL_RPATH:STRING=#{rpaths.join(";")}

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
  end
end
