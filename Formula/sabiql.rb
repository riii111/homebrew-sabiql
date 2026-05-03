class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.12.0.tar.gz"
  sha256 "9584543aa544e2b4a87cc0eecdd47313eab619a7cf2a5a2a62d322821ffe343c"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.12.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6b8edfc0a5949a32f00e39fef490a4b27a8874348e8db2414fe4d3c570719513"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8cc7e4f1c8c6f6c8c98f2471120a06ca1541af220a6ef01dea4016c4f29ec0de"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "de2a3cd257e0d3bc126577e905c800d6d6a263d5a2ec3cb03c83b42c54a25b49"
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
