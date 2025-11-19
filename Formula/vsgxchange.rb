class Vsgxchange < Formula
  desc "Utility library for converting data+materials to/from VulkanSceneGraph"
  homepage "http://www.vulkanscenegraph.org/"
  url "https://github.com/vsg-dev/vsgXchange/archive/refs/tags/v1.1.8.tar.gz"
  version "1.1.8"
  head "https://github.com/vsg-dev/vsgXchange.git"
  sha256 "056a8b172fdccea8d6e3ed0d3d5ba9204de8a61472ece050372d7af8dbbfb55b"

  depends_on "cmake" => :build
  depends_on "vulkan-scene-graph"
  depends_on "freetype"
  depends_on "gdal"
  depends_on "draco"
  depends_on "assimp"
  depends_on "openexr"
  depends_on "libktx" => :head

  patch :DATA

  def install
    args = %W[
      -DBUILD_SHARED_LIBS:BOOL=ON
      -DCMAKE_CXX_STANDARD=17
      -DASSIMP_VERSION_LIST=6.0.2
    ]

      #-DCMAKE_INSTALL_RPATH:STRING=#{rpaths.join(";")}

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
  end
end

__END__
From ae16a7107161f45c8c1346caa67dc4b6953fb2d3 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Martin=20Aum=C3=BCller?= <aumuell@reserv.at>
Date: Wed, 19 Nov 2025 14:29:50 +0100
Subject: [PATCH] brew patches

- fix ambiguity
- search for assimp 6
---
 src/assimp/build_vars.cmake | 2 +-
 src/gdal/GDAL.cpp           | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/assimp/build_vars.cmake b/src/assimp/build_vars.cmake
index 821de33..943f63e 100644
--- a/src/assimp/build_vars.cmake
+++ b/src/assimp/build_vars.cmake
@@ -1,5 +1,5 @@
 # add assimp if available
-find_package(assimp 5.1 QUIET)
+find_package(assimp 6.0)
 
 if(assimp_FOUND)
     OPTION(vsgXchange_assimp "Optional Assimp support provided" ON)
diff --git a/src/gdal/GDAL.cpp b/src/gdal/GDAL.cpp
index 5fd7b93..3ceddc8 100644
--- a/src/gdal/GDAL.cpp
+++ b/src/gdal/GDAL.cpp
@@ -35,6 +35,8 @@ namespace vsgXchange
 
 } // namespace vsgXchange
 
+namespace vsgXchange
+{
 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //
 // GDAL ReaderWriter facade
@@ -258,3 +260,5 @@ vsg::ref_ptr<vsg::Object> GDAL::Implementation::read(const uint8_t* ptr, size_t
 
     return result;
 }
+
+}
-- 
2.52.0

