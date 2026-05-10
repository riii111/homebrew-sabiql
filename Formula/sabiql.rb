class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.12.2.tar.gz"
  sha256 "85331e44e260c26ce0b9ebea8b00f9282c34be11f977c0095dfd8a1d392d5c81"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.12.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "48f5fc40370c7c1ba0fe37b8d400d76be3c6cff88fe745907231ae271fda715b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "73f903ee68e40cf397da5b88849ffd3c24754612e291ada1f476dd4780ab3bc3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5e2c3e48dda46ef0eabb952e4494d0046038b047ace81fecc5c4ef8129dfb5a1"
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
