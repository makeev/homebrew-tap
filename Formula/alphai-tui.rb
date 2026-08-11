class AlphaiTui < Formula
  desc "Terminal stock dashboard: live quotes and charts plus AI-scored financial news and SEC Form 4 insider activity from AlphaAI"
  homepage "https://alphai.io"
  version "0.13.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.13.0/alphai-tui-aarch64-apple-darwin.tar.xz"
      sha256 "bb1cce4e20d872584dc8dfd5ea4305e5debf0fa441e73424f072b65416d3c96b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.13.0/alphai-tui-x86_64-apple-darwin.tar.xz"
      sha256 "9cc59c08b8f6bd53e153ce40b5939ebe57d48637377d6f58dd387a621941128c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.13.0/alphai-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1d9275f28d2ada1392e08b4506c810a9a2ef0e00436ccc14a85aaa7b1da04e54"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.13.0/alphai-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1e32eccf855c0743ef2173d10d78712f8fc2b14fcdaf3efd7fdbc2b5df0292da"
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
