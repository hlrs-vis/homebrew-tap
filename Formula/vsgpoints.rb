class Vsgpoints < Formula
  desc "VulkanSceneGraph library and example suite for rendering point clouds"
  homepage "http://www.vulkanscenegraph.org/"
  url "https://github.com/vsg-dev/vsgPoints/archive/refs/tags/v0.6.0.tar.gz"
  version "0.6.0"
  head "https://github.com/vsg-dev/vsgPoints.git"
  sha256 "f907d76231bb929b02846d12143fb60f815bb6a7a9c6a98e48cad1c8b184de75"

  depends_on "cmake" => :build
  depends_on "vulkan-scene-graph"
  depends_on "vsgxchange"

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
