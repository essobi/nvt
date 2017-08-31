###############################################################################
# OpenVAS Vulnerability Test
#
# Ubuntu Update for nagios3 USN-3253-2
#
# Authors:
# System Generated Check
#
# Copyright:
# Copyright (C) 2017 Greenbone Networks GmbH, http://www.greenbone.net
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# (or any later version), as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
###############################################################################

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.843202");
  script_version("$Revision: 6648 $");
  script_tag(name:"last_modification", value:"$Date: 2017-07-10 13:05:27 +0200 (Mon, 10 Jul 2017) $");
  script_tag(name:"creation_date", value:"2017-06-08 06:04:35 +0200 (Thu, 08 Jun 2017)");
  script_cve_id("CVE-2013-7108", "CVE-2013-7205", "CVE-2014-1878", "CVE-2016-9566");
  script_tag(name:"cvss_base", value:"7.2");
  script_tag(name:"cvss_base_vector", value:"AV:L/AC:L/Au:N/C:C/I:C/A:C");
  script_tag(name:"qod_type", value:"package");
  script_name("Ubuntu Update for nagios3 USN-3253-2");
  script_tag(name: "summary", value: "Check the version of nagios3");
  script_tag(name: "vuldetect", value: "Get the installed version with the help of 
  detect NVT and check if the version is vulnerable or not."); 
  script_tag(name: "insight", value: "USN-3253-1 fixed vulnerabilities in Nagios. 
  The update prevented log files from being displayed in the web interface. This 
  update fixes the problem. We apologize for the inconvenience. Original advisory 
  details: It was discovered that Nagios incorrectly handled certain long strings. 
  A remote authenticated attacker could use this issue to cause Nagios to crash, 
  resulting in a denial of service, or possibly obtain sensitive information. 
  (CVE-2013-7108, CVE-2013-7205) It was discovered that Nagios incorrectly handled 
  certain long messages to cmd.cgi. A remote attacker could possibly use this 
  issue to cause Nagios to crash, resulting in a denial of service. 
  (CVE-2014-1878) Dawid Golunski discovered that Nagios incorrectly handled 
  symlinks when accessing log files. A local attacker could possibly use this 
  issue to elevate privileges. In the default installation of Ubuntu, this should 
  be prevented by the Yama link restrictions. (CVE-2016-9566)"); 
  script_tag(name: "affected", value: "nagios3 on Ubuntu 17.04 ,
  Ubuntu 16.10 ,
  Ubuntu 16.04 LTS ,
  Ubuntu 14.04 LTS");
  script_tag(name: "solution", value: "Please Install the Updated Packages.");

  script_xref(name: "USN", value: "3253-2");
  script_xref(name: "URL" , value: "http://www.ubuntu.com/usn/usn-3253-2/");
  script_tag(name:"solution_type", value:"VendorFix");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2017 Greenbone Networks GmbH");
  script_family("Ubuntu Local Security Checks");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/ubuntu_linux", "ssh/login/packages");
  exit(0);
}

include("revisions-lib.inc");
include("pkg-lib-deb.inc");

release = get_kb_item("ssh/login/release");

res = "";
if(release == NULL){
  exit(0);
}

if(release == "UBUNTU14.04 LTS")
{

  if ((res = isdpkgvuln(pkg:"nagios3-cgi", ver:"3.5.1-1ubuntu1.3", rls:"UBUNTU14.04 LTS")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isdpkgvuln(pkg:"nagios3-core", ver:"3.5.1-1ubuntu1.3", rls:"UBUNTU14.04 LTS")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if (__pkg_match) exit(99); # Not vulnerable.
  exit(0);
}


if(release == "UBUNTU17.04")
{

  if ((res = isdpkgvuln(pkg:"nagios3-cgi", ver:"3.5.1.dfsg-2.1ubuntu5.2", rls:"UBUNTU17.04")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isdpkgvuln(pkg:"nagios3-core", ver:"3.5.1.dfsg-2.1ubuntu5.2", rls:"UBUNTU17.04")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if (__pkg_match) exit(99); # Not vulnerable.
  exit(0);
}


if(release == "UBUNTU16.10")
{

  if ((res = isdpkgvuln(pkg:"nagios3-cgi", ver:"3.5.1.dfsg-2.1ubuntu3.3", rls:"UBUNTU16.10")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isdpkgvuln(pkg:"nagios3-core", ver:"3.5.1.dfsg-2.1ubuntu3.3", rls:"UBUNTU16.10")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if (__pkg_match) exit(99); # Not vulnerable.
  exit(0);
}


if(release == "UBUNTU16.04 LTS")
{

  if ((res = isdpkgvuln(pkg:"nagios3-cgi", ver:"3.5.1.dfsg-2.1ubuntu1.3", rls:"UBUNTU16.04 LTS")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isdpkgvuln(pkg:"nagios3-core", ver:"3.5.1.dfsg-2.1ubuntu1.3", rls:"UBUNTU16.04 LTS")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if (__pkg_match) exit(99); # Not vulnerable.
  exit(0);
}