class AlphaiTui < Formula
  desc "Terminal stock dashboard: live quotes and charts plus AI-scored financial news and SEC Form 4 insider activity from AlphaAI"
  homepage "https://alphai.io"
  version "0.10.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.10.1/alphai-tui-aarch64-apple-darwin.tar.xz"
      sha256 "9516c0ea2d0743e5df3f11dfbdc117789b671d860b2d8a20c87f964ad4ab0b8f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.10.1/alphai-tui-x86_64-apple-darwin.tar.xz"
      sha256 "8db298dcf838c8a66decb7a93c0fd0d54a10e009e1b5a35e59e0b58b81c5cee8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.10.1/alphai-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "149cdf3b67a644ea918b5457afd2b8ca99797bf1fe1b41a13e6377ab26dc58ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.10.1/alphai-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "832fb5a53e18f6f6695ec4413c9b0c1d8ecb0a76996be9f5f6b77a194ca35d08"
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
