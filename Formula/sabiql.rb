class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v3.0.0.tar.gz"
  sha256 "fa1a8edf3ec0b653d56c802a155dbb4b30be0f31f42b72b26f4ea1898dfa488a"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-3.0.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "60e67c58101adcd9b99eb23270da9318301e102c5c7432e19d6202c31092aecd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9ed287634818246ab25e1231a7d1ab8b66adc742c0248299f5233d036ec16850"
    sha256 cellar: :any,                 x86_64_linux:  "2f0b13ab9be0c003646b396b8d22ad8fd8b6b8d584a44056e54ed8011bb8546c"
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
