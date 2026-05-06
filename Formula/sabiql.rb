class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.12.1.tar.gz"
  sha256 "e3057872f853963ff981640459971d420d4607913601a15b2e59826877f08f0d"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.12.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e6281005e0faf78271c2536bfd3aaf3aaafb43466f0d88c77f9c841d6f678c66"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c49d112c90cfab59116032e2124f15aa4e060b318be013fd99ab97356661882b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "223cd075de74d515ed0d962511e2b6d883333bece4cca3737d494fba62a8e5ff"
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
