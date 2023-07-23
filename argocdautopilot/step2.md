Copy and edit XXX with your PAT then execute:

`PAT=XXX`{{copy}}

Copy and edit XXX with your Github Account Name then execute:

`GITHUB_ACCOUNT=XXX`{{copy}}

Copy and edit XXX with Github Repository Name then execute:

`REPOSITORY=XXX`{{copy}}

Run command:

`export GIT_TOKEN=$PAT`{{execute}}

Run command:

`git config --global user.email "test"`{{execute}}

Run command:

`git config --global user.name "test"`{{execute}}

Run Command:

`export GIT_REPO=https://github.com/$GITHUB_ACCOUNT/$REPOSITORY`{{execute}}



