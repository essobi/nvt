###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_php_mult_dos_vuln_win.nasl 7549 2017-10-24 12:10:14Z cfischer $
#
# PHP Multiple Denial of Service Vulnerabilities (Windows)
#
# Authors:
# Madhuri D <dmadhuri@secpod.com>
#
# Copyright:
# Copyright (c) 2012 Greenbone Networks GmbH, http://www.greenbone.net
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
  script_oid("1.3.6.1.4.1.25623.1.0.802566");
  script_version("$Revision: 7549 $");
  script_cve_id("CVE-2011-4153", "CVE-2012-0781");
  script_bugtraq_id(51417);
  script_tag(name:"last_modification", value:"$Date: 2017-10-24 14:10:14 +0200 (Tue, 24 Oct 2017) $");
  script_tag(name:"creation_date", value:"2012-01-23 11:30:34 +0530 (Mon, 23 Jan 2012)");
  script_tag(name:"cvss_base", value:"5.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:P");
  script_name("PHP Multiple Denial of Service Vulnerabilities (Windows)");

  script_xref(name:"URL", value:"http://cxsecurity.com/research/103");
  script_xref(name:"URL", value:"http://securitytracker.com/id/1026524");
  script_xref(name:"URL", value:"http://www.exploit-db.com/exploits/18370/");
  script_xref(name:"URL", value:"http://archives.neohapsis.com/archives/bugtraq/2012-01/0092.html");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2012 Greenbone Networks GmbH");
  script_family("Denial of Service");
  script_dependencies("os_detection.nasl","gb_php_detect.nasl");
  script_require_ports("Services/www", 80);
  script_mandatory_keys("php/installed","Host/runs_windows");

  tag_impact = "Successful exploitation could allow remote attackers to cause
  denial of service conditions.

  Impact Level: Application";

  tag_affected = "PHP Version 5.3.8 on Windows.";

  tag_insight = "Multiple flaws are due to
  - An error in application which makes calls to the 'zend_strndup()' function
   without checking the returned values. A local user can run specially
   crafted PHP code to trigger a null pointer dereference in zend_strndup()
   and cause the target service to crash.
  - An error in 'tidy_diagnose' function, which might allows remote attackers
   to cause a denial of service via crafted input.";

  tag_solution = "Upgrade to PHP version 5.4.0 or later,
  For updates refer to http://php.net/downloads.php";

  tag_summary = "This host is installed with PHP and is prone to multiple denial of
  service vulnerabilities.";

  script_tag(name:"impact", value:tag_impact);
  script_tag(name:"affected", value:tag_affected);
  script_tag(name:"insight", value:tag_insight);
  script_tag(name:"solution", value:tag_solution);
  script_tag(name:"summary", value:tag_summary);

  script_tag(name:"qod_type", value:"remote_banner");
  script_tag(name:"solution_type", value:"VendorFix");

  exit(0);
}

include("version_func.inc");
include("host_details.inc");

if( isnull( phpPort = get_app_port( cpe:CPE ) ) ) exit( 0 );
if( ! phpVer = get_app_version( cpe:CPE, port:phpPort ) ) exit( 0 );

##Check for PHP version
if(version_is_equal(version:phpVer, test_version:"5.3.8")){
  report = report_fixed_ver(installed_version:phpVer, fixed_version:"5.4.0");
  security_message(data:report, port:phpPort);
  exit(0);
}

exit(99);
