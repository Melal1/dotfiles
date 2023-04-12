# Source aliases & Var 'the var in the aliases file'


source $HOME/.config/ZSH/aliases

# Enable colors and change prompt:
#PS1 stands for the default PROMPT in /private/etc/zshrc
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}M%{$fg[green]%}e%{$fg[blue]%}l%{$fg[yellow]%}a%{$fg[red]%}l%{$fg[magenta]%} %1~ %{$fg[red]%}]%{$fg[white]%}%b\n ➜ %{$reset_color%} "
PS1="%B${Red}[${Yellow}M${Green}e${Blue}l${Yellow}a${Red}l${Magenta} %1~ ${Red}]%b${White} ➜ ${Res}"

# History
HISTFILE=$ZSHdir/history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory


# Basic auto/tab complete:


autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.


#source ~/pkg/powerlevel10k/powerlevel10k.zsh-theme





#-----------------------------------------------------#
#      _____  _             _           
#     |  __ \| |           (_)          
#     | |__) | |_   _  __ _ _ _ __  ___ 
#     |  ___/| | | | |/ _` | | '_ \/ __|
#     | |    | | |_| | (_| | | | | \__ \
#     |_|    |_|\__,_|\__, |_|_| |_|___/
#                      __/ |            
#                     |___/             
#-----------------------------------------------------#



# source web search plugin
source $ZSHdir/plugins/web\ search.zsh

# source auto suggestion
source $ZSHdir/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# source Syntax-highlighting plugin, must be the last
source $ZSHdir/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# Start at startup 

