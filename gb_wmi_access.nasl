###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_wmi_access.nasl 6894 2017-08-10 13:52:23Z cfischer $
#
# Check for access via WMI
#
# Authors:
# Adrian Steins <adrian.steins@greenbone.net>
# Christian Fischer <christian.fischer@greenbone.net>
#
# Copyright:
# Copyright (C) 2017 Greenbone Networks GmbH, https://www.greenbone.net
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.108205");
  script_version("$Revision: 6894 $");
  script_tag(name:"last_modification", value:"$Date: 2017-08-10 15:52:23 +0200 (Thu, 10 Aug 2017) $");
  script_tag(name:"creation_date", value:"2017-08-09 13:47:59 +0200 (Wed, 09 Aug 2017)");
  script_tag(name:"cvss_base", value:"0.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:N");
  script_name("Check for access via WMI");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2017 Greenbone Networks GmbH");
  script_family("Windows");
  script_dependencies("toolcheck.nasl", "smb_login.nasl", "smb_nativelanman.nasl");
  script_require_ports(139, 445);
  script_mandatory_keys("Tools/Present/wmi", "SMB/password", "SMB/login");
  script_exclude_keys("SMB/samba");

  script_tag(name:"summary", value:"This routine checks if an access to the remote host with the Windows Management Instrumentation (WMI)
  method is possible by using the provided SMB login/password credentials.");

  script_tag(name:"qod_type", value:"remote_banner");

  exit(0);
}

host    = get_host_ip();
usrname = get_kb_item( "SMB/login" );
passwd  = get_kb_item( "SMB/password" );

if( ! host || ! usrname || ! passwd ) exit( 0 );

domain = get_kb_item( "SMB/domain" );
if( domain ) usrname = domain + '\\' + usrname;

handle = wmi_connect( host:host, username:usrname, password:passwd );
if( ! handle ) exit( 0 );

wmi_close( wmi_handle:handle );

replace_kb_item( name:"WMI/access_successful", value:TRUE );

exit( 0 );