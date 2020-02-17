QTCREATOR_VERSION=4.11/4.11.0
QTCREATOR_DIR=/home/jboehme
export PATH="$QTCREATOR_DIR/opt/Qt/5.14.0/gcc_64/bin:$PATH"


cd $HOME/Development

git clone https://github.com/CoatiSoftware/qtc-sourcetrail.git
cd qtc-sourcetrail
if [ ! -d "qt-src" ]; then
    curl -fsSL "http://download.qt.io/official_releases/qtcreator/$QTCREATOR_VERSION/installer_source/linux_gcc_64_rhel72/qtcreator_dev.7z" -o qt-dev.7z
    7z x -y qt-dev.7z -o"qt-src"
    rm qt-dev.7z
fi
if [ -x "$(command -v qmake-qt5)" ]; then
    export QMAKE=qmake-qt5
elif [ -x "$(command -v qmake)" ]; then
    export QMAKE=qmake
else
    echo "Neither qmake nor qmake-qt5 found"
    /bin/bash
fi
$QMAKE qtc-sourcetrail.pro -r "QTC_SOURCE=qt-src" "QTC_BUILD=$QTCREATOR_DIR/opt/Qt/Tools/QtCreator/lib/qtcreator" "LIBS+=-L$QTCREATOR_DIR/opt/Qt/Tools/QtCreator/lib/qtcreator" "OUTPUT_PATH=$QTCREATOR_DIR/opt/Qt/Tools/QtCreator/lib/qtcreator/plugins/"
make clean && make
/bin/bash
