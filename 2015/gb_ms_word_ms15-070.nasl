###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_ms_word_ms15-070.nasl 5053 2017-01-20 13:10:56Z cfi $
#
# Microsoft Office Word Multiple Remote Code Execution Vulnerabilities (3072620)
#
# Authors:
# Thanga Prakash S <tprakash@secpod.com>
#
# Copyright:
# Copyright (C) 2015 Greenbone Networks GmbH, http://www.greenbone.net
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

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.805811");
  script_version("$Revision: 5053 $");
  script_cve_id("CVE-2015-2379", "CVE-2015-2380", "CVE-2015-2424");
  script_tag(name:"cvss_base", value:"9.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:C/I:C/A:C");
  script_tag(name:"last_modification", value:"$Date: 2017-01-20 14:10:56 +0100 (Fri, 20 Jan 2017) $");
  script_tag(name:"creation_date", value:"2015-07-15 10:46:09 +0530 (Wed, 15 Jul 2015)");
  script_tag(name:"qod_type", value:"executable_version");
  script_name("Microsoft Office Word Multiple Remote Code Execution Vulnerabilities (3072620)");

  script_tag(name:"summary", value:"This host is missing an important security
  update according to Microsoft Bulletin MS15-070.");

  script_tag(name:"vuldetect", value:"Get the vulnerable file version and check
  appropriate patch is applied or not.");

  script_tag(name:"insight", value:"Multiple flaws are due to improper handling
  of files in the memory.");

  script_tag(name:"impact", value:"Successful exploitation will allow remote
  attackers to run arbitrary code in the context of the current user.

  Impact Level: System/Application");

  script_tag(name:"affected", value:"
  Microsoft Word 2007 Service Pack 3 and prior,
  Microsoft Word 2010 Service Pack 2 and prior,
  Microsoft Word 2013 Service Pack 1 and prior.");

  script_tag(name:"solution", value:"Run Windows Update and update the listed
  hotfixes or download and update mentioned hotfixes in the advisory from the
  below link, https://technet.microsoft.com/en-us/security/bulletin/ms15-070");

  script_tag(name:"solution_type", value:"VendorFix");

  script_xref(name : "URL" , value : "https://support.microsoft.com/en-us/kb/3054996");
  script_xref(name : "URL" , value : "https://support.microsoft.com/en-us/kb/3054973");
  script_xref(name : "URL" , value : "https://support.microsoft.com/en-us/kb/3054990");
  script_xref(name : "URL" , value : "https://technet.microsoft.com/en-us/library/security/MS15-070");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2015 Greenbone Networks GmbH");
  script_family("Windows : Microsoft Bulletins");
  script_dependencies("secpod_office_products_version_900032.nasl");
  script_mandatory_keys("SMB/Office/Word/Version");
  exit(0);
}


include("version_func.inc");

## variable Initialization
winwordVer = "";

winwordVer = get_kb_item("SMB/Office/Word/Version");

## Microsoft Office Word 2007/2010/2013
if(winwordVer && winwordVer =~ "^(12|14|15).*")
{
  if(version_in_range(version:winwordVer, test_version:"12.0", test_version2:"12.0.6726.4999") ||
     version_in_range(version:winwordVer, test_version:"14.0", test_version2:"14.0.7153.5001") ||
     version_in_range(version:winwordVer, test_version:"15.0", test_version2:"15.0.4737.1002"))
  {
    security_message(0);
    exit(0);
  }
}
