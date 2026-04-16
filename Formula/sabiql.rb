class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "039d4782d8c4243cacc69e563010b2cfaacb440deb77428e275be6e6d8ca8855"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.11.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "170950b6f6a7145c79f877986f5c49059d3f8763f503e988fa5fd1782446b90f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f6646c37e65f7bc672b242ee75cdde00fc46e5f9ddffb67f151ee74c60861414"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5d97b6a9b74d43e10f267a1c71d5e3a9fc2c741d283b7047ab1565bec6a3b5fc"
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
