# Install git
sudo pacman -S git  # Idk about you, but I use pacman with endevour os btw.

# Define your identity
git config --global user.name "meshp" # What ever your alias is.
git config --global user.email "meshp@proton.me" # same for email.

# Generate a SSH key
ssh-keygen -t ed25519 -C "meshp@proton.me"

# Startup the ssh agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed22159

# finally copy the key and and it to github
cat ~/.ssh/id_ed25519.pub

# test the connection
ssh -T git@github.com
