class AlphaiTui < Formula
  desc "Terminal stock dashboard: live quotes and charts plus AI-scored financial news and SEC Form 4 insider activity from AlphaAI"
  homepage "https://alphai.io"
  version "0.12.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.12.0/alphai-tui-aarch64-apple-darwin.tar.xz"
      sha256 "d9573e4cafd9a98852a669da9bcf6381218a8e9d39ee6e5993568399b2ef15f9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.12.0/alphai-tui-x86_64-apple-darwin.tar.xz"
      sha256 "578ed9935ffc3b85a0b6985775fdeadd02d7f1f911e8e7bb19c6a6207a486cd2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.12.0/alphai-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8e71b0e83f4d786d3ebb09158aab4b6520566406e1611ecebd4f961066208170"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.12.0/alphai-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "82d19bb00554a76b74141e6223cca18ec7930db7688c0fcc63155a564bf1ff67"
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
