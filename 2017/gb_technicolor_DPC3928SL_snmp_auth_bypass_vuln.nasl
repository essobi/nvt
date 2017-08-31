###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_technicolor_DPC3928SL_snmp_auth_bypass_vuln.nasl 6386 2017-06-21 07:51:15Z santu $
#
# Technicolor DPC3928SL SNMP Authentication Bypass Vulnerability
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

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.810980");
  script_version("$Revision: 6386 $");
  script_cve_id("CVE-2017-5135");
  script_bugtraq_id(98092);
  script_tag(name:"cvss_base", value:"6.4");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:P/I:P/A:N");
  script_tag(name:"last_modification", value:"$Date: 2017-06-21 09:51:15 +0200 (Wed, 21 Jun 2017) $");
  script_tag(name:"creation_date", value:"2017-05-19 17:59:31 +0530 (Fri, 19 May 2017)");
  script_tag(name:"qod_type", value:"exploit");
  script_name("Technicolor DPC3928SL SNMP Authentication Bypass Vulnerability");

  script_tag(name: "summary" , value:"This host has Technicolor DPC3928SL device
  and is prone to snmp authentication bypass vulnerability.");

  script_tag(name: "vuldetect" , value:"Send a crafted SNMP authentication request 
  and check whether it is able to bypass authentication or not.");

  script_tag(name: "insight" , value:"The flaw is due to the value placed in the 
  community string field is not handled properly by the snmp agent in different 
  devices (usually cable modems).");

  script_tag(name: "impact" , value:"Successful exploitation will allow remote
  attacker to bypass certain security restrictions and perform unauthorized 
  actions like write in the MIB etc.

  Impact Level: Application");

  script_tag(name: "affected" , value:"Technicolor DPC3928SL firmware version 
  D3928SL-P15-13-A386-c3420r55105-160127a is vulnerable; other devices are also 
  affected.");

  script_tag(name: "solution" , value:"No solution or patch is available as of
  19th may 2017, information regarding this issue will be updated once the 
  soultion details are available.
  For updates refer to http://partnerhub.technicolor.com");

  script_xref(name : "URL" , value : "https://stringbleed.github.io");
  script_xref(name : "URL" , value : "https://www.reddit.com/r/netsec/comments/67qt6u/cve_20175135_snmp_authentication_bypass");

  script_tag(name:"solution_type", value:"NoneAvailable");
  script_category(ACT_ATTACK);
  script_copyright("Copyright (C) 2017 Greenbone Networks GmbH");
  script_family("Web application abuses");
  script_require_udp_ports("Services/udp/snmp", 161);
  exit(0);
}

include("snmp_func.inc");

snmp_port = get_kb_item("Services/udp/snmp");
if(!snmp_port)snmp_port = 161;

if (!get_udp_port_state(snmp_port))
  exit(0);

# Passing community string 
# Any string integer value
community = "testOpenVAS";

## Checking for the vulnerability
if(ret = snmp_get( port:snmp_port, oid:'1.3.6.1.2.1.1.1.0', version:2, community:community ))
{
  report = "Result of the system description query with the community '" +community + "':\n\n" + ret + "\n";
  security_message(port: snmp_port, data: report, proto: "udp");
  exit(0);
}
exit(0);