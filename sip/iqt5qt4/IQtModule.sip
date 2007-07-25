// The SIP interface definition for the _iqt module of PyQwt.
//
// Copyright (C) 2001-2007 Gerard Vermeulen
// Copyright (C) 2000 Mark Colclough
//
// This file is part of PyQwt.
//
// PyQwt is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// PyQwt is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along
// with PyQwt; if not, write to the Free Software Foundation, Inc.,
// 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
//
// In addition, as a special exception, Gerard Vermeulen gives permission
// to link PyQwt dynamically with non-free versions of Qt and PyQt,
// and to distribute PyQwt in this form, provided that equally powerful
// versions of Qt and PyQt have been released under the terms of the GNU
// General Public License.
//
// If PyQwt is dynamically linked with non-free versions of Qt and PyQt,
// PyQwt becomes a free plug-in for a non-free program.


%Module PyQt4.Qwt5._iqt 0

%ModuleCode
#include <qcoreapplication.h>

#if defined(Q_OS_WIN32)
#include <conio.h>
#include <QTimer>
#else
#include <QSocketNotifier>
#endif

// copy the idea of Michiel de Hoon from PyQt-x11-gpl-4.3.
static int iqt_input_hook(void)
{
    QCoreApplication *a = QCoreApplication::instance();

    if (a) {
#if defined(Q_OS_WIN32)
        QTimer timer;
        QObject::connect(&timer, SIGNAL(timeout()), a, SLOT(quit()));
        do {
            timer.start(100);
            QCoreApplication::exec();
            timer.stop();
        } while (!_kbhit());
        QObject::disconnect(&timer, SIGNAL(timeout()), a, SLOT(quit()));
#else
#if HAVE_LIBREADLINE
        a->processEvents();
#else
        QSocketNotifier notifier(0, QSocketNotifier::Read, 0);
        QObject::connect(&notifier, SIGNAL(activated(int)), a, SLOT(quit()));
        QCoreApplication::exec();
        QObject::disconnect(&notifier, SIGNAL(activated(int)), a, SLOT(quit()));
#endif // HAVE_LIBREADLINE
#endif // defined(Q_OS_WIN32)
    }

    return 0;
}

%End // ModuleCode


%PostInitialisationCode
PyOS_InputHook = iqt_input_hook;
%End // PostInitialisationCode

// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
