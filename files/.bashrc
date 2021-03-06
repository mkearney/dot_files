# ssh into work computer var
export WORKIP=128.206.132.181

# Update github repositories
update_repos()
{
    # start at home dir
    cd ~

    # apitools
    cd ~/R/apitools
    echo "REPO:apitools"
    echo "pull..."
    git pull
    echo "pushing..."
    git add .
    git commit -m "fresh update from macbook"
    git push

    # CAR2018-rtweet
    cd ~/R/CAR2018-rtweet
    echo "REPO:CAR2018-rtweet"
    echo "pull..."
    git pull
    echo "pushing..."
    git add .
    git commit -m "fresh update from macbook"
    git push

    # google APIs
    cd ~/R/googleapis
    echo "REPO:googleapis"
    echo "pull..."
    git pull
    echo "pushing..."
    git add .
    git commit -m "fresh update from macbook"
    git push

    # hack rtweet
    cd ~/R/h.rtweet
    echo "REPO:h.rtweet"
    echo "pull..."
    git pull
    echo "pushing..."
    git add .
    git commit -m "fresh update from macbook"
    git push

    # ijpp paper (with ben)
    cd ~/R/ijpp_osror
    echo "REPO:ijpp_osror"
    echo "pull..."
    git pull
    echo "pushing..."
    git add .
    git commit -m "fresh update from macbook"
    git push

    # my markdown template
    cd ~/R/prettysimplemd
    echo "REPO:prettysimplemd"
    echo "pull..."
    git pull
    echo "pushing..."
    git add .
    git commit -m "fresh update from macbook"
    git push

    # reviewer
    cd ~/R/reviewer
    echo "REPO:reviewer"
    echo "pull..."
    git pull
    echo "pushing..."
    git add .
    git commit -m "fresh update from macbook"
    git push

    # rtweet
    cd ~/R/rtweet
    echo "REPO:rtweet"
    echo "pull..."
    git pull
    echo "pushing..."
    git add .
    git commit -m "fresh update from macbook"
    git push

    # tfse
    cd ~/R/tfse
    echo "REPO:tfse"
    echo "pull..."
    git pull
    echo "pushing..."
    git add .
    git commit -m "fresh update from macbook"
    git push

    # trickrtweet
    cd ~/R/trickrtweet
    echo "REPO:trickrtweet"
    echo "pull..."
    git pull
    echo "pushing..."
    git add .
    git commit -m "fresh update from macbook"
    git push

    # trumptweets
    cd ~/R/trumptweets
    echo "REPO:trumptweets"
    echo "pull..."
    git pull
    echo "pushing..."
    git add .
    git commit -m "fresh update from macbook"
    git push

    # my website
    cd ~/Website/mkearney.github.io
    echo "REPO:mkearney.github.io"
    echo "pull..."
    git pull
    echo "pushing..."
    git add .
    git commit -m "fresh update from macbook"
    git push

    # back to home dir
    cd ~
}

# Create new Github repository (public)
create_repo()
{
    USER=mkearney
    ## Name of repo defaults to name of working dir
    CURRENTDIR=${PWD##*/}
    GITHUBUSER=$(git config github.user)

    # Get values from args
    REPONAME=$1
    DESCRIPTION=$2

    # Send curl request and add/push local repo
    curl -u ${USER:-${GITHUBUSER}} https://api.github.com/user/repos -d "{\"name\": \"${REPONAME:-${CURRENTDIR}}\", \"description\": \"${DESCRIPTION}\", \"has_issues\": true, \"has_downloads\": true, \"has_wiki\": false}"
    git remote add origin git@github.com:${USER:-${GITHUBUSER}}/${REPONAME:-${CURRENTDIR}}.git
    git push -u origin master
}

# Create new PRIVATE Github repository
create_private_repo()
{
    USER=mkearney
    ## Name of repo defaults to name of working dir
    CURRENTDIR=${PWD##*/}
    GITHUBUSER=$(git config github.user)

    # Get values from args
    REPONAME=$1
    DESCRIPTION=$2

    # Send curl request and add/push local repo
    curl -u ${USER:-${GITHUBUSER}} https://api.github.com/user/repos -d "{\"name\": \"${REPONAME:-${CURRENTDIR}}\", \"description\": \"${DESCRIPTION}\", \"private\": true, \"has_issues\": true, \"has_downloads\": true, \"has_wiki\": false}"
    git remote add origin git@github.com:${USER:-${GITHUBUSER}}/${REPONAME:-${CURRENTDIR}}.git
    git push -u origin master
}

cat_make()
{
    echo -e "#!/bash/bin\nopen -a emacs -n make.R\n" > make
    echo -e "## r\n" > make.R
}
