class AlphaiTui < Formula
  desc "Terminal stock dashboard: live quotes and charts plus AI-scored financial news and SEC Form 4 insider activity from AlphaAI"
  homepage "https://alphai.io"
  version "0.10.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.10.0/alphai-tui-aarch64-apple-darwin.tar.xz"
      sha256 "5c6fdc0018668b2a5aa00654abe4a664f71e0944e7d9a141b85c53a10eff8d22"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.10.0/alphai-tui-x86_64-apple-darwin.tar.xz"
      sha256 "55901f3c80dc476d12c5594f95d6ae967de58339baabecc659b8d03e16bf55f7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.10.0/alphai-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "876649baaf0c603d7e24011e56a84768ceebdbda61b92e53520df32076e823bd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.10.0/alphai-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bfec846f666621b1aebf6ebcc9bac74991cba12f7d543c36c0500241c8822a12"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "alphai-tui" if OS.mac? && Hardware::CPU.arm?
    bin.install "alphai-tui" if OS.mac? && Hardware::CPU.intel?
    bin.install "alphai-tui" if OS.linux? && Hardware::CPU.arm?
    bin.install "alphai-tui" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
