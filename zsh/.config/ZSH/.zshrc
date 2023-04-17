# Source aliases & Var 'the var in the aliases file'


source $HOME/.config/ZSH/aliases


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




# add PATH
export PATH="$HOME/.local/bin":$PATH


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


# -- Prompt Theme -- #


source $ZSHdir/themes/old2

# Start at startup 
