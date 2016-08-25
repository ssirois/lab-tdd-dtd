# element-library_test.sh -- tests the library element rules
#
# Copyright 2016 Samuel Sirois (sds) <samuel@sirois.info>
#
# This file is part of lab-tdd-dtd.
#
# lab-tdd-dtd is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# lab-tdd-dtd is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with lab-tdd-dtd.  If not, see <http://www.gnu.org/licenses/>.

testThatALibraryElementIsEnough()
{
  xmldoc="$xmldocHeader<library />"
  echo "${xmldoc}" | ${xmllintCmd}
  actual=$?

  assertTrue "xmllint returned an error code (${actual})" ${actual}
}

testThatALibraryElementCanHaveABook()
{
  xmldoc="$xmldocHeader<library><book /></library>"
  echo "${xmldoc}" | ${xmllintCmd}
  actual=$?

  assertTrue "xmllint returned an error code (${actual})" ${actual}
}

testThatALibraryElementCanHaveMultipleBooks()
{
  xmldoc="$xmldocHeader<library><book /><book /></library>"
  echo "${xmldoc}" | ${xmllintCmd}
  actual=$?

  assertTrue "xmllint returned an error code (${actual})" ${actual}
}

testThatALibraryElementCanHaveAnIdAttribute()
{
  xmldoc="$xmldocHeader<library id=\"my-library\"><book /><book /></library>"
  echo "${xmldoc}" | ${xmllintCmd}
  actual=$?

  assertTrue "xmllint returned an error code (${actual})" ${actual}
}

testThatALibraryCannotHaveArbitraryData()
{
  xmldoc="$xmldocHeader<library id=\"my-library\">lorem ipsum</library>"
  echo "${xmldoc}" | ${xmllintCmd}
  actual=$?

  assertFalse "The library element shouldn't contain arbitrary data." ${actual}
}

oneTimeSetUp() {
  xmllintCmd='xmllint --nonet --dtdvalid ./src/dtd/library.dtd --xinclude --postvalid --noout -'
  #xmldocHeader='<?xml version="1.0"?><!DOCTYPE library SYSTEM "library.dtd">'
  xmldocHeader='<?xml version="1.0"?>'
}
