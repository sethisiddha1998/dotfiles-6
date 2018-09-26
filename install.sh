#!/usr/bin/env bash

if ! [[ $(command -v stow) ]] || ! [[ $(command -v git) ]]; then
    echo -e "\e[31mYou need to have GNU stow and git installed.\nExiting..."
    exit 1
fi

echo -e "\e[34m"
echo '.___                   __           .__   .__   .__'
echo '|   |  ____    _______/  |_ _____   |  |  |  |  |__|  ____     ____'
echo '|   | /    \  /  ___/\   __\\__  \  |  |  |  |  |  | /    \   / ___\'
echo '|   ||   |  \ \___ \  |  |   / __ \_|  |__|  |__|  ||   |  \ / /_/  >'
echo '|___||___|  //____  > |__|  (____  /|____/|____/|__||___|  / \___  /'
echo '          \/      \/             \/                      \/ /_____/'
echo '________             __     _____ .__ .__'
echo '\______ \    ____  _/  |_ _/ ____\|__||  |    ____    ______'
echo ' |    |  \  /  _ \ \   __\\   __\ |  ||  |  _/ __ \  /  ___/'
echo ' |    `   \(  <_> ) |  |   |  |   |  ||  |__\  ___/  \___ \ '
echo '/_______  / \____/  |__|   |__|   |__||____/ \___  >/____  >'
echo '        \/                                       \/      \/'
echo ' '
echo ' /\  /\  /\ '
echo ' \/  \/  \/ '
echo -e "\e[0m "

sleep 1

echo -e "\e[32mCloning oh-my-zsh into: \e[34m$HOME/.oh-my-zsh\e[0m"
git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
echo -e "\e[32mDone.\n\e[0m"

echo -e "\e[32mCloning zsh-syntax-highlighting into: \
    \e[34m$HOME/.zsh-syntax-hihghlighting\e[0m"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
	$HOME/.zsh-syntax-highlighting
echo -e "\e[32mDone.\n\e[0m"


cd $HOME/.dotfiles

echo -e "Automatically create symlinks via GNU Stow? (1/2)."

select choice in "Yes" "No"; do
    case $choice in
        "Yes" )
            if [[ "$(uname)" == "Linux" ]]; then
                stow homedir
                stow config
            else if [[ "$(uname)" == "Darwin" ]]; then
                if [[ ! -d $HOME/.config ]]; then
                    mkdir -p $HOME/.config/                
                fi
                ln -s $HOME/.dotfiles/config/.config/zsh $HOME/.config/zsh
                ln -s $HOME/.dotfile/homedir/.zshrc $HOME/.zshrc
            break
            ;;
        "No" )
            echo -e "Okay. Going on...\n"
            break
            ;;
        "*" )
            echo -e "\e[31mWrong input. Try again.\e[0m"
    esac
done

echo -e "Want to install Vim config too? (1/2)."

select choice in "Yes" "No"; do
    case $choice in
        "Yes" )
            cd $HOME
            git clone --recursive https://github.com/oliverwigers/vim_config \
                .vim
            cd $HOME/.vim
            stow vimrc
            echo -e "\e[32mDone installing Vim config..\n\e[0m"
            break
            ;;
        "No" )
            echo -e "Okay. Going on...\n"
            break
            ;;
        "*" )
            echo -e "\e[31mWrong input. Try again.\e[0m"
    esac
done

echo -e "Want to install .tmuxist too? (1/2)."

select choice in "Yes" "No"; do
    case $choice in
        "Yes" )
            cd $HOME
            git clone --recursive https://github.com/chrootzius/.tmuxist \
                .tmuxist
            cd $HOME/.tmuxist
            stow tmux
            echo -e "\e[32mDone installing Tmux config..\n\e[0m"
            break
            ;;
        "No" )
            echo -e "Okay. Going on...\n"
            break
            ;;
        "*" )
            echo -e "\e[31mWrong input. Try again.\e[0m"
    esac
done

echo -e "\e[32mFinally done.\e[0m\n"