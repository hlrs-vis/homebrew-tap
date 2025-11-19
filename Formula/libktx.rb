class Libktx < Formula
  desc "KTX (Khronos Texture) Library and Tools"
  homepage "https://github.khronos.org/KTX-Software/libktx/index.html"
  url "https://github.com/KhronosGroup/KTX-Software/archive/refs/tags/v4.4.2.tar.gz"
  version "4.4.2"
  head "https://github.khronos.org/KTX-Software/libktx/"
  sha256 "9412cb45045a503005acd47d98f9e8b47154634a50b4df21e17a1dfa8971d323"

  depends_on "cmake" => :build

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
