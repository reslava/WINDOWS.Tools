># 🐠 [Fish Shell](https://fishshell.com/) 🐠

## 📦 Installation

### 🪟 Windows (WSL)

To install Fish Shell on Windows 11, you must use the Windows Subsystem for Linux (WSL) since Fish is a Unix-based shell and does not run natively on Windows.

Begin by ensuring WSL 2 is installed, which requires Hyper-V support; if unavailable, WSL 1 can be used instead.

Open Command Prompt or PowerShell as an administrator and run wsl --install to enable WSL, install the Virtual Machine Platform, download the latest Linux kernel, and install Ubuntu.

After installation, restart your computer.

Once WSL is set up, launch Ubuntu from the Start Menu, complete the initial setup by creating a username and password, and then open the terminal to install Fish.

Update the package list and install Fish using the following commands:

```
sudo apt update && sudo apt upgrade
sudo apt install fish
```

To set Fish as the default shell, run 

``` 
chsh -s /usr/bin/fish.
```

For a more enhanced experience, install the Oh My Fish (omf) plugin manager to manage themes and plugins. First, install Git with 

```
sudo apt install git
```

then run the omf installer:

```
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
```


After installation, install a theme such as bobthefish using 
```
omf install bobthefish
```