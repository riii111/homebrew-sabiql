class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.8.0.tar.gz"
  sha256 "aadea37ba563f86bb7ba78b9a7d787dc30c926497c24520269d603de47c05e89"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.8.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cc1c9d24aae47dd678b31589f321294b942d36ca36eeb3255d8c94dc6d7d3317"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "af80271ca4b88e50660c5351821ed405c8dda27d079a2077f8ded56ce470e37c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c36eb83cd7211b75cad3392eb41dbb9a6167ddbaef454df107b501e9a70ceb46"
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
