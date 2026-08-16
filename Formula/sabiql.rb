class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "6e0fe05a98f0f7f7e1391894ec0600c36a2218195ed90b80db52bf1e7640c858"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-2.0.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4f7fd51457c1dd953d5885065aa5daa26c5c9e9c22eca9bee21518b15de0bec3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bcd34d42f3e9c88f25420cb37e132184c8295a9f931d4677f5e6a245f30dc648"
    sha256 cellar: :any,                 x86_64_linux:  "682b71c268b135cd87529e2a8dbd70b826a662a97e42694f496b964f6c8804b8"
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
