class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.9.1.tar.gz"
  sha256 "57d97040a15c702334d191c0e688ed374a0e89a21f82bc269d1b0f2fa989fe15"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.9.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9a7e58dc9b03a6873fefc275251aa4597ef2d6884d7214b578984c375e82edca"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0807f00a42ef402be18f9385095409c2066a94255d0ef2ad3617ef8e0c55b8e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d057a25b104857f434a34c3b3aeb41f8665d8043c47372b4a7ede3ee9c9f4030"
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
