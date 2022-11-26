# copy files from one google team drive to anotger team drive

### Not A script
- open google colab
- create a new notebook
- copy paste commands from below

mounting gdrive

` from google.colab import drive 
drive.mount('/gdrive') `

checking internetvspeed
 
- ``` !curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python - ```
 
- ``` !ls '/gdrive/' ```
 
- ``` !ls '/gdrive/Shared drives/' ```

copying files from one team drive to another
 
- ``` !cp -av "/gdrive/Shared drives/your team drive name/folder you want to copy" '/gdrive/Shared drives/team drive name where you want ti copy files/folder name where you wan5 to copy' ```
