class Sabiql < Formula
  desc "Fast, driver-less TUI to browse, query, and edit PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  url "https://github.com/riii111/sabiql/archive/refs/tags/v1.8.1.tar.gz"
  sha256 "4e2a48d593ad6049beb452898b146b73c0a1e1564f92dbbe8e584f5e7dd7569a"
  license "MIT"

  bottle do
    root_url "https://github.com/riii111/homebrew-sabiql/releases/download/sabiql-1.8.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9f90a2dbf23661a934284710a23245830341cf45fd5ddc43464fd1e508131ba0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "184ec374c1c4dccc26f22815bcd88137168986c99c475fe1e9e17b1516301008"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a7957e401ff239e325cfa91802d050ac520acdb58663b6a41df8f6cd4f81ba40"
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
