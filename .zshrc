# /etc/zshrc ou ~/.zshrc
# Fichier de configuration principal de zsh
# Formation Debian GNU/Linux par Alexis de Lattre
# http://www.via.ecp.fr/~alexis/formation-linux/

#
# 1. Les alias
#

#  Gestion du ls : couleur + touche pas aux accents
alias ls='ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable'

# Demande confirmation avant d'�craser un fichier
#alias cp='cp --interactive -v'
alias mv='mv --interactive -v'
alias rm='rm --interactive -v'
alias grep='grep --color=auto'

# Raccourcis pour 'ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

# Quelques alias pratiques
alias c='clear'
alias less='less --quiet'
alias s='cd ..'
alias df='df --human-readable'
alias du='du --human-readable'

#Logs
alias sys='tail -f /var/log/syslog'
alias msg='tail -f /var/log/messages'

#ScreenSaver
alias wait_='watch cat /proc/meminfo'



#ZS:
alias ZS_PREPARE="python ~/ZephyTOOLS/ZephyTOOLS/UPDATE/PREPARE.py"
alias ZS_UPDATE="python ~/ZephyTOOLS/ZephyTOOLS/UPDATE/UPDATE.py"
alias ZS_CLEAN="rm ~/ZephyTOOLS/APPLI/TMP/* ; python ~/ZephyTOOLS/ZephyTOOLS/UPDATE/UPDATE.py"
alias zs_prepare="python ~/ZephyTOOLS/ZephyTOOLS/UPDATE/PREPARE.py"
alias zs_update="python ~/ZephyTOOLS/ZephyTOOLS/UPDATE/UPDATE.py"
alias zs_clean="rm ~/ZephyTOOLS/APPLI/TMP/* ; python ~/ZephyTOOLS/ZephyTOOLS/UPDATE/UPDATE.py"
alias ZEPHYDEV="env UBUNTU_MENUPROXY=0 python ~/ZephyTOOLS/APPLI/BIN/MAIN.pyc"
alias zephydev="env UBUNTU_MENUPROXY=0 python ~/ZephyTOOLS/APPLI/BIN/MAIN.pyc"









#
# 2. Prompt et D�finition des touches
#

# exemple : ma touche HOME, cf man termcap, est codifiee K1 (upper left
# key on keyboard) dans le /etc/termcap. En me referant a l'entree
# correspondant a mon terminal (par exemple 'linux') dans ce fichier, je
# lis : K1=\E[1~, c'est la sequence de caracteres qui sera envoyee au
# shell. La commande bindkey dit simplement au shell : a chaque fois que
# tu rencontres telle sequence de caractere, tu dois faire telle action.
# La liste des actions est disponible dans "man zshzle".

# Un charset fran�ais
#export LESSCHARSET="latin1"

#export LD_LIBRARY_PATH=/usr/lib:/usr/local/lib

# Correspondance touches-fonction
bindkey '^A'    beginning-of-line       # Home
bindkey '^E'    end-of-line             # End
bindkey '^D'    delete-char             # Del
bindkey '[3~' delete-char             # Del
bindkey '[2~' overwrite-mode          # Insert
bindkey '[5~' history-search-backward # PgUp
bindkey '[6~' history-search-forward  # PgDn
autoload colors ; colors
# Prompt couleur (la couleur n'est pas la m�me pour le root et
# pour les simples utilisateurs)
LASTCMD="%B%(?.%{$fg[white]$bg[green]%} Ok .%{$fg[white]$bg[red]%} Failed: %? % )%{$reset_color%}%b"
if [ "`id -u`" -eq 0 ]; then
  export PS1="%{[33;33;1m%}%T%{[0m%} %{[33;31;1m%}%n%{[0m[33;33;1m%}@%{[33;37;1m%}%m %{[33;32;1m%}%~%{[0m[33;33;1m%}%#%{[0m%} "
  export RPS1=$LASTCMD
else
  export PS1="%{[33;33;1m%}%T%{[0m%} %{[33;34;1m%}%n%{[0m[33;33;1m%}@%{[33;37;1m%}%m %{[33;32;1m%}%~%{[0m[33;33;1m%}%#%{[0m%} "
  #export PS1=""
fi

# Console linux, dans un screen ou un rxvt
if [ "$TERM" = "linux" -o "$TERM" = "screen" -o "$TERM" = "rxvt" ]
then
  # Correspondance touches-fonction sp�cifique
  bindkey '[1~' beginning-of-line       # Home
  bindkey '[4~' end-of-line             # End
fi

# xterm
if [ "$TERM" = "xterm" ]
then
  # Correspondance touches-fonction sp�cifique
  bindkey '[H'  beginning-of-line       # Home
  bindkey '[F'  end-of-line             # End
fi

# Gestion de la couleur pour 'ls' (exportation de LS_COLORS)
if [ -x /usr/bin/dircolors ]
then
  if [ -r ~/.dir_colors ]
  then
    eval "`dircolors ~/.dir_colors`"
  elif [ -r /etc/dir_colors ]
  then
    eval "`dircolors /etc/dir_colors`"
  fi
fi

#
# 3. Options de zsh (cf 'man zshoptions')
#

# Je ne veux JAMAIS de beeps
unsetopt beep
unsetopt hist_beep
unsetopt list_beep
	# >| doit �tre utilis�s pour pouvoir �craser un fichier d�j� existant ;
	# le fichier ne sera pas �cras� avec '>'
	# unsetopt clobber
	# Ctrl+D est �quivalent � 'logout'
	unsetopt ignore_eof
	# Affiche le code de sortie si diff�rent de '0'
	setopt print_exit_value
	# Demande confirmation pour 'rm *'
	unsetopt rm_star_silent
	# Correction orthographique des commandes
	# D�sactiv� car, contrairement � ce que dit le "man", il essaye de
	# corriger les commandes avant de les hasher
	#setopt correct

	# Sch�mas de compl�tion

	# - Sch�ma A :
	# 1�re tabulation : compl�te jusqu'au bout de la partie commune
	# 2�me tabulation : propose une liste de choix
	# 3�me tabulation : compl�te avec le 1er item de la liste
	# 4�me tabulation : compl�te avec le 2�me item de la liste, etc...
	# -> c'est le sch�ma de compl�tion par d�faut de zsh.

	# Sch�ma B :
	# 1�re tabulation : propose une liste de choix et compl�te avec le 1er item
	#                   de la liste
	# 2�me tabulation : compl�te avec le 2�me item de la liste, etc...
	# Si vous voulez ce sch�ma, d�commentez la ligne suivante :
	#setopt menu_complete

	# Sch�ma C :
	# 1�re tabulation : compl�te jusqu'au bout de la partie commune et
	#                   propose une liste de choix
	# 2�me tabulation : compl�te avec le 1er item de la liste
	# 3�me tabulation : compl�te avec le 2�me item de la liste, etc...
	# Ce sch�ma est le meilleur � mon go�t !
	# Si vous voulez ce sch�ma, d�commentez la ligne suivante :
	unsetopt list_ambiguous
	# (Merci � Youri van Rietschoten de m'avoir donn� l'info !)

	# Options de compl�tion
	# Quand le dernier caract�re d'une compl�tion est '/' et que l'on
	# tape 'espace' apr�s, le '/' est effa��
	setopt auto_remove_slash
	# Fait la compl�tion sur les fichiers et r�pertoires cach�s
	setopt glob_dots

# Traite les liens symboliques comme il faut
setopt chase_links

# Quand l'utilisateur commence sa commande par '!' pour faire de la
# compl�tion historique, il n'ex�cute pas la commande imm�diatement
# mais il �crit la commande dans le prompt
setopt hist_verify
# Si la commande est invalide mais correspond au nom d'un sous-r�pertoire
# ex�cuter 'cd sous-r�pertoire'
setopt auto_cd
# L'ex�cution de "cd" met le r�pertoire d'o� l'on vient sur la pile
setopt auto_pushd
# Ignore les doublons dans la pile
setopt pushd_ignore_dups
# N'affiche pas la pile apr�s un "pushd" ou "popd"
setopt pushd_silent
# "pushd" sans argument = "pushd $HOME"
setopt pushd_to_home

# Les jobs qui tournent en t�che de fond sont nic� � '0'
unsetopt bg_nice
# N'envoie pas de "HUP" aux jobs qui tourent quand le shell se ferme
unsetopt hup

#
# 4. Param�tres de l'historique des commandes
#

# Nombre d'entr�es dans l'historique
export HISTORY=1000
export SAVEHIST=1000
# Fichier o� est stock� l'historique
export HISTFILE=$HOME/.history

#export SSH_AUTH_SOCK="`ls -d /tmp/ssh-*`""`ls /tmp/ssh-* | head -n1`"
#export SSH_AGENT_PID=

#
# 5. Compl�tion des options des commandes
#

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' use-compctl false

autoload -U compinit
compinit
