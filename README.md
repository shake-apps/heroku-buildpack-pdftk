Heroku buildpack: precompiled pdftk
======================

Based on https://github.com/millie/heroku-buildpack-phantomjs.
For use with https://github.com/ddollar/heroku-buildpack-multi.

For use in a multi buildpack:

1) Configure heroku for multiple build packs.

```
heroku config:set BUILDPACK_URL=https://github.com/ddollar/heroku-buildpack-multi.git
```

2) Add pdftk to `.buildpacks` file

```
echo "https://github.com/shake-apps/heroku-buildpack-pdftk.git" >> .buildpacks
```
