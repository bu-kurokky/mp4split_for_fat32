# What's this?

We have to split a huge mp4 file under four gigabytes when we using on the sd card formatted FAT32.  
Maybe, you will feel suitable when you use this script...

## Windows / Mac / Linux user

Install applications

- ffmpeg
- Ruby

Add ffmpeg and Ruby to environment variables by adding it to path.

### Windows user

You have to install Windows Subsystem for Linux if you use this script on Windows.


## How to use

```
ruby ./mp4split.rb ~/huge.mp4
```

## Modify
Modify this line on the script (limit 3.8 gigabytes).

```
LIMIT_GB=3.8
```

## License

[MIT License](https://opensource.org/licenses/mit-license.php)
