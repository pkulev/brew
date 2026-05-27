class Glsnake < Formula
  desc "OpenGL Snake game using SDL2"
  homepage "https://github.com/alex-eg/GLSnake"
  url "https://github.com/alex-eg/GLSnake/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "a52c73530a943597e44bc03c4822a61a263332165dc4b0c96b15cb30353b4ae4"
  license "GPL-3.0-or-later"
  version "1.0.3"

  head do
    url "https://github.com/alex-eg/GLSnake.git", branch: "master"
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "sdl2"
  depends_on "sdl2_mixer"
  depends_on "sdl2_ttf"

  def install
    resource_dir = share/"glsnake/resources"
    system "meson", "setup", "builddir"
    system "meson", "configure", "-Dresource_dir=#{resource_dir}/", "builddir"
    system "meson", "compile", "-C", "builddir", "--verbose"
    bin.install "builddir/snake" => "glsnake"
    resource_dir.install Dir["resources/*"]
  end

  def caveats
    <<~EOS
      High scores will be placed here:
        ~/Library/Application Support/glsnake/GLSnake/scores.dat
    EOS
  end

  test do
    assert_predicate bin/"glsnake", :exist?
    assert_path_exists share/"glsnake/resources/fonts/aesymatt.ttf"
  end
end
