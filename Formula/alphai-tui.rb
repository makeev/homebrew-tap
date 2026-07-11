class AlphaiTui < Formula
  desc "Terminal stock dashboard: quotes, charts, AI-scored news and insider activity"
  homepage "https://alphai.io"
  version "0.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/makeev/alphai-tui/releases/download/v0.7.0/alphai-tui-aarch64-apple-darwin.tar.xz"
      sha256 "ec8f4bf3813fa51133e1737ec67b9820b1a0e0a281df5186dd13ca2496b6c96f"
    end
    on_intel do
      url "https://github.com/makeev/alphai-tui/releases/download/v0.7.0/alphai-tui-x86_64-apple-darwin.tar.xz"
      sha256 "0e421ae9d1161eae78a6819d0fe7ae70cf0de5d5dd7a85ac32005bf934d644d0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/makeev/alphai-tui/releases/download/v0.7.0/alphai-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "70fa960547b7b21eeaf6d195cbf83ba571c93eabef05581fa42e0610803366ac"
    end
    on_intel do
      url "https://github.com/makeev/alphai-tui/releases/download/v0.7.0/alphai-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6525536b2bebacf0e4e5fb201c8324a1618f610f686a24099889e9f675e81f75"
    end
  end

  def install
    bin.install "alphai-tui"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/alphai-tui --version")
  end
end
