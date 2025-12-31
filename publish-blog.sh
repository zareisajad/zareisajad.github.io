#!/bin/zsh

echo "Running Zola build..."
(cd ~/code/blog/src && zola build) || { echo "Zola build failed"; exit 1; }

echo "Deleting old files..."

rm -rf ~/code/blog/404.html \
       ~/code/blog/blog \
       ~/code/blog/favicon.ico \
       ~/code/blog/fonts \
       ~/code/blog/images \
       ~/code/blog/index.html \
       ~/code/blog/notes \
       ~/code/blog/reading \
       ~/code/blog/robots.txt \
       ~/code/blog/sitemap.xml \
       ~/code/blog/styles.css

echo "Copying new build..."
cp -a ~/code/blog/src/public/. ~/code/blog/

git -C ~/code/blog add -A
git -C ~/code/blog commit -m "new update"

echo "Pushing to remote..."
git -C ~/code/blog push

echo "Publish complete!"
