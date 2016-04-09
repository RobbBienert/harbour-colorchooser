# About this directory

The PNG files for the app are generated from the SVG file here using *Inkscape*. Although the SVG has a size of 256×256 pixel, *Inkscape* does a really good job in downscaling the other versions.

The command line used to generate the icons was:

    for i in 86': for i in 86 108 128 256; do inkscape -e ${i}x${i}/harbour-colorchooser.png -w $i harbour-colorchooser.svg; done

This step has to be done everytime the icon gets updated. I guess it should be done during project build.
