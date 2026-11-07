class Irsty < Formula
  desc "A modern, keyboard-driven terminal IRC client"
  homepage "https://gawbul.github.io/irsty/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gawbul/irsty/releases/download/v0.1.0/irsty-aarch64-apple-darwin.tar.xz"
      sha256 "ee698a709cc46c754511308fe5bee03cbc4d699c5f423c57fa449ccfc700189d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gawbul/irsty/releases/download/v0.1.0/irsty-x86_64-apple-darwin.tar.xz"
      sha256 "b61b9941022e37518dc0448bc85b465a69d9a945781c2337aac1e41c40ec6a2e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gawbul/irsty/releases/download/v0.1.0/irsty-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "011fd3dbe9869444a6d4e6d4092fb7eef8abf68651a3e22c8bb327b38a6df835"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gawbul/irsty/releases/download/v0.1.0/irsty-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "abcf78519f1cd477014474489a62aac8164782144e9804bbc0fb8259e99ee5fb"
    end
  end
  license "Apache-2.0"

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
      bin.install "irsty"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "irsty"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "irsty"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "irsty"
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
