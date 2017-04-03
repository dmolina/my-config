# my-config

My precious configuration (using Stow) of awesome and emacs. It appears that 
Stow have problems with Perl, but pystow from Marcel Kirschner works. 
https://github.com/marcelki, https://gist.github.com/marcelki

This configuration file contains:

## Emacs

- The configuration stored in submodule https://github.com/dmolina/config-emacs. 

- Configuration of reading emails using mbsync and msmtp.

- Several tools about latex in ~/bin.

## Awesome

Configuration of the awesome windows system.

- Several tools for detect monitors in ~/bin/.

## Zsh

Configuration of zsh with oh-my-zsh. 

- completion_waiting_dot. 

- theme: risto.

- plugins: vagrant, z, ag.

## TMux

Configuration of tmux:

- Change C-b by C-a (more accesible). 
- C-a | => Divide vertical.
- C-a - => Divide horizontal.
- S-<Arrow> => Move next and previous windows.
- C-<Arrow> => Change order windows.

Another useful options:

- C-a c => Create new window.
- C-a n => Move next-window.
- C-a p => Move previous-window.
- C-a w => Select window.
- C-a $ => Rename session.
- C-a o => Select previous panel.
- C-a <Arrows> => Select panel.
- C-a d => detach (to continue with tmux a -t session).

# Usage

	clone http://github.com/dmolina/my-config
	cd my-config
	
With gnu stow installed:

	stow emacs 
	stow awesome
	stow zsh
	
Otherwise, you can use:

	python pystow.sh emacs
	python pystow.sh awesome
	python zsh
	


