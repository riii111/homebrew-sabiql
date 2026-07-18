class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.15.0.tar.gz"
  sha256 "0781f5847c8c475d860853cb4ad92cf73bbc76f3e25505ffa6538f6584d2ebd4"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.15.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f3f58422baf78653ed577ff3c8438d485ef672d3f5a67c5ba541d0a74081c4f5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "118c5755c0a0935d0c88e9df7a4f8345528bba889b41e0a959b2c1234363c69c"
    sha256 cellar: :any,                 x86_64_linux:  "e5f7679d55bb37ad0fa6471f8edb2a74ba859209216aaeb66f0741ba19d1d5df"
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
