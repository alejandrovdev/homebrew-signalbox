class Signalbox < Formula
  desc "Lanes for parallel Claude Code sessions in git worktrees"
  homepage "https://github.com/alejandrovdev/signalbox"
  url "https://github.com/alejandrovdev/signalbox.git",
      tag:      "v0.1.0",
      revision: "af088b09671ba4bafb8c8bff01d46460b68ab951"
  head "https://github.com/alejandrovdev/signalbox.git", branch: "main"

  depends_on "gh"
  depends_on "git"
  depends_on :macos
  depends_on "python@3.15"

  def python
    formula_opt_bin("python@3.15")/"python3.15"
  end

  def install
    libexec.install "signalbox"
    # -I keeps the person's PYTHONPATH and site packages out.
    (bin/"signalbox").write <<~SH
      #!/bin/sh
      exec "#{python}" -I -c 'import sys; sys.path.insert(0, sys.argv.pop(1)); from signalbox.cli import main; sys.exit(main(sys.argv[1:]))' "#{libexec}" "$@"
    SH
  end

  def caveats
    <<~EOS
      Set up once (it installs the Claude Code hooks), then link each repository from its folder:
        signalbox setup
        cd ~/path/to/repository && signalbox init
      The merge lane and the pull request data need gh signed in:
        gh auth login
    EOS
  end

  test do
    assert_match "signalbox", shell_output("#{bin}/signalbox --version")
    ENV["SIGNALBOX_CONFIG"] = testpath/"config.toml"
    ENV["SIGNALBOX_LOG_DIR"] = testpath/"logs"
    ENV["SIGNALBOX_CACHE_DIR"] = testpath/"cache"
    ENV["SIGNALBOX_CLAUDE_SETTINGS"] = testpath/"settings.json"
    assert_match "no linked project", shell_output("#{bin}/signalbox status 2>&1", 1)
  end
end
