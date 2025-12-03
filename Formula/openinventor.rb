class Openinventor < Formula
  homepage 'http://oss.sgi.com/projects/inventor/'
  url 'https://github.com/aumuell/open-inventor/archive/refs/tags/v2.1.6.1.tar.gz'
  version '2.1.6.1'
  sha256 '02e9b2d4c7dd16b36be2b3f16d98805408d6b5d525b4397456fe5fed26636cc3'
  head 'https://github.com/aumuell/open-inventor.git', :using => :git

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
