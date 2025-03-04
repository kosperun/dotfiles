# dotfiles

My dotfiles and configs.

I’ve tried several approaches to sync my dotfiles across machines—[chezmoi](https://www.chezmoi.io/), rsync, [git bare repo](https://www.atlassian.com/git/tutorials/dotfiles), etc.—but none really worked for me. In the end, I stuck with my old friend [meld](https://meldmerge.org/), and it’s been perfect. Just manually compare the dirs: `meld ~/.config/nvim ~/dotfiles/nvim`
