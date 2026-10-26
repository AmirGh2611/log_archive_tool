# project URL
<https://roadmap.sh/projects/log-archive-tool>

# usage
### 1-first make the file using command below
> touch log-archive.sh
### 2-open the file
> vi log-archive.sh
### 3-edit the file
> press i and paste the code in file
### 4-save the file
> go to the end of the file and write :wq in a new line
### 5-make file executable
> chmod +x log-archive.sh
### 6-move file to system path
> sudo mv log-archive /usr/local/bin/

# Automate on a Schedule
### 1-open crontab editor
> sudo crontab -e
### 2-write the following code in file
> 0 0 * * * /usr/local/bin/log-archive /var/log >/dev/null 2>&1
### 3-exit and save the file
