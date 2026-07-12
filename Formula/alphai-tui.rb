class AlphaiTui < Formula
  desc "Terminal stock dashboard: quotes, charts, AI-scored news and insider activity"
  homepage "https://alphai.io"
  version "0.8.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/makeev/alphai-tui/releases/download/v0.8.0/alphai-tui-aarch64-apple-darwin.tar.xz"
      sha256 "cb084ab8b0d9c588742d47c6a68f9921f6db49d229bf0d3b94ca278509b48b70"
    end
    on_intel do
      url "https://github.com/makeev/alphai-tui/releases/download/v0.8.0/alphai-tui-x86_64-apple-darwin.tar.xz"
      sha256 "082317ac421a36415f9bda1d14fc5c1776acae57e2b1b44466bf33c20b510292"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/makeev/alphai-tui/releases/download/v0.8.0/alphai-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b86ec3a5e13777cf31ac043c735e833675fca3c5e4cfd601ace528a5e281e62e"
    end
    on_intel do
      url "https://github.com/makeev/alphai-tui/releases/download/v0.8.0/alphai-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eaea9357b45b15a6ff1fe79a8ed16ece63869ea21b037297c833c34a60c1635c"
    end
  end

  def install
    bin.install "alphai-tui"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/alphai-tui --version")
  end
end
