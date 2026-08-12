class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "148f412dfe1233f2128dd08ef11aef43f90b9a088e6d3477683074b234e54f7c"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-2.0.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d0fee76d3e433dc12fc5a6f3f95a89c62e046f4d0c79a42fd39aa45ff055d888"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "89ec16dec80e7fb33f65d4d5256f7a6e31d51d76cff53bd56c111f9e1ad89e55"
    sha256 cellar: :any,                 x86_64_linux:  "566080bb666450aec25dbece01d3b266da9b1af1901a61d9360964a20bfff3d9"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--no-default-features", *std_cargo_args
  end

  def caveats
    <<~EOS
      sabiql requires the psql CLI in your PATH.
      To install psql without the full PostgreSQL server:
        brew install libpq && brew link --force libpq
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sabiql --version")
    output = shell_output("#{bin}/sabiql update 2>&1", 1)
    assert_match "brew upgrade sabiql", output
  end
end
