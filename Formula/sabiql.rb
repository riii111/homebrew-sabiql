class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.12.3.tar.gz"
  sha256 "7769a813100a6c482d73a5fabc4de655a27b1d539c43853ab8e7f8f1cb2b82c8"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.12.3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "74beb9775aa721838bd865ed1165675f4d3e65258fb0edaaaa911b2358cb301e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "70446aab1f670ebfdfc5fa728bed7b747d0db50dc9f75286c2f4f7c7bb796bcd"
    sha256 cellar: :any,                 x86_64_linux:  "2b1ffa0ce29c4e58b8ba1c2146f471b364f4a05bb7e5a83e84ddd81d4d1674ac"
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
