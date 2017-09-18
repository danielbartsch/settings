# Cursor Indicator

[![apm package][apm-ver-link]][releases]
[![travis-ci][travis-ci-badge]][travis-ci]
[![appveyor][appveyor-badge]][appveyor]
[![circle-ci][circle-ci-badge]][circle-ci]
[![david][david-badge]][david]
[![download][dl-badge]][apm-pkg-link]
[![mit][mit-badge]][mit]

Indicates the current number of cursors in the active editor via the Atom status bar.

![cursors][img_cursors]

## Styling

Add and tweak to your liking the following code to your personal Atom Stylesheet.

```less
.cursor-indicator {
  color: orangered;
  text-shadow: 0 0 5px orangered;
}
```

You can open your Stylesheet using the Command Palette.

```
Command Palette ➔ Application: Open Your Stylesheet
```

## Future Work

- Why do spec tests fail on Windows?
- Improved documentation.

---

[MIT][mit] © [lexicalunit][author] et [al][contributors]

[mit]:              http://opensource.org/licenses/MIT
[author]:           http://github.com/lexicalunit
[contributors]:     https://github.com/lexicalunit/cursor-indicator/graphs/contributors
[releases]:         https://github.com/lexicalunit/cursor-indicator/releases
[mit-badge]:        https://img.shields.io/apm/l/cursor-indicator.svg
[apm-pkg-link]:     https://atom.io/packages/cursor-indicator
[apm-ver-link]:     https://img.shields.io/apm/v/cursor-indicator.svg
[dl-badge]:         http://img.shields.io/apm/dm/cursor-indicator.svg
[travis-ci-badge]:  https://travis-ci.org/lexicalunit/cursor-indicator.svg?branch=master
[travis-ci]:        https://travis-ci.org/lexicalunit/cursor-indicator
[appveyor]:         https://ci.appveyor.com/project/lexicalunit/cursor-indicator?branch=master
[appveyor-badge]:   https://ci.appveyor.com/api/projects/status/y2tjco2s2t61evim/branch/master?svg=true
[circle-ci]:        https://circleci.com/gh/lexicalunit/cursor-indicator/tree/master
[circle-ci-badge]:  https://circleci.com/gh/lexicalunit/cursor-indicator/tree/master.svg?style=shield
[david-badge]:      https://david-dm.org/lexicalunit/cursor-indicator.svg
[david]:            https://david-dm.org/lexicalunit/cursor-indicator

[img_cursors]:      https://cloud.githubusercontent.com/assets/1903876/8216758/212eae80-14fe-11e5-80a6-443a6daf9d95.png
