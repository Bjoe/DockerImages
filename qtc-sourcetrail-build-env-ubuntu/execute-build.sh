
#QTCREATOR_VERSION=4.13/4.13.0
QTCREATOR_DIR=$HOME/opt/Qt/Tools/QtCreator

QTPATH="$HOME/opt/Qt/5.15.2/gcc_64/bin"
if [ ! -d ${QTPATH} ]; then
    echo "QTPATH=${QTPATH} doesn't exists. Please fix it in the $0 script"
    exit 1
fi

export PATH=":$PATH"


cd $HOME/Development

if [ -d qtc-sourcetrail ]; then
    cd qtc-sourcetrail
    git pull
else
    git clone https://github.com/CoatiSoftware/qtc-sourcetrail.git
    cd qtc-sourcetrail
fi
    
#if [ ! -d "qt-src" ]; then
#    curl -fsSL "http://download.qt.io/official_releases/qtcreator/$QTCREATOR_VERSION/installer_source/linux_gcc_64_rhel72/qtcreator_dev.7z" -o qt-dev.7z
#    7z x -y qt-dev.7z -o"qt-src"
 #   rm qt-dev.7z
#fi
if [ -x "$(command -v qmake-qt5)" ]; then
    export QMAKE=qmake-qt5
elif [ -x "$(command -v qmake)" ]; then
    export QMAKE=qmake
else
    echo "Neither qmake nor qmake-qt5 found"
    /bin/bash
fi
$QMAKE qtc-sourcetrail.pro -r "QTC_SOURCE=$QTCREATOR_DIR/dev" "QTC_BUILD=$QTCREATOR_DIR/lib/qtcreator" "LIBS+=-L$QTCREATOR_DIR/lib/qtcreator" "OUTPUT_PATH=$QTCREATOR_DIR/lib/qtcreator/plugins/"
make clean && make
/bin/bash
