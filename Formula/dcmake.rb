class Dcmake < Formula
  desc "CMake debugger"
  homepage "https://github.com/skeeto/dcmake"
  url "https://github.com/skeeto/dcmake/archive/refs/tags/v1.7.1.tar.gz"
  sha256 "ee6a79e45bfccf146af34650bf722216f54e9d4f21f30e7783dd92904b995ff0"
  head "https://github.com/skeeto/dcmake.git", :using => :git

  license "Unlicense"

  depends_on "cmake" => :build
  depends_on "nlohmann-json"
  depends_on "glfw"

  # Additional dependency
  resource "imgui" do
    url "https://github.com/ocornut/imgui/archive/f5f6ca07be7ce0ea9eed6c04d55833bac3f6b50b.tar.gz"
    sha256 "91aed5e92c1e24aada8dfd2a6933222341ec291dc29a4add49828610d5cb6765"
  end

  patch :p2, :DATA

  def install
    resource("imgui").stage "deps/imgui"

    cmake_args = *std_cmake_args
    cmake_args.append("-DDEPS=LOCAL")

    # Remove unrecognized options if they cause configure to fail
    # https://docs.brew.sh/rubydoc/Formula.html#std_configure_args-instance_method
    #system "./configure", "--disable-silent-rules", *std_configure_args
     system "cmake", "-S", ".", "-B", "build", *cmake_args
     system "cmake", "--build", "build"
     system "cmake", "--install", "build"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test dcmake`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "false"
  end
end

__END__
diff --color=auto -r -c a/dcmake-1.6.0/CMakeLists.txt b/dcmake-1.6.0/CMakeLists.txt
*** a/dcmake-1.6.0/CMakeLists.txt	Sun Apr 12 15:48:54 2026
--- b/dcmake-1.6.0/CMakeLists.txt	Sun Apr 12 21:04:24 2026
***************
*** 150,152 ****
--- 150,154 ----
  if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    target_compile_options(dcmake PRIVATE -Wall -Wconversion)
  endif()
+ 
+ install(TARGETS dcmake)
