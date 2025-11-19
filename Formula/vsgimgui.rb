class Vsgimgui < Formula
  desc "Integration of VulkanSceneGraph with ImGui"
  homepage "http://www.vulkanscenegraph.org/"
  url "https://github.com/vsg-dev/vsgImGui.git", :using => :git, :tag => "v0.7.0"
  version "0.7.0"
  head "https://github.com/vsg-dev/vsgImGui.git", :using => :git

  depends_on "cmake" => :build
  depends_on "vulkan-scene-graph"

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
