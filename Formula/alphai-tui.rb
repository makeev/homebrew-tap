class AlphaiTui < Formula
  desc "Terminal stock dashboard: live quotes and charts plus AI-scored financial news and SEC Form 4 insider activity from AlphAI"
  homepage "https://alphai.io"
  version "0.30.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.30.0/alphai-tui-aarch64-apple-darwin.tar.xz"
      sha256 "c74403ff4e6050c40394eba80e51c316451775da05a29ae08f8336e5150a851e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.30.0/alphai-tui-x86_64-apple-darwin.tar.xz"
      sha256 "697bed1aa84c254b6ed1de9e94f1b5f70ad4d5422f739a341e9cb0638adfe3ce"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.30.0/alphai-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4fba8cd6f393fb37e0c0c15fe2fa822dcdadd7b415e823e7f29294a70aa0489e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.30.0/alphai-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c17c90ddb72ad83798b7b9fc1dbef746a89c4be099477b34530cfdcc15780cbc"
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
