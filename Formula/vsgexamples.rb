class Vsgexamples < Formula
  desc "Example programs that test and illustrate how to use the VSG and optional add-on libraries"
  homepage "http://www.vulkanscenegraph.org/"
  version "1.1.10"
  url "https://github.com/vsg-dev/vsgExamples/archive/refs/tags/v1.1.10.tar.gz"
  sha256 "92da88e00bfa93c479600370ae261bfc20a3040291254ff2a7345e563ef7fbbd"
  head "https://github.com/vsg-dev/vsgExamples.git", :using => :git

  depends_on "cmake" => :build
  depends_on "vulkan-scene-graph"
  depends_on "vsgimgui"

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
