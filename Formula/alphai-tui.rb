class AlphaiTui < Formula
  desc "Terminal stock dashboard: live quotes and charts plus AI-scored financial news and SEC Form 4 insider activity from AlphaAI"
  homepage "https://alphai.io"
  version "0.16.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.16.0/alphai-tui-aarch64-apple-darwin.tar.xz"
      sha256 "15fbea596ec4e57ade85c19c86cf58088b648bc7fd2c57e2a93bb8eccb05374f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.16.0/alphai-tui-x86_64-apple-darwin.tar.xz"
      sha256 "125f7ce51973fb8f684012ee0ce44403823aa339e3bfaa06a12cc721cea677ed"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.16.0/alphai-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b8189ed390d3743756bd2b637c0284ad4048452385256c5a9ea60d3423f74542"
    end
    if Hardware::CPU.intel?
      url "https://github.com/makeev/alphai-tui/releases/download/v0.16.0/alphai-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b20d0619d61dc6c99ecc576d70de4f70c2801dbafc5d586794955ae1f8770fa4"
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
