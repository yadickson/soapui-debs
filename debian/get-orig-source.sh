#!/bin/bash

set -ex

PKG="${PACKAGE_NAME:-${1}}"
VERSION="${PACKAGE_VERSION:-${2}}"
ADD_PATCH="${3:-false}"
ZIPFILE="${PKG}-${VERSION}.zip"
ORIG_TARBALL="../${PKG}_${VERSION}.orig.tar.gz"

[ ! -f "${ORIG_TARBALL}" ] || exit 0

rm -rf "${PKG}"*
rm -f "${ZIPFILE}"

wget -c "https://github.com/SmartBear/soapui/archive/${VERSION}.zip" -O "${ZIPFILE}" || exit 1

unzip "${ZIPFILE}" || exit 1

rm -f "${ZIPFILE}"

find "${PKG}-${VERSION}" -type f -name '.classpath' -exec rm -f '{}' \;
find "${PKG}-${VERSION}" -type f -name '.project' -exec rm -f '{}' \;
find "${PKG}-${VERSION}" -type f -name '*.jar' -exec rm -f '{}' \;
find "${PKG}-${VERSION}" -type f -name '*.dll' -exec rm -f '{}' \;

mv -f "${PKG}-${VERSION}"/README.md "${PKG}-${VERSION}"/README

rm -rf "${PKG}-${VERSION}"/.git*
rm -rf "${PKG}-${VERSION}"/soapui/src/test/
rm -rf "${PKG}-${VERSION}"/soapui/test*

#broser providers
rm -rf "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/analytics/providers

#3d party
rm -rf "${PKG}-${VERSION}"/soapui/src/main/java/org
rm -rf "${PKG}-${VERSION}"/soapui/src/main/java/skt

#autoupdate support
rm -rf "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/autoupdate

#javafx support
rm -f  "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/tools/JfxrtLocator.java
rm -f  "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/support/components/WebViewNavigationBar.java
rm -f  "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/support/components/EnabledWebViewBasedBrowserComponent.java
rm -f  "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/actions/VersionUpdateAction.java
rm -f  "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/settings/VersionUpdateSettings.java

#plugin support
rm -rf "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/plugins

#hermes jms support
rm -rf "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/impl/wsdl/support/jms
rm -rf "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/impl/wsdl/submit/transports/jms
rm -rf "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/impl/wsdl/teststeps/assertions/jms
rm -rf "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/support/editor/inspectors/jms
rm -f  "${PKG}-${VERSION}"/soapui/impl/wsdl/actions/project/StartHermesJMS.java
rm -f  "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/actions/StartHermesJMSButtonAction.java
rm -f  "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/support/HermesJMSClasspathHacker.java
rm -f  "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/impl/wsdl/actions/project/StartHermesJMS.java
rm -f  "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/impl/wsdl/actions/iface/AddJMSEndpointAction.java

# cajo support
rm -rf "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/integration/impl
rm -f  "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/integration/loadui/IntegrationUtils.java

# oauth2 support
rm -rf "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/support/editor/inspectors/auth
rm -rf "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/impl/rest/actions/oauth
rm -f  "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/impl/rest/*OAuth2*
rm -f  "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/impl/wsdl/submit/filters/*OAuth2*

#wss4j modern support
rm -rf "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/impl/wsdl/support/wss/saml
rm -f  "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/impl/wsdl/support/wss/entries/*SAML*

#submit information
rm -f  "${PKG}-${VERSION}"/soapui/src/main/java/com/eviware/soapui/actions/SumbitUserInfoAction.java

#tester
rm -rf "${PKG}-${VERSION}"/soapui-maven-plugin-tester
rm -rf "${PKG}-${VERSION}"/soapui-system-test

cp debian/soapui.pom.xml "${PKG}-${VERSION}"/pom.xml

find "${PKG}-${VERSION}" -type f -name '*.java' -or -name '*.xml' -or -name '*.xsd' -exec iconv -f ISO-8859-1 -t UTF-8 '{}' -o '{}'.iconv \; -exec mv '{}'.iconv '{}' \; -exec dos2unix '{}' \;

#Remove analitys
find "${PKG}-${VERSION}" -type f -name '*.java' -exec sed -i '/\.Analytics;/d' '{}' \;
find "${PKG}-${VERSION}" -type f -name '*.java' -exec sed -i '/Analytics\./d' '{}' \;

if [ "${ADD_PATCH}" != "false" ]
then
   while read -r line
   do
      patch -d "${PKG}-${VERSION}" -p1 < "debian/patches/${line}"
   done < debian/patches/series
fi

tar -czf "${ORIG_TARBALL}" --exclude-vcs "${PKG}-${VERSION}" || exit 1

rm -rf "${PKG}-${VERSION}"
rm -f "${ZIPFILE}"

