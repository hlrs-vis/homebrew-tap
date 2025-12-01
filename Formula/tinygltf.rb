class Tinygltf < Formula
  desc "Header only C++11 tiny glTF 2.0 library"
  homepage "https://github.com/syoyo/tinygltf"
  url "https://github.com/syoyo/tinygltf/archive/refs/tags/v2.9.7.tar.gz"
  version "2.9.7"
  head "https://github.com/syoyo/tinygltf.git"
  sha256 "9d31cf7f22e81febaf1ad587d7722582c154f7d9125673ee46c0c594765e8f35"

  depends_on "cmake" => :build

  def install
    args = %W[
    ]

      #-DCMAKE_INSTALL_RPATH:STRING=#{rpaths.join(";")}

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
  end
end
