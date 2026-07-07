class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.14.0.tar.gz"
  sha256 "a2c20ad15db927a05cb56273654e650e1e384cc217880ca5eec348af2dc3659b"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.14.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c02666060dc39cee3824c41e1f1ac5c29e5721e7277f6a0285c67ddcdb96a56f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d701d99190db06e2d6dce863af15e714b70db3a65fc4785574e9618d76527a49"
    sha256 cellar: :any,                 x86_64_linux:  "7c2aa72e961c3e791b5aa71e19d0bf3d8cacb034a04bc711a9bbed26748ad7f4"
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
