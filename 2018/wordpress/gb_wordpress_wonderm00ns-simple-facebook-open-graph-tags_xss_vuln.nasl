###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_wordpress_wonderm00ns-simple-facebook-open-graph-tags_xss_vuln.nasl 9924 2018-05-22 13:26:22Z asteins $
#
# WordPress Open Graph for Facebook, Google+ and Twitter Card Tags Plugin < 2.2.4.1 XSS Vulnerability
#
# Authors:
# Adrian Steins <adrian.steins@greenbone.net>
#
# Copyright:
# Copyright (C) 2018 Greenbone Networks GmbH
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

CPE = "cpe:/a:wordpress:wordpress";

if (description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.112287");
  script_version("$Revision: 9924 $");
  script_tag(name: "last_modification", value: "$Date: 2018-05-22 15:26:22 +0200 (Tue, 22 May 2018) $");
  script_tag(name: "creation_date", value: "2018-05-16 15:20:00 +0200 (Wed, 16 May 2018)");
  script_tag(name: "cvss_base", value: "4.3");
  script_tag(name: "cvss_base_vector", value: "AV:N/AC:M/Au:N/C:N/I:P/A:N");

  script_cve_id("CVE-2018-0579");

  script_tag(name: "qod_type", value: "remote_banner");

  script_tag(name: "solution_type", value: "VendorFix");

  script_name("WordPress Open Graph for Facebook, Google+ and Twitter Card Tags Plugin < 2.2.4.1 XSS Vulnerability");

  script_category(ACT_GATHER_INFO);

  script_copyright("This script is Copyright (C) 2018 Greenbone Networks GmbH");
  script_family("Web application abuses");
  script_dependencies("secpod_wordpress_detect_900182.nasl");
  script_mandatory_keys("wordpress/installed");

  script_tag(name: "summary", value: "Open Graph plugin for WordPress is prone to a cross-site scripting vulnerability.");
  script_tag(name: "vuldetect", value: "Checks if a vulnerable version is present on the target host.");

  script_tag(name: "affected", value: "Open Graphs plugin before version 2.2.4.1");

  script_tag(name: "solution", value: "Upgrade to version 2.2.4.1 or later.");

  script_xref(name: "URL", value: "http://jvn.jp/en/jp/JVN08386386/index.html");
  script_xref(name: "URL", value: "https://wordpress.org/plugins/wonderm00ns-simple-facebook-open-graph-tags/#developers");

  exit(0);
}

include("host_details.inc");
include("http_func.inc");
include("http_keepalive.inc");
include("version_func.inc");

if (!port = get_app_port(cpe: CPE)) exit(0);

if (!dir = get_app_location(cpe: CPE, port: port)) exit(0);

if (dir == "/") dir = "";

res = http_get_cache(port: port, item: dir + "/wp-content/plugins/wonderm00ns-simple-facebook-open-graph/readme.txt");

if ("=== Open Graph for Facebook, Google+ and Twitter Card Tags" >< res && "Changelog" >< res) {

  vers = eregmatch(pattern: "Stable tag: ([0-9.]+)", string: res);

  if (!isnull(vers[1]) && version_is_less(version: vers[1], test_version: "2.2.4.1")) {
    report = report_fixed_ver(installed_version: vers[1], fixed_version: "2.2.4.1");
    security_message(port: port, data: report);
    exit(0);
  }
}

exit(99);
