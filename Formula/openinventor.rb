class Openinventor < Formula
  homepage 'http://oss.sgi.com/projects/inventor/'
  url 'https://github.com/aumuell/open-inventor.git', :using => :git, :revision => '37521a12090ae48fbd2863e26da0f5babf6a2dbd'
  head 'https://github.com/aumuell/open-inventor.git', :using => :git
  version '2.1.6'

  depends_on "cmake" => :build
  depends_on "bison" => :build

  depends_on "openmotif"
  depends_on "libxi"
  depends_on "mesa"
  depends_on "mesa-glu"
  depends_on "mesalib-glw"
  depends_on "jpeg"
  depends_on "freetype"

  def install
    mkdir "brew-build" do
      system "cmake", "..", *std_cmake_args,
        "-DCMAKE_MACOSX_RPATH=FALSE"
        "-DINVENTOR_INTERNAL_GLW=FALSE"
      system "make", "install"
    end
  end

  test do
    system "ivcat #{share}/inventor/data/models/moon.iv"
  end
end
