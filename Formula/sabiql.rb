class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.13.0.tar.gz"
  sha256 "277756214f6e1ec00d677503569adff9fbadcd6993190c9728443694faff9397"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.13.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9754ab7e237554f42cc0c2a9d2093f42204b377fe7097f54c95ac85aea9d8167"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f299ccaa3c8ce0eb32282d9dd158b65c0c244abd92fb63fdf242d4d1080f6773"
    sha256 cellar: :any,                 x86_64_linux:  "8911a4d4309b5a5bfc790dac51dbbef11352c30c569182e851469043113b7a23"
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
