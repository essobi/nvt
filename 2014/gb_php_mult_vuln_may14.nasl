###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_php_mult_vuln_may14.nasl 4505 2016-11-14 15:16:47Z cfi $
#
# PHP Multiple Vulnerabilities - 01 - May14
#
# Authors:
# Shakeel <bshakeel@secpod.com>
#
# Copyright:
# Copyright (C) 2014 Greenbone Networks GmbH, http://www.greenbone.net
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# (or any later version), as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
###############################################################################

CPE = "cpe:/a:php:php";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.804291");
  script_version("$Revision: 4505 $");
  script_cve_id("CVE-2013-7226", "CVE-2013-7327", "CVE-2013-7328", "CVE-2014-2020");
  script_bugtraq_id(65533, 65676, 65656, 65668);
  script_tag(name:"cvss_base", value:"6.8");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:P/I:P/A:P");
  script_tag(name:"last_modification", value:"$Date: 2016-11-14 16:16:47 +0100 (Mon, 14 Nov 2016) $");
  script_tag(name:"creation_date", value:"2014-05-09 09:47:32 +0530 (Fri, 09 May 2014)");
  script_name("PHP Multiple Vulnerabilities - 01 - May14");
  script_copyright("Copyright (C) 2014 Greenbone Networks GmbH");
  script_category(ACT_GATHER_INFO);
  script_family("Web application abuses");
  script_dependencies("gb_php_detect.nasl");
  script_require_ports("Services/www", 80);
  script_mandatory_keys("php/installed");

  script_xref(name:"URL", value:"https://bugzilla.redhat.com/show_bug.cgi?id=1065108");

  tag_summary = "This host is installed with PHP and is prone to multiple vulnerabilities.";

  tag_vuldetect = "Get the installed version of PHP with the help of detect NVT and check
  the version is vulnerable or not.";

  tag_insight = "Multiple flaws exists due to,
  - Integer overflow in the 'gdImageCrop' function within ext/gd/gd.c script.
  - Improper data types check as using string or array data type in place of
  a numeric data type within ext/gd/gd.c script.
  - Multiple integer signedness errors in the 'gdImageCrop' function within
  ext/gd/gd.c script.
  - Some NULL pointer dereference errors related to the 'imagecrop' function
  implementation.";

  tag_impact = "Successful exploitation will allow remote attackers to conduct denial of
  service, gain sensitive information and have some other unspecified impacts.

  Impact Level: System/Application";

  tag_affected = "PHP version 5.5.x before 5.5.9";

  tag_solution = "Upgrade to PHP version 5.5.9 or later. For updates refer to
  http://php.net";

  script_tag(name:"summary", value:tag_summary);
  script_tag(name:"vuldetect", value:tag_vuldetect);
  script_tag(name:"insight", value:tag_insight);
  script_tag(name:"impact", value:tag_impact);
  script_tag(name:"affected", value:tag_affected);
  script_tag(name:"solution", value:tag_solution);

  script_tag(name:"qod_type", value:"remote_banner_unreliable");
  script_tag(name:"solution_type", value:"VendorFix");

  exit(0);
}


include("version_func.inc");
include("host_details.inc");

if( isnull( port = get_app_port( cpe:CPE ) ) ) exit( 0 );
if( ! vers = get_app_version( cpe:CPE, port:port ) ) exit( 0 );

if(version_in_range( version:vers, test_version:"5.5.0", test_version2:"5.5.8" ) ) {
  report = report_fixed_ver( installed_version:vers, fixed_version:"5.5.9" );
  security_message( port:port, data:report );
  exit( 0 );
}

exit( 99 );