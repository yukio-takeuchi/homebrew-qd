class Qd < Formula
  desc "C++/Fortran-90 double-double and quad-double package"
  homepage "https://crd.lbl.gov/~dhbailey/mpdist/"
  url "https://crd.lbl.gov/~dhbailey/mpdist/qd-2.3.20.tar.gz"
  sha256 "72900ae5d3047719624701878abd8ed88fe3e4bc844c6fd614161ad926518385"

  bottle do
    cellar :any_skip_relocation
    sha256 "43f6d1436bdc32bd004306741adeb192f5d6d2ae9e8b71426b9503b0e8ad3fe8" => :high_sierra
    sha256 "7c51a39a1e50a8f64f35b42f7155be032bb9ab2fad4d319894ed17b6d9d00cce" => :sierra
    sha256 "13d95068f7a9ff0ec7bb4837dd82b0bf09ce8816dd2fb09ef6acc91ad6cb1f6a" => :el_capitan
  end

  depends_on "gcc" # for gfortran
  ## Modified the original qd.rbb to remove src/*.o and src/*.lo before make
  def install
    system "./configure", "--disable-dependency-tracking", "--enable-shared",
                          "--prefix=#{prefix}"
    system "rm", "src/bits.o", "src/c_dd.o", "src/c_qd.o", "src/dd_const.o", "src/dd_real.o",  "src/fpu.o", "src/qd_const.o", "src/qd_real.o", "src/util.o"
    system "rm", "src/bits.lo", "src/c_dd.lo",  "src/c_qd.lo",   "src/dd_const.lo", "src/dd_real.lo",  "src/fpu.lo", "src/qd_const.lo", "src/qd_real.lo", "src/util.lo"
    system "make"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/qd-config --configure-args")
  end
end