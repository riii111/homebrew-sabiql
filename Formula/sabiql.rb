class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.6.2.tar.gz"
  sha256 "9ca6c0d50e967fdca2252dd0919deffaec78182be95048d3b282cde46e9835a3"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.6.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fcd8d7b96ee1b5742f0fcfd11dc789717e089d4665644d0952ef118ed59e5d32"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "461ece7bb0e84c58c44a00cd60169ebf82316a885da3adf9591af4691414cf65"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "94690cb86235cdb95671edaf4bd3cd163c7439d0a5579d2d97f57bb475df1bc5"
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
