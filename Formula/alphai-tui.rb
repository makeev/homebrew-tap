class AlphaiTui < Formula
  desc "Terminal stock dashboard: live quotes and charts plus AI-scored financial news and SEC Form 4 insider activity from AlphaAI"
  homepage "https://alphai.io"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.9.0/alphai-tui-aarch64-apple-darwin.tar.xz"
      sha256 "d614a848908ea8391f8b34aef54f6e61983667ba8140c8fff6edd33ad2067bf0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.9.0/alphai-tui-x86_64-apple-darwin.tar.xz"
      sha256 "b17fe4f426b4f1bf2554e1f4116dca6fd4c7e54c722b066551f09d5766b6d6f6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.9.0/alphai-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "231028f998db15bf40287e53e6dc2560625a95fe45ed02e215ee87dd786bbb29"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.9.0/alphai-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4949fd2ab752c69bfd164f95879bf2ca76c7f5276701bce84d234c2f3a39344b"
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
