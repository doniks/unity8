/*
 * Copyright (C) 2012,2013,2015 Canonical, Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#ifndef LIGHTDM_PLUGIN_H
#define LIGHTDM_PLUGIN_H

#include <QtQml/QQmlEngine>
#include <QtQml/QQmlExtensionPlugin>

#if defined INTEGRATED_LIGHTDM
    #define PLUGIN_CLASSNAME FullLightDMPlugin
#elif defined FULL_LIGHTDM
    #define PLUGIN_CLASSNAME IntegratedLightDMPlugin
#else
    #error No library defined in LightDM plugin
#endif


class PLUGIN_CLASSNAME : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri) override;
};

#endif /* LIGHTDM_PLUGIN_H */
