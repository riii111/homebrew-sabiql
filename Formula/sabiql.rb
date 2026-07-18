class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.15.1.tar.gz"
  sha256 "815ca7c5ab6be3d00c0c7a73d4470cb26969c496564259b882dad24ef8397809"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.15.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "032fe5ef1bd5608789d4e48058d3b92c60973cc433bcdebd171c57f3fc9a781e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1d86ec71155cf9494dd341c75621e3590316d844575c1be850f3252aa917efa9"
    sha256 cellar: :any,                 x86_64_linux:  "fa1de0849190bfb435fe21d3413aeff7cd7c210a1752deb30a918376e729071f"
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
