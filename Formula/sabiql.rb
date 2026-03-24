class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.9.0.tar.gz"
  sha256 "53885247b970eb72d3649d49f80b08b90fc5518822ae4a422ee15ebc285f78b7"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.9.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "25ac6f181066880858fe897afc0e2456146d2c591961a3412f1b29e51cea4b17"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "af4927f9c1887b49f3f962110416c4498624b2984c798a7fb62f26330675f97b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "490dc43c03fe2066cb17bdec8fa5ca9bda02e69a502afc809e7a7b13ab55456d"
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
