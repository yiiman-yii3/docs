#!/bin/bash
#
# @Author amintado@gmail.com
# @Github @yiiman-dev
#
#

# Specify the directory where repositories will be cloned
TARGET_DIR="./../related_packages/"
clone_relations(){
    # Specify the directory where repositories will be cloned


    # Check if the directory exists, if not, create it
    if [ ! -d "$TARGET_DIR" ]; then
        mkdir -p "$TARGET_DIR"
    fi

    # Read and decode JSON into an array
    REPOSITORIES=($(jq -r '.[]' $(pwd)/../related_docs.json))

    # Clone each repository in the array
    for repo in "${REPOSITORIES[@]}"; do
        echo "Cloning $repo"
        git clone "$repo" "$TARGET_DIR/$(basename "$repo" .git)"
    done

    echo "All repositories cloned to $TARGET_DIR"


}

generate_docs(){


    if [ -d "$TARGET_DIR" ]; then
        # List all directories within the specified folder
        DIRECTORIES=$(find "$FOLDER_PATH" -type d)

        # Loop through each directory and echo its name
        for DIR in $DIRECTORIES; do
            echo "Generating php docs: $DIR"
            phpdoc -d ./$DIR -t /var/www/related_docs/$DIR
        done
    else
        echo "Folder not found!"
    fi


}

start_welcome(){
    echo "Hi\n"
    echo "This is Yii3 framework document generator\n"
}

echo_current_directory(){
    echo $(pwd)
}

if [ ! "$1" = "nc" ]; then
  clear
fi
start_welcome
echo_current_directory

case $1 in
clone)
    clone_relations
  ;;
generate)
    generate_docs
  ;;
help)
    echo "Hi!  You can use this Arguments:"
    echo "install             install docker,php,composer and deploy script for start"
    echo "env                 copy .env file variables to system terminal variables"
    echo "build               build docker compose"
    echo "start               Start docker compose and server laravel"
    echo "stop                stop  docker compose"
    echo "laravel             Serve laravel for accept connection"
    echo "test                Start code test and check health"
    echo "add_users           Seed Users with Corporate and CEO access(Dummy)"
    echo "rt                  Start test laravel, if was successfully, then start laravel"
    echo "install_xdebug      this will install and enable XDebug on your system."
esac
