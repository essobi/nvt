###############################################################################
# OpenVAS Vulnerability Test
# $Id: secpod_wireshark_sigcomp_dissector_dos_vuln_win.nasl 8440 2018-01-17 07:58:46Z teissa $
#
# Wireshark SigComp Universal Decompressor Virtual Machine dissector DOS Vulnerability (Windows)
#
# Authors:
# Antu Sanadi <santu@secpod.com>
#
# Copyright:
# Copyright (c) 2010 SecPod, http://www.secpod.com
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

tag_impact = "Successful exploitation will allow the attackers to crash an affected application.
  Impact Level: Application";
tag_affected = "Wireshark version 0.10.7 through 1.0.13 and 1.2.0 through 1.2.8";
tag_insight = "The flaw is caused by an off-by-one error within the SigComp Universal
  Decompressor Virtual Machine, which could be exploited by attackers to
  crash an affected application or execute arbitrary code via unknown vectors.";
tag_solution = "Upgrade to Wireshark version 1.0.14 or 1.2.9:
  For updates refer to http://www.wireshark.org/download.html";
tag_summary = "This host is installed with Wireshark and is prone to Denial of
  Service vulnerability.";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.902198");
  script_version("$Revision: 8440 $");
  script_tag(name:"last_modification", value:"$Date: 2018-01-17 08:58:46 +0100 (Wed, 17 Jan 2018) $");
  script_tag(name:"creation_date", value:"2010-06-22 13:34:32 +0200 (Tue, 22 Jun 2010)");
  script_cve_id("CVE-2010-2286");
  script_tag(name:"cvss_base", value:"3.3");
  script_tag(name:"cvss_base_vector", value:"AV:A/AC:L/Au:N/C:N/I:N/A:P");
  script_name("Wireshark SigComp Universal Decompressor Virtual Machine dissector DOS Vulnerability (Windows)");
  script_xref(name : "URL" , value : "http://secunia.com/advisories/40112");
  script_xref(name : "URL" , value : "http://www.vupen.com/english/advisories/2010/1418");
  script_xref(name : "URL" , value : "http://www.wireshark.org/security/wnpa-sec-2010-05.html");
  script_xref(name : "URL" , value : "http://www.wireshark.org/security/wnpa-sec-2010-06.html");
  script_xref(name : "URL" , value : "http://www.openwall.com/lists/oss-security/2010/06/11/1");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2010 SecPod");
  script_family("Denial of Service");
  script_dependencies("gb_wireshark_detect_win.nasl");
  script_require_keys("Wireshark/Win/Ver");
  script_tag(name : "impact" , value : tag_impact);
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name : "summary" , value : tag_summary);
  script_tag(name:"qod_type", value:"registry");
  script_tag(name:"solution_type", value:"VendorFix");
  exit(0);
}


include("version_func.inc");

sharkVer = get_kb_item("Wireshark/Win/Ver");
if(!sharkVer){
  exit(0);
}

# Check for Wireshark version
if(version_in_range(version:sharkVer, test_version:"1.2.0", test_version2:"1.2.8") ||
   version_in_range(version:sharkVer, test_version:"0.10.7", test_version2:"1.0.13")){
  security_message(0);
}
