class Cal3d < Formula
  desc "Skeletal 3D character animation library written in C++"
  homepage "http://cal3d.sourceforge.net/docs/api/html/cal3dfaq.html"
  url 'https://github.com/hlrs-vis/cal3d.git', :using => :git, :revision => '0a8d937274d6293bc4438bb87a3ba40592005e51'
  version '2024.1'
  head "git://github.com/hlrs-vis/cal3d.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  def install
    Dir.chdir('cal3d')
    system "autoreconf", "-i"
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "./configure", "--disable-debug",
                          "--disable-unittest",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    system "cal3d_converter", "--help"
  end
end
