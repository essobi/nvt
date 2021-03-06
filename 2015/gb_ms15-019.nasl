###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_ms15-019.nasl 6211 2017-05-25 09:04:14Z teissa $
#
# Microsoft Windows VBScript Remote Code Execution Vulnerability (3040297)
#
# Authors:
# Shakeel <bshakeel@secpod.com>
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

CPE = "cpe:/a:microsoft:ie";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.805299");
  script_version("$Revision: 6211 $");
  script_cve_id("CVE-2015-0032");
  script_tag(name:"cvss_base", value:"9.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:C/I:C/A:C");
  script_tag(name:"last_modification", value:"$Date: 2017-05-25 11:04:14 +0200 (Thu, 25 May 2017) $");
  script_tag(name:"creation_date", value:"2015-03-11 08:22:50 +0530 (Wed, 11 Mar 2015)");
  script_name("Microsoft Windows VBScript Remote Code Execution Vulnerability (3040297)");

  script_tag(name:"summary", value:"This host is missing a critical security
  update according to Microsoft Bulletin MS15-019.");

  script_tag(name:"vuldetect", value:"Get the vulnerable file version and
  check appropriate patch is applied or not.");

  script_tag(name:"insight", value:"Flaw exists due to error in VBScript that is
  triggered as user-supplied input is not properly validated.");

  script_tag(name:"impact", value:"Successful exploitation will allow remote
  attackers to execute arbitrary code and corrupt memory.

  Impact Level: System/Application");

  script_tag(name:"affected", value:"
  Microsoft Windows 2003 x32/x64 Service Pack 2 and prior
  Microsoft Windows Vista x32/x64 Service Pack 2 and prior
  Microsoft Windows Server 2008 x32/x64 Service Pack 2 and prior.");

  script_tag(name:"solution", value:"Run Windows Update and update the
  listed hotfixes or download and update mentioned hotfixes in the advisory
  from the below link,
  https://technet.microsoft.com/library/security/MS15-019");

  script_tag(name:"solution_type", value:"VendorFix");
  script_tag(name:"qod_type", value:"executable_version");
  script_xref(name : "URL" , value : "https://support.microsoft.com/kb/3030398");
  script_xref(name : "URL" , value : "https://support.microsoft.com/kb/3030403");
  script_xref(name : "URL" , value : "https://support.microsoft.com/kb/3040297");
  script_xref(name : "URL" , value : "https://technet.microsoft.com/library/security/MS15-019");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2015 Greenbone Networks GmbH");
  script_family("Windows : Microsoft Bulletins");
  script_dependencies("secpod_reg_enum.nasl", "gb_ms_ie_detect.nasl");
  script_mandatory_keys("MS/IE/Version");
  exit(0);
}


include("smb_nt.inc");
include("host_details.inc");
include("secpod_reg.inc");
include("version_func.inc");
include("secpod_smb_func.inc");

## Variables Initialization
sysPath = "";
dllVer = "";

## Check for OS and Service Pack
if(hotfix_check_sp(win2003:3, win2003x64:3, winVista:3, winVistax64:3,
                   win2008:3, win2008x64:3) <= 0){
  exit(0);
}

## Get System Path
sysPath = smb_get_systemroot();
if(!sysPath ){
  exit(0);
}

## Get IE Version
ieVer = get_app_version(cpe:CPE);
if(ieVer =~ "^(8|9|10|11)"){
  exit(0);
}

## Get Version from Vbscript.dll file
dllVer = fetch_file_version(sysPath, file_name:"system32\Vbscript.dll");
if(!dllVer){
  exit(0);
}

##Windows 2003
if(hotfix_check_sp(win2003:3, win2003x64:3) > 0)
{
  ## Check for Vbscript.dll version
  if((version_in_range(version:dllVer, test_version:"5.6", test_version2:"5.6.0.8853")) ||
     (version_in_range(version:dllVer, test_version:"5.7", test_version2:"5.7.6002.23628"))){
    security_message(0);
  }
  exit(0);
}

## Windows Vista and Windows Server 2008
## Currently not supporting for Vista and Windows Server 2008 64 bit
if(hotfix_check_sp(winVista:3, win2008:3) > 0)
{
  ## Check for Vbscript.dll version
  if((version_in_range(version:dllVer, test_version:"5.7", test_version2:"5.7.6002.19318")) ||
     (version_in_range(version:dllVer, test_version:"5.7.6002.23000", test_version2:"5.7.6002.23628"))){
    security_message(0);
  }
  exit(0);
}
