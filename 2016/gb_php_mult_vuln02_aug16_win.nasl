###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_php_mult_vuln02_aug16_win.nasl 7545 2017-10-24 11:45:30Z cfischer $
#
# PHP Multiple Vulnerabilities - 02 - Aug16 (Windows)
#
# Authors:
# Tushar Khelge <ktushar@secpod.com>
#
# Copyright:
# Copyright (C) 2016 Greenbone Networks GmbH, http://www.greenbone.net
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
  script_oid("1.3.6.1.4.1.25623.1.0.808789");
  script_version("$Revision: 7545 $");
  script_cve_id("CVE-2016-5771", "CVE-2016-5770");
  script_bugtraq_id(91401, 91403);
  script_tag(name:"cvss_base", value:"7.5");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:P/I:P/A:P");
  script_tag(name:"last_modification", value:"$Date: 2017-10-24 13:45:30 +0200 (Tue, 24 Oct 2017) $");
  script_tag(name:"creation_date", value:"2016-08-17 12:19:56 +0530 (Wed, 17 Aug 2016)");
  script_name("PHP Multiple Vulnerabilities - 02 - Aug16 (Windows)");

  script_tag(name:"summary", value:"This host is installed with PHP and is prone
  to multiple vulnerabilities.");

  script_tag(name:"vuldetect", value:"Get the installed version with the help
  of detect NVT and check the version is vulnerable or not.");

  script_tag(name:"insight", value:"Multiple flaws are due to,
  - The 'spl_array.c' in the SPL extension improperly interacts with the
    unserialize implementation and garbage collection.
  - The integer overflow in the 'SplFileObject::fread' function in
    'spl_directory.c' in the SPL extension.");

  script_tag(name:"impact", value:"Successfully exploiting this issue allow
  remote attackers to cause a denial of service (use-after-free and application
  crash) or possibly execute arbitrary code or possibly have unspecified other
  impact via a large integer argument.

  Impact Level: Application");

  script_tag(name:"affected", value:"PHP versions prior to 5.5.37 and 5.6.x
  before 5.6.23 on Windows");

  script_tag(name:"solution", value:"Upgrade to PHP version 5.5.37, or 5.6.23,
  or later. For updates refer to http://www.php.net");

  script_tag(name:"solution_type", value:"VendorFix");

  script_tag(name:"qod_type", value:"remote_banner");

  script_xref(name:"URL", value:"http://www.php.net/ChangeLog-5.php");

  script_copyright("Copyright (C) 2016 Greenbone Networks GmbH");
  script_category(ACT_GATHER_INFO);
  script_family("Web application abuses");
  script_dependencies("gb_php_detect.nasl", "os_detection.nasl");
  script_mandatory_keys("php/installed","Host/runs_windows");
  script_require_ports("Services/www", 80);
  exit(0);
}

include("version_func.inc");
include("host_details.inc");

## Variable Initialization
phpPort = "";
phpVer = "";

if( isnull( phpPort = get_app_port( cpe:CPE ) ) ) exit( 0 );
if( ! phpVer = get_app_version( cpe:CPE, port:phpPort ) ) exit( 0 );

## Check for version before 5.5.37
if(version_is_less(version:phpVer, test_version:"5.5.37"))
{
  fix = '5.5.37';
  VULN = TRUE;
}

## Check for version 5.6.x before 5.6.23
else if(phpVer =~ "^(5\.6)")
{
  if(version_in_range(version:phpVer, test_version:"5.6.0", test_version2:"5.6.22"))
  {
    fix = '5.6.23';
    VULN = TRUE;
  }
}

if(VULN)
{
  report = report_fixed_ver(installed_version:phpVer, fixed_version:fix);
  security_message(data:report, port:phpPort);
  exit(0);
}

exit(99);