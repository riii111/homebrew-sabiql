class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.10.0.tar.gz"
  sha256 "08e43fb3a653db3660d55720ecf39cbbfd2d3e7e605a413dd2d0239d668ea74b"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.10.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "faf48bd463fa86d6005dab651ba0390571ae1ee264c58a83d6b8b086559345e2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e017fd663094332221a1e34ff689c39116d77c067e01f7b2d98c268724f2ad81"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3c9ca7f9778314bb47c0386e1c4f499b8d8baa4abc6d90b0bff4342608e6d904"
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
