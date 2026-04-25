class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.11.1.tar.gz"
  sha256 "e8f8194db8545f91e9b7fd3d31dbca8d41f18d89509b30525eec4ab82d4ab6b6"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.11.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a0cabd5e20f643b819598e0bf808b3234a4680c586381708446175831b181803"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f3572f885af35d954d3a7eaa1ed2738b77c53f620d2408a1a23224d1bd217114"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eb7c73eb5af7ca2fbde84df8262d09b867a2cd3730cda93b85c9f544701e23d3"
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
