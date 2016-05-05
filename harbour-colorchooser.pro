# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-colorchooser

CONFIG += sailfishapp

SOURCES += src/harbour-colorchooser.cpp

OTHER_FILES += qml/harbour-colorchooser.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-colorchooser.changes.in \
    rpm/harbour-colorchooser.spec \
    rpm/harbour-colorchooser.yaml \
    translations/*.ts \
    harbour-colorchooser.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-colorchooser-de.ts

DISTFILES += \
    qml/pages/MainPage.qml \
    qml/pages/AboutPage.qml \
    qml/types/SailText.qml \
    qml/pages/ColourStore.js \
    qml/types/TextWithLink.qml \
    qml/types/ColourSlider.qml \
    qml/pages/SaveDialog.qml \
    qml/types/ColourBox.qml \
    qml/pages/Settings.js \
    qml/pages/LoadColour.qml

