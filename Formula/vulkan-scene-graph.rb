class VulkanSceneGraph < Formula
  desc "Vulkan & C++17 based Scene Graph Project"
  homepage "http://www.vulkanscenegraph.org/"
  url "https://github.com/vsg-dev/VulkanSceneGraph/archive/refs/tags/v1.1.12.tar.gz"
  version "1.1.12"
  head "https://github.com/vsg-dev/VulkanSceneGraph.git"
  sha256 "bd9c58f615d44a4de684fc0c97acc010a548a6714a64c98c59ee2b86f3e66e3d"

  depends_on "cmake" => :build
  depends_on "vulkan-headers" => :build
  depends_on "glslang"

  def install
    args = %W[
      -DBUILD_SHARED_LIBS:BOOL=ON
      -DCMAKE_CXX_STANDARD=17
      -DGLSLANG_MIN_VERSION=16
    ]

      #-DCMAKE_INSTALL_RPATH:STRING=#{rpaths.join(";")}

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
  end
end
