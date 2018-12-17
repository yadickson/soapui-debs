# Debian Package for SoapUI Open Source

[![TravisCI Status][travis-image]][travis-url]

**Build dependencies**

- debhelper (>= 9)
- cdbs
- default-jdk
- maven-debian-helper (>= 1.5)
- libxmlbeans-maven-plugin-java
- junit4
- libbcprov-java
- libcommons-beanutils-java
- libcommons-cli-java
- libcommons-codec-java
- libcommons-collections3-java
- libcommons-httpclient-java
- libcommons-io-java
- libcommons-lang-java (>= 2.4)
- libcssparser-java
- libezmorph-java
- libguava-java
- libhtmlunit-core-js-java
- libhttpclient-java
- libhttpcore-java
- libhttpmime-java
- libjenkins-htmlunit-java (>= 2.6-jenkins-6)
- libjetty-java
- libjgoodies-forms-java
- libjgoodies-looks-java
- libjtidy-java
- liblog4j1.2-java (>= 1.2.17)
- libmail-java
- libnekohtml-java
- libnot-yet-commons-ssl-java (>= 0.3.9)
- librhino-java
- librsyntaxtextarea-java
- libsac-java
- libsaxonb-java (>= 9.1.0.8)
- libws-commons-util-java (>= 1.0.1)
- libwss4j-java
- libxalan2-java
- libxerces2-java
- libxml-security-java
- libxmlbeans-java
- libxmlunit-java
- libxom-java
- libxstream-java
- libanimal-sniffer-java
- libgeronimo-jms-1.1-spec-java
- libjsr305-java
- libjgoodies-binding-java
- libwsdl4j-java
- libjson-java
- libjcifs-java
- libfontchooser-java
- libswingx1-java
- [libflex-java](https://github.com/yadickson/flex-debs)
- [libl2fprod-common-java](https://github.com/yadickson/l2fprod-common-debs)
- [libproxy-vole-java](https://github.com/yadickson/proxy-vole-debs)
- [libjsonpath-java](https://github.com/yadickson/jsonpath-debs)

**Download source code**

- unzip
- wget
- libc-bin
- dos2unix 

```
$ debian/rules get-orig-source
$ debian/rules publish-source
```

**Build project**

```
$ dpkg-buildpackage -rfakeroot -D -us -uc -i -I -sa
```
or
```
$ QUILT_PATCHES=debian/patches quilt push -a
$ fakeroot debian/rules clean binary
```

**Tested**

- Debian jessie

**Repositories**

[Debian repository](https://bintray.com/yadickson/debian)

```
$ wget -qO - https://bintray.com/user/downloadSubjectPublicKey?username=bintray | sudo apt-key add -
```
```
$ echo "deb https://dl.bintray.com/yadickson/debian [distribution] main" | sudo tee -a /etc/apt/sources.list.d/bintray.list
```
```
$ sudo apt-get update
$ sudo apt-get upgrade -y
$ sudo apt-get install soapui
```

## License

GPL-3.0 © [Yadickson Soto](https://github.com/yadickson)

EUPL-1.1 © [SmartBear](https://github.com/SmartBear/soapui)

[travis-image]: https://api.travis-ci.org/yadickson/soapui-debs.svg?branch=master
[travis-url]: https://travis-ci.org/yadickson/soapui-debs


