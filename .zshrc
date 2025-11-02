#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|
#

# You can define your custom configuration by adding
# files in ~/.config/zshrc
# or by creating a folder ~/.config/zshrc/custom
# with copies of files from ~/.config/zshrc
# -----------------------------------------------------

# -----------------------------------------------------
# Load modular configarion
# -----------------------------------------------------

for f in ~/.config/zshrc/*; do
    if [ ! -d $f ] ;then
        c=`echo $f | sed -e "s=.config/zshrc=.config/zshrc/custom="`
        [[ -f $c ]] && source $c || source $f
    fi
done

# -----------------------------------------------------
# Load single customization file (if exists)
# -----------------------------------------------------


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/usr/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#@if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
 #   if [ -f "/usr/etc/profile.d/conda.sh" ]; then
 #       . "/usr/etc/profile.d/conda.sh"
 #   else
#        export PATH="/usr/bin:$PATH"
 #   fi
#fi
#unset __conda_setup
# <<< conda initialize <<<
