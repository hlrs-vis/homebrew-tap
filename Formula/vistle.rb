class Vistle < Formula
  homepage "https://vistle.io"
  desc "Parallel visualization system"
  url "https://github.com/vistle/vistle.git", :using => :git, :revision => "ede180a17661ff61ed856c79b0dacf603f0de11d"
  version "2023.5"
  head "https://github.com/vistle/vistle.git", :using => :git

  option "without-cover", "Build without VR renderer"
  option "without-vtk", "Build without support for VTK data"
  option "with-mpi", "Build with MPI support (defaults to Open MPI)"
  option "with-mpich", "Build with MPICH instead of Open MPI"

  depends_on "cmake" => :build

  depends_on "glew"
  depends_on "coreutils" # for grealpath
  depends_on "jpeg" => :optional
  depends_on "jpeg-turbo" if build.without? "jpeg"
  depends_on "boost"
  depends_on "python3"
  depends_on "qt"
  depends_on "assimp" => :recommended
  depends_on "proj" => :recommended
  depends_on "hdf5" => :optional
  depends_on "snappy" => :optional
  depends_on "libarchive"
  depends_on "lz4"
  depends_on "zstd"
  depends_on "open-scene-graph" => :optional
  depends_on "embree"
  depends_on "ispc"
  depends_on "cgal"
  depends_on "xorgrgb"
  depends_on "covise" if build.with? "cover"

  depends_on "mpich" if build.with? "mpich"
  if build.without? "mpich"
    depends_on "open-mpi" if build.with? "mpi"
  end

  depends_on "vtk" => :recommended
  conflicts_with "vtk", :because => "including VTK headers fails without explicit VTK dependency, specify --with-vtk" if build.without? "vtk"

  def install
    ENV["COVISEDIR"] = "#{HOMEBREW_PREFIX}/opt/covise"
    ENV["COVISEDESTDIR"] = buildpath
    ENV["EXTERNLIBS"] = ""
    ENV["ARCHSUFFIX"] = "macosopt"

    cmake_args = std_cmake_args

    if build.without? "mpi" and build.without? "mpich"
      cmake_args << "-DVISTLE_USE_MPI:BOOL=OFF"
    end

    mkdir "build.vistle" do
      system "cmake", "..", *cmake_args
      system "make install"
    end
  end

  test do
    system "vistle", "-h"
  end
end
