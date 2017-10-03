# Maintainer: Eduardo Parra Mazuecos <eduparra90@gmail.com>

_name="<-Insert name->"
pkgname=python-$_name
pkgver=1.0
pkgrel=1
pkgdesc="<-Insert description->"
arch=('any')
url=<-"URL"->
license=('<-License->')
makedepends=('python-setuptools')
depends=('python')
options=(!emptydirs)
optdepends=('package-name: description')
source=(https://files.pythonhosted.org/packages/source/${_name:0:1}/${_name}/${_name}-${pkgver}.tar.gz)
md5sums=('<--->')

build() {
  cd "$srcdir/${pkgname#python-}-$pkgver"

  msg2 'Building...'
  python setup.py build
}

package() {
  cd "$srcdir/${pkgname#python-}-$pkgver"

  msg2 'Installing...'
  python setup.py install --root="$pkgdir" --optimize=1 --skip-build
  
  install -D -m644 LICENSE "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"
}
