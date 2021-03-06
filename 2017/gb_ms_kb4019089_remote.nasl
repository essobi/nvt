###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_ms_kb4019089_remote.nasl 6950 2017-08-17 12:54:04Z asteins $
#
# Microsoft SQL Server 2016 Information Disclosure Vulnerability-KB4019089(Remote)
#
# Authors:
# Rinu Kuriakose <krinu@secpod.com>
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
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
###############################################################################

CPE = "cpe:/a:microsoft:sql_server";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.811569");
  script_version("$Revision: 6950 $");
  script_cve_id("CVE-2017-8516");
  script_bugtraq_id(100041);
  script_tag(name:"cvss_base", value:"5.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:P/I:N/A:N");
  script_tag(name:"last_modification", value:"$Date: 2017-08-17 14:54:04 +0200 (Thu, 17 Aug 2017) $");
  script_tag(name:"creation_date", value:"2017-08-09 18:15:10 +0530 (Wed, 09 Aug 2017)");
  script_name("Microsoft SQL Server 2016 Information Disclosure Vulnerability-KB4019089(Remote)");

  script_tag(name:"summary", value:"This host is missing an important security
  update according to Microsoft KB4019089");

  script_tag(name:"vuldetect", value:"Get the vulnerable file version and
  check appropriate patch is applied or not.");

  script_tag(name:"insight", value:"The flaw exists due to Microsoft SQL Server 
  Analysis Services improperly enforces permissions. ");

  script_tag(name:"impact", value:"Successful exploitation will allow
  an attacker to access an affected SQL server database. 

  Impact Level: System/Application");

  script_tag(name:"affected", value:"Microsoft SQL Server 2016 for x64-based Systems Service Pack 1");

  script_tag(name:"solution", value:"Run Windows Update and update the
  listed hotfixes or download and update mentioned hotfixes in the advisory
  from the below link,
  https://support.microsoft.com/en-us/help/4019089");

  script_tag(name:"solution_type", value:"VendorFix");
  script_tag(name:"qod_type", value:"remote_banner");
  script_xref(name : "URL" , value : "https://support.microsoft.com/en-us/help/4019089");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2017 Greenbone Networks GmbH");
  script_family("Windows : Microsoft Bulletins");
  script_dependencies("mssqlserver_detect.nasl");
  script_mandatory_keys("MS/SQLSERVER/Running");
  script_require_ports(1433);
  exit(0);
}

include("version_func.inc");
include("host_details.inc");

## Variable Initialization
mssqlVer = "";
mssqlPort = "";

## Get Port
if(!mssqlPort = get_app_port(cpe:CPE)){
  exit(0);
}

## Get version
if(!mssqlVer = get_app_version(cpe:CPE, port:mssqlPort)){
  exit(0);
}

## Check for file Microsoft.sqlserver.chainer.infrastructure.dll
## security update for SQL Server 2016 GDR
if(mssqlVer =~ "^13\.0")
{
  if(version_in_range(version:mssqlVer, test_version:"13.0.4000.0", test_version2:"13.0.4205.0"))
  {
    report  = 'Vulnerable range: ' + "13.0.4000.0 - 13.0.4205.0" + '\n' ;
    security_message(data:report, port:mssqlPort);
    exit(0);
  }
}
exit(0);
