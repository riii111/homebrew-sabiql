class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.7.0.tar.gz"
  sha256 "7f77191ce22003d7cb41f2c4824ae3a1e8d03c28992d28293880e733198ade23"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.7.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8a4ac5a5d84f6ccc2a2b622a50da28c4bc95b0a01207290c51e35643a57f7312"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "be813c1fc0bc19bc2f4c5af074acfded17363731e92fe0c255f151047a5b93ea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c99739cf827eb05915bd79cba42b58a62f5d7e3187a9149cc4bafef0e4499bb3"
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
