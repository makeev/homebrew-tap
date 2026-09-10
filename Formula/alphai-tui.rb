class AlphaiTui < Formula
  desc "Terminal stock dashboard: live quotes and charts plus AI-scored financial news and SEC Form 4 insider activity from AlphaAI"
  homepage "https://alphai.io"
  version "0.20.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.20.0/alphai-tui-aarch64-apple-darwin.tar.xz"
      sha256 "2549f12275edc3b7a66c9f04a35ee49646580b08a86b236a7f9eb5b00461f07d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.20.0/alphai-tui-x86_64-apple-darwin.tar.xz"
      sha256 "e85c2574740278105837ebf8b9c0e599a3d8fa7e8efe1bf20c1d5ec6b7a87ae4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.20.0/alphai-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4948c63bc93c73d448db15e98649152aad36d9d175d225f87a0df1d950b7b17f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.20.0/alphai-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2f46c4a1caf5e18cc581d1922978cc8ed62e0f46dea2d16ec9894877bd924fe7"
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
