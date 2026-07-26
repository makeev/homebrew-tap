class AlphaiTui < Formula
  desc "Terminal stock dashboard: live quotes and charts plus AI-scored financial news and SEC Form 4 insider activity from AlphaAI"
  homepage "https://alphai.io"
  version "0.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.11.0/alphai-tui-aarch64-apple-darwin.tar.xz"
      sha256 "6cff9279f607bbb60ccf47a23478ad3fc1afe8071efebf250a2f9a1e811b6541"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.11.0/alphai-tui-x86_64-apple-darwin.tar.xz"
      sha256 "179182b26810efefa977bf5cf4843b759b824ca73c8f0cdce55605f16f8aa348"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.11.0/alphai-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d92e602c4bf0d7c1d61e9c9ae313976db0726546c0b216dcd92bd3468a2f6714"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.11.0/alphai-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "44261dafdc0cfd745faeee05d7d4bc0b58bfbbb7eb3172885cc856b9decb7c3e"
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
