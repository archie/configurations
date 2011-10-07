; Load my macros
(load-file "/home/archie/.emacs.d/macros.el")

; Load erlang mode
(setq load-path (cons  "/usr/local/lib/erlang/lib/tools-2.6.6.4/emacs"
		       load-path))
(setq erlang-root-dir "/usr/local/lib/erlang")
(setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
(require 'erlang-start)

