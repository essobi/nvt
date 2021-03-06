###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_ms16-020.nasl 5338 2017-02-18 16:20:24Z cfi $
#
# MS Active Directory Federation Services Denial of Service Vulnerability (3134222)
#
# Authors:
# Rinu Kuriakose <krinu@secpod.com>
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

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.807062");
  script_version("$Revision: 5338 $");
  script_cve_id("CVE-2016-0037");
  script_tag(name:"cvss_base", value:"5.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:P");
  script_tag(name:"last_modification", value:"$Date: 2017-02-18 17:20:24 +0100 (Sat, 18 Feb 2017) $");
  script_tag(name:"creation_date", value:"2016-02-10 08:15:01 +0530 (Wed, 10 Feb 2016)");
  script_tag(name:"qod_type", value:"executable_version");
  script_name("MS Active Directory Federation Services Denial of Service Vulnerability (3134222)");

  script_tag(name: "summary" , value:"This host is missing an important security
  update according to Microsoft Bulletin MS16-020.");

  script_tag(name: "vuldetect" , value:"Get the vulnerable file version and check
  appropriate patch is applied or not.");

  script_tag(name: "insight" , value:"The flaw is due to an insufficient
  validation of user supplied input by the Active Directory Federation
  Services (AD FS) during forms-based authentication.");

  script_tag(name: "impact" , value:"Successful exploitation will allow remote
  attackers to cause the server to become non-responsive, resulting in denial of
  service condition.

  Impact Level: System/Application");

  script_tag(name: "affected" , value:"Active Directory Federation Services
  3.0 on Windows Server 2012 R2");

  script_tag(name: "solution" , value:"Run Windows Update and update the listed
  hotfixes or download and update mentioned hotfixes in the advisory from the
  link, https://technet.microsoft.com/library/security/MS16-020");

  script_tag(name:"solution_type", value:"VendorFix");

  script_xref(name : "URL" , value : "https://support.microsoft.com/en-us/kb/3134222");
  script_xref(name : "URL" , value : "https://technet.microsoft.com/library/security/MS16-020");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2016 Greenbone Networks GmbH");
  script_family("Windows : Microsoft Bulletins");
  script_dependencies("secpod_reg_enum.nasl");
  script_require_ports(139, 445);
  script_mandatory_keys("SMB/WindowsVersion");

  exit(0);
}


include("smb_nt.inc");
include("secpod_reg.inc");
include("version_func.inc");
include("secpod_smb_func.inc");

## Variables Initialization
adfs = "";
adfs_ver = "";

## Check for OS and Service Pack
if(hotfix_check_sp(win2012R2:1) <= 0){
  exit(0);
}

adfs = registry_key_exists(key:"SOFTWARE\Microsoft\ADFS");
if(!adfs){
  exit(0);
}

## Get System Path
sysPath = smb_get_systemroot();
if(!sysPath ){
  exit(0);
}

adfs_ver = fetch_file_version(sysPath, file_name:"\ADFS\Microsoft.identityserver.dll");

if(adfs_ver)
{
  if(version_is_less(version:adfs_ver, test_version:"6.3.9600.18192"))
  {
    report = 'File checked:     ' + sysPath + "\ADFS\Microsoft.identityserver.dll" + '\n' +
             'File version:     ' + adfs_ver  + '\n' +
             'Vulnerable range: Less than 6.3.9600.18192\n' ;
    security_message(data:report);
    exit(0);
  }
}
