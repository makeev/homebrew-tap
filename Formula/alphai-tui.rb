class AlphaiTui < Formula
  desc "Terminal stock dashboard: live quotes and charts plus AI-scored financial news and SEC Form 4 insider activity from AlphAI"
  homepage "https://alphai.io"
  version "0.45.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.45.0/alphai-tui-aarch64-apple-darwin.tar.xz"
      sha256 "7508fbec782db2f1b8143abe840f3ffbe328ec3efd2b1d8eebfdae23e47c5a98"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.45.0/alphai-tui-x86_64-apple-darwin.tar.xz"
      sha256 "d13d38925e4c0f59a216983903a199b7f779154b60ec4e797d571a8f10a30789"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.45.0/alphai-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a4da40784d13fc8d56f7c1bd21da1bcf3dd00b3cd8e85edaf67bf01e86a4b980"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.45.0/alphai-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eb1a2e96a383408a8bf093d33505c08c727892fcef6234360a2d38ec76590298"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "alphai-tui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "alphai-tui"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "alphai-tui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "alphai-tui"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
