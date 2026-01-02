+++
title = "مدیریت فایل‌های dotfiles با گیت"
date = 1404-10-12
+++

تقریبا ۷-۸ سالی میشه که با لینوکس آشنا شدم و توی این مدت با اینکه از مک و ویندوز هم استفاده کردم همچنان ترجیح میدم با لینوکس بمونم.

یکی از تفریحاتم توی این چندسال نصب کردن و امتحان کردن distro های مختلف با دسکتاپ های مختلف بوده! و در کنار اون امتحان کردن ادیتور ها و wm های مختلف.
اصلا همین تنوعش برام خیلی جذابه.

در ستایش لینوکس بعدا مفصل میشه. خلاصه اینکه اخیرا به صورت کامل کوچ کردم روی i3 و این جرئتو به خودم دادم بعد از اینکه به neovim کوچ کردم.

الان هر روز به کانفیگ ها ور میرم و برای ذخیره کردنشون چالش داشتم.
مدتی هست که یادداشت هامو تو یک ریپوی خصوصی با obsidian ذخیره میکنم و خیلی سیستم خوبیه.
این کارو برای کانفیگ ها امتحان کردم ولی مشکلش اینه که کار سختیه هر دفعه تغییرات جدید رو کپی کنی توی فایل هایی که روی گیت هست.

برای حل این مشکل باز هم قهرمان داستان : git وارد می شود.

##### اینجوری میسازیمش:

```zsh
git init --bare $HOME/.dotfiles
```

و یا میتونید ریپوزیتوری موجود رو به صورت bare توی سیستم clone کنید:
‍‍‍```
```zsh
git clone --bare https://github.com/YOUR_USERNAME/dotfiles.git $HOME/.dotfiles
```
##### یه alias براش بسازید

اینو به zshrc. اضافه میکنیم

```zsh
alias dtf='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

الان مثلا میتونیم بگیم`dtf status` و بقیه کامندها.

##### به گیت میگیم بقیه فایل هارو بیخیال شو

```zsh
d‍tfiles config --local status.showUntrackedFiles no‍‍‍‍‍
```
##### فایل های کانفیگ رو اضافه میکنیم

```zsh
dtf add ~/.config/i3
dtf add ~/.config/nvim 
dtf add ~/.zshrc 

dtf commit -m "Initial dotfiles"
```
##### و در آخر push کنید
```zsh
dotfiles remote add origin git@github.com:YOUR_USERNAME/dotfiles.git

dotfiles push -u origin master
```

از اونجایی که من نمیخواستم هر دفعه `dtf commit` انجام بدم یه alias دیگه هم اضافه کردم:

```zsh
alias dtfpush='dtf add -f ~/.zshrc ~/.config/i3 ~/.config/nvim && dtf commit -m "update dotfiles" && dtf push'
```

الان دیگه فرق نمیکنه کجای لینوکس هستید با یه کامند `dtfpush` تمام کانفیگ ها push میشه تو گیت هاب.

تفاوت اصلی با ریپوی معمولی گیت اینه که نیازی نیست هیچ فایلی رو جا به جا کنید.

الان گیت از HOME$ تمام تغییراتی که اعمال میشه رو زیر نظر داره و فقط با یه کامند ساده از هرجا میتونید commit کنید و تغییراتو push کنید توی گیت هاب.

و از اونجایی که من زیاد مدام در حال تغییر distro هستم برای اینکه توی یک سیستم تازه نصب شده تمام ابزارهایی که برای این کانفیگ ها نیاز به نصب دارن رو نصب کنم یه اسکریپت ساده هم اضافه کردم:

bootstrap.sh:
```bash
#!/usr/bin/env bash

sudo pacman -Syu --needed --noconfirm

sudo pacman -S --needed \
    tmux telegram-desktop zsh zola nodejs npm nvim \
    git picom obsidian okular mpv konsole obs-studio \
    ttf-jetbrains-mono polybar pamixer feh xorg-xrandr \
    i3status brightnessctl numlockx python-virtualenv python-pynvim \
    luarocks rust neovim 
    
```
این اسکریپت رو اضافه کردم به `dotfiles/scripts` و با ران کردن این اسکریپت دیگه نیازی نیست تمام ابزارهارو تکی نصب کنیم.
