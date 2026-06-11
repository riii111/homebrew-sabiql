class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.12.4.tar.gz"
  sha256 "c8de454fa5facdfdaee5bd0fd5af27c7dfcf39ba6db8b4e1429e96a5efbb5299"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.12.4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7b16affc5275e760687d0011f4817dcb5fb5d52a602a794ddb5288ae43722735"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8253824bcd0706952dc035bd8a7ece8d006c275ab91e58c1acd0bce8058e8bf4"
    sha256 cellar: :any,                 x86_64_linux:  "88047c3f0006cb2d68d41340f2c5934e7c3e2062f4603187c03c1eec577e4136"
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
