require 'formula'

class Covise < Formula
  homepage "https://www.hlrs.de/covise/"
  desc "Visualization environment for scientific and engineering data"
  url "https://github.com/hlrs-vis/covise.git", :using => :git, :revision => "83037cf8fd0eecd1a486ceaca2e9dcad99b446eb"
  version "2025.6"
  head "https://github.com/hlrs-vis/covise.git", :using => :git

  option "with-cuda", "Build with CUDA support"
  option "with-jpeg", "Build against libjpeg instead of libjpeg-turbo"
  option "with-fortran", "Build modules requiring Fortran"
  option "without-assimp", "Build without support for reading 3D models with Assimp"
  option "without-vtk", "Build without support for VTK data"
  option "without-hdf5", "Build without support for HDF5 based file formats"
  option "without-mpi", "Build without support for MPI in OpenCOVER"

  depends_on "cmake" => :build
  depends_on "swig" => :build

  depends_on "xerces-c"
  depends_on "qt@6"
  conflicts_with "qt@5"
  depends_on "glew"
  depends_on "jpeg" => :optional
  depends_on "jpeg-turbo" if build.without? "jpeg"
  depends_on "giflib"
  #depends_on "libpng12"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "freetype"
  depends_on "boost"
  depends_on "python3"
  depends_on "gdcm" => :optional
  depends_on "cfitsio" => :recommended
  depends_on "teem" => :recommended
  depends_on "hdf5" => :recommended
  depends_on "assimp" => :recommended
  depends_on "cgns" => :optional
  depends_on "snappy" => :optional
  depends_on "Caskroom/cask/cuda" if build.with? "cuda"
  depends_on "proj" => :recommended
  depends_on "gdal" => :recommended
  depends_on "libarchive"

  # OpenCOVER
  depends_on "open-scene-graph"
  depends_on "hidapi"
  depends_on "eigen"
  depends_on "bullet"
  depends_on "hlrs-vis/tap/osgcal"
  depends_on "hlrs-vis/tap/opencrg"
  depends_on "hlrs-vis/tap/libe57"
  #depends_on "mpich" => :optional
  depends_on "open-mpi" if build.with? "mpi"
  depends_on "mpich" if build.with? "mpich"
  # TouchInteraction plugin, but this is does not compile because of missing libgcc_s.1.1.dylib
  #depends_on "openblas"

  depends_on "gcc" if build.with? "fortran"
  #conflicts_with "fortran", :because => "linking with Fortran libraries fails without explicit Fortran dependency, specify --with-fortran" if build.without? "fortran"

  depends_on "vtk" => :recommended
  conflicts_with "vtk", :because => "including VTK headers fails without explicit VTK dependency, specify --with-vtk" if build.without? "vtk"

  #option "with-gdcm", "Build with GDCM for DICOM reading"
  #depends_on "homebrew/gdcm" if build.with? "gdcm"
  #conflicts_with "gdcm", :because => "including GDCM headers fails without explicit GDCM dependency, specify --with-gdcm" if build.without? "gdcm"

  depends_on "sdl12-compat" # => :optional
  #conflicts_with "sdl12-compat", :because => "including SDL header fails without explicit SDL dependency, specify --with-sdl" if build.without? "sdl"

  def install
    ENV["COVISEDIR"] = buildpath
    ENV["COVISEDESTDIR"] = buildpath
    ENV["ARCHSUFFIX"] = "macosopt"
    ENV["EXTERNLIBS"] = ""

    cmake_args = std_cmake_args
    cmake_args << "-DCOVISE_WARNING_IS_ERROR:BOOL=OFF"
    cmake_args << "-DCOVISE_USE_VISIONARAY:BOOL=OFF"
    cmake_args << "-DCOVISE_BUILD_DRIVINGSIM:BOOL=ON"
    cmake_args << "-DCOVISE_USE_X11:BOOL=OFF"
    cmake_args << "-DCOVISE_USE_FORTRAN:BOOL=ON" if build.with? "fortran"
    cmake_args << "-DCOVISE_USE_FORTRAN:BOOL=OFF" if build.without? "fortran"
    cmake_args << "-DCOVISE_USE_CUDA:BOOL=ON" if build.with? "cuda"
    cmake_args << "-DCOVISE_USE_CUDA:BOOL=OFF" if build.without? "cuda"
    cmake_args << "-DCOVISE_USE_MPI:BOOL=OFF" if build.without? "mpi"
    cmake_args << "-DCOVISE_USE_MPI:BOOL=ON" if build.with? "mpi"
    cmake_args << "-DCOVISE_USE_QT5:BOOL=OFF"

    #because TouchInteraction does not compile
    cmake_args << "-DCMAKE_DISABLE_FIND_PACKAGE_BLAS:BOOL=ON"

    #cmake_args << "-DCOVISE_USE_VIRVO=OFF"
    #cmake_args << "-DCOVISE_BUILD_MODULES=OFF"

    mkdir "build.covise" do
        system "cmake", "..", *cmake_args
        system "make install"
    end
  end

  test do
    system "covise --version"
    system "opencover --version"
  end
end
