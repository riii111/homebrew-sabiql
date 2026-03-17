class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.8.2.tar.gz"
  sha256 "7aa0f768edfb76456f38b9854c22c099c2b4a95d7c2519b8a659df6d255a6360"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.8.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "828329bf73d19af7fef886f024f8bec15916848ddd5911deb9ceadc3625e314c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "49645a2fcd026f22403ddb238b6b6ea1ea400198cbe582b26f879e55dfdd335f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a658edcab75a31c9bd3be7c9a28841dbd3203d72d12d544aaa2ea8154aa375cd"
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
