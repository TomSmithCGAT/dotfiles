alias h='history'

alias less='less -XF'

alias dev='cd ~/git_repos/cgat'
alias pipe='cd ~/git_repos/CGATPipelines'
alias umi='cd ~/UMI-tools'

# think wizard of Oz...
alias heels='echo -e "\n\nClicking heels...\n\n"; ssh -X toms@cgatui.imm.ox.ac.uk'

alias la='ls -A'
alias l='ls -CF'
alias lk='ls -kSr'
alias lt='ls -tr'

alias www='echo -e "\nWHAT WENT WRONG?..\n"; tail -20 pipeline.log'

alias hm='du -sh'

alias cleanout='rm -rf ctmp* pipeline.log nohup.out'

alias setup='mkdir raw; mkdir shared_files; mkdir notebooks; mkdir results; mkdir results/plots'
