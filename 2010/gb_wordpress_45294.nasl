###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_wordpress_45294.nasl 6705 2017-07-12 14:25:59Z cfischer $
#
# WordPress Twitter Feed Plugin 'url' Parameter Cross Site Scripting Vulnerability
#
# Authors:
# Michael Meyer <michael.meyer@greenbone.net>
#
# Copyright:
# Copyright (c) 2010 Greenbone Networks GmbH
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# (or any later version), as published by the Free Software Foundation.
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

tag_summary = "The Twitter Feed Plugin for WordPress is prone to a cross-site
scripting vulnerability because it fails to properly sanitize user-
supplied input.

An attacker may leverage this issue to execute arbitrary script code
in the browser of an unsuspecting user in the context of the affected
site. This can allow the attacker to steal cookie-based authentication
credentials and launch other attacks.

Twitter Feed 0.3.1 is vulnerable; other versions may also be affected.";

tag_solution = "Remove Older version of Twitter Feed Plugin and Install Twitter Feed
plugin version 1.0 or later.
For updates refer to http://wordpress.org/extend/plugins/wp-twitter-feed";

SCRIPT_OID  = "1.3.6.1.4.1.25623.1.0.100944";
CPE = "cpe:/a:wordpress:wordpress";

if (description)
{
 script_oid(SCRIPT_OID);
 script_version("$Revision: 6705 $");
 script_tag(name:"last_modification", value:"$Date: 2017-07-12 16:25:59 +0200 (Wed, 12 Jul 2017) $");
 script_tag(name:"creation_date", value:"2010-12-10 13:28:59 +0100 (Fri, 10 Dec 2010)");
 script_bugtraq_id(45294);
 script_cve_id('CVE-2010-4825');
 script_tag(name:"cvss_base", value:"4.3");
 script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:N/I:P/A:N");

 script_name("WordPress Twitter Feed Plugin 'url' Parameter Cross Site Scripting Vulnerability");

 script_xref(name : "URL" , value : "https://www.securityfocus.com/bid/45294");
 script_xref(name : "URL" , value : "http://www.johnleitch.net/Vulnerabilities/WordPress.Twitter.Feed.0.3.1.Reflected.Cross-site.Scripting/68");
 script_xref(name : "URL" , value : "http://wordpress.org/extend/plugins/twitter-feed/");

 script_tag(name:"qod_type", value:"remote_vul");
 script_category(ACT_ATTACK);
 script_family("Web application abuses");
 script_copyright("This script is Copyright (C) 2010 Greenbone Networks GmbH");
 script_dependencies("secpod_wordpress_detect_900182.nasl");
 script_require_ports("Services/www", 80);
 script_mandatory_keys("wordpress/installed");
 script_tag(name : "solution" , value : tag_solution);
 script_tag(name : "summary" , value : tag_summary);
 exit(0);
}

include("http_func.inc");
include("http_keepalive.inc");
include("version_func.inc");
include("host_details.inc");
   
if(!port = get_app_port(cpe:CPE, nvt:SCRIPT_OID))exit(0);
if(!dir = get_app_location(cpe:CPE, nvt:SCRIPT_OID, port:port)) {
  if(!dir = get_app_location(cpe:"cpe:/a:wordpress:wordpress_mu", nvt:SCRIPT_OID, port:port))exit(0);
}  

url = string(dir, "/wp-content/plugins/wp-twitter-feed/magpie/scripts/magpie_debug.php?url=%3cscript%3ealert('openvas-xss-test')%3c%2fscript%3e"); 

if(http_vuln_check(port:port, url:url,pattern:"<script>alert\('openvas-xss-test'\)</script>",check_header:TRUE)) {
  security_message(port:port);
  exit(0);
}

exit(0);
