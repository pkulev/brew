class Sex < Formula
  desc "Sex: for passionate software developers."
  homepage "https://github.com/alex-eg/sex"
  license "MIT"
  head "https://github.com/alex-eg/sex.git", branch: "main"

  depends_on "make" => :build
  depends_on "chicken" => :build

  resource "fmt" do
    url "https://anonymous@code.call-cc.org/svn/chicken-eggs/release/5/fmt/tags/0.8.11.3/"
    # NOTE: changes too often
    # sha256 "eb805996d211331536b61c1e3f1a5e4c8bcf85149794a34ace7bb2d6284dda92"
  end

  resource "getopt-long" do
    url "https://anonymous@code.call-cc.org/svn/chicken-eggs/release/5/getopt-long/tags/1.21/"
    # NOTE: changes too often
    # sha256 "ab4644ba2ef4dbcf4917fc0a35f3a6b34ceddd87a9c73b2c69972f8af2f0e77e"
  end

  resource "brev-separate" do
    url "https://idiomdrottning.org/brev-separate"
    sha256 "f8122d222fc6a90d85e8985ffb3049f9cfe75a1d46cdf0fe61be9af566f8ecb5"
  end

  resource "tree" do
    url "https://idiomdrottning.org/tree.scm"
    sha256 "628889506b6540f9f60dc11c8465e879a652336cc60ec3d4c08c749f8f785a5f"
  end

  resource "srfi-1" do
    url "https://anonymous@code.call-cc.org/svn/chicken-eggs/release/5/srfi-1/tags/0.5.1/"
    # NOTE: changes too often
    # sha256 "b78b68fca918667af35273627adb73a4d5432bf66b43216467099b7296c18f15"
  end

  # FIXME
  resource "srfi-14" do
    url "https://anonymous@code.call-cc.org/svn/chicken-eggs/release/5/srfi-14/tags/0.2.1/"
    # NOTE: changes too often
    # sha256 "20d53ec0e628f0bba7a985fc9af6f8c43f67bd2fff106f0ed6cbd2d6cd56e8f1"
  end

  resource "srfi-13" do
    url "https://anonymous@code.call-cc.org/svn/chicken-eggs/release/5/srfi-13/tags/0.3.4/"
    # NOTE: changes too often
    # sha256 "027d7396823a47f21bb22f3e00667a832fa2263025e14ac35981518b419a91d5"
  end

  resource "srfi-69" do
    url "https://anonymous@code.call-cc.org/svn/chicken-eggs/release/5/srfi-69/tags/0.4.3/"
    # NOTE: changes too often
    # sha256 "38e0e92e07f1d03439bae9d02a9d3cd4bcd3dacd7abe1e1320765b2dcafa4b27"
  end

  resource "matchable" do
    url "https://anonymous@code.call-cc.org/svn/chicken-eggs/release/5/matchable/tags/1.2/"
    # NOTE: changes too often
    # sha256 "3c77ef6ad4891a5d932d298e2b4f5ac604aaa05c3b1a007207130d463b9c1a37"
  end

  def install
    system "make", "sexc"
    bin.install "sexc"
    doc.install "Readme.org"
  end

  test do
    (testpath/"simple.sex").write <<~SEX
    (include stdio.h)

    (pub fn main ((argc int) (argv [* char])) int
      (printf "2 + 2 = %d\n" (+ 2 2))
      (return 0))
    SEX

    system bin/"sexc", testpath/"simple.sex", "-o", "simple"
    output = shell_output("./simple")
    assert_match "2 + 2 = 4", output
  end
end
