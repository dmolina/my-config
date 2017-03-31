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
	


