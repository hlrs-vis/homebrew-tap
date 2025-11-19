class Osg2vsg < Formula
  desc "Adapter library for converting OpenSceneGraph Images and 3D models to VulkanSceneGraph"
  homepage "http://www.vulkanscenegraph.org/"
  url "https://github.com/vsg-dev/osg2vsg/archive/refs/tags/v0.3.0.tar.gz"
  version "0.3.0"
  head "https://github.com/vsg-dev/osg2vsg.git"
  sha256 "784ca5b8712fa66207bafcf6e71d41494e82d0a0ee65aa75cec6f8ebbc6a28f0"

  depends_on "cmake" => :build
  depends_on "vulkan-scene-graph"
  depends_on "vsgxchange"
  depends_on "open-scene-graph"

  def install
    args = %W[
      -DBUILD_SHARED_LIBS:BOOL=ON
      -DCMAKE_CXX_STANDARD=17
    ]

      #-DCMAKE_INSTALL_RPATH:STRING=#{rpaths.join(";")}

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
  end
end
