# これは何をするやつ？
[English](./README_en.md)

FAT32でフォーマットされたSDカードなどを使う場合、4ギガバイト以上のmp4ファイルを分割しなければいけない時に使います。

## Windows / Mac / Linux ユーザー

以下のツールのインストールが必要です。  

- ffmpeg
- Ruby

ffmpegとRubyのインストールと、pathが通ってることがが前提です。

## Windows ユーザーの方は
Windowsで使う場合はWindows Subsystem for Linux上で行ってください。  

## 使い方

```
ruby ./mp4split.rb ~/huge.mp4
```

## 設定変更
3.8GBで区切るようにしていますので、必要に応じて変更してください。  

```
LIMIT_GB=3.8
```

## ご注意
MTIライセンスになると思います。  
このスクリプトの使用またはその他の扱いによって生じる一切の請求、損害、その他の義務について何らの責任も負わないものとします。
