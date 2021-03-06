###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_rips_detect.nasl 7000 2017-08-24 11:51:46Z teissa $
#
# Rips Scanner Version Detection
#
# Authors:
# Kashinath T <tkashinath@secpod.com>
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
  script_oid("1.3.6.1.4.1.25623.1.0.806809");
  script_version("$Revision: 7000 $");
  script_tag(name:"cvss_base", value:"0.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:N");
  script_tag(name:"last_modification", value:"$Date: 2017-08-24 13:51:46 +0200 (Thu, 24 Aug 2017) $");
  script_tag(name:"creation_date", value:"2016-01-06 13:35:48 +0530 (Wed, 06 Jan 2016)");
  script_name("Rips Scanner Version Detection");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2016 Greenbone Networks GmbH");
  script_family("Product detection");
  script_dependencies("find_service.nasl");
  script_require_ports("Services/www", 80);
  script_exclude_keys("Settings/disable_cgi_scanning");

  script_tag(name:"summary", value:"Detection of installed version of Rips
  Scanner.

  This script sends HTTP GET request and try to get the version from the
  response, and sets the result in KB.");

  script_tag(name:"qod_type", value:"remote_banner");

  exit(0);
}

include("http_func.inc");
include("http_keepalive.inc");
include("cpe.inc");
include("host_details.inc");

##Get HTTP Port
port = get_http_port( default:80 );

# Check Host Supports PHP
if( ! can_host_php( port:port ) ) exit( 0 );

##Iterate over possible paths
foreach dir( make_list_unique( "/", "/rips", "/rips-scanner-master", cgi_dirs( port:port ) ) ) {

  install = dir;
  if( dir == "/" ) dir = "";

  ## Send and receive response
  rcvRes = http_get_cache( item: dir + "/index.php", port:port );

  ##Confirm application
  if( rcvRes && 'RIPS - A static source code analyser for vulnerabilities in PHP scripts' >< rcvRes ) {

    version = "unknown";

    ver = eregmatch( pattern:'get latest version">([0/.0-9]+)', string:rcvRes );
    if( ver[1] ) version = ver[1];

    ## Set the KB value
    set_kb_item( name:"www/" + port + "/rips", value:version );
    set_kb_item( name:"rips/Installed", value:TRUE );

    ## build cpe and store it as host_detail
    cpe = build_cpe( value:version, exp:"^([0-9.]+)", base:"cpe:/a:rips_scanner:rips:" );
    if( ! cpe )
      cpe = "cpe:/a:rips_scanner:rips";

    register_product( cpe:cpe, location:install, port:port );

    log_message( data:build_detection_report( app:"Rips Scanner",
                                              version:version,
                                              install:install,
                                              cpe:cpe,
                                              concluded:ver[0] ),
                                              port:port );
  }
}

exit( 0 );