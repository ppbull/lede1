-- Copyright (C) 2017 yushi studio <ywb94@qq.com>
-- Licensed to the public under the GNU General Public License v3.

local m, s, o
local shadowsocksr = "shadowsocksr"
local sid = arg[1]

local encrypt_methods = {
	"none",
	"table",
	"rc4",
	"rc4-md5-6",
	"rc4-md5",
	"aes-128-cfb",
	"aes-192-cfb",
	"aes-256-cfb",
	"aes-128-ctr",
	"aes-192-ctr",
	"aes-256-ctr",
	"aes-128-gcm",
	"aes-192-gcm",
	"aes-256-gcm",
	"bf-cfb",
	"camellia-128-cfb",
	"camellia-192-cfb",
	"camellia-256-cfb",
	"cast5-cfb",
	"des-cfb",
	"idea-cfb",
	"rc2-cfb",
	"seed-cfb",
	"salsa20",
	"chacha20",
	"chacha20-ietf",
	"chacha20-ietf-poly1305",
	"xchacha20-ietf-poly1305",
}

local protocol = {
	"origin",
	"verify_deflate",
	"auth_sha1_v4",
	"auth_aes128_sha1",
	"auth_aes128_md5",
	"auth_chain_a",
}

obfs = {
	"plain",
	"http_simple",
	"http_post",
	"random_head",
	"tls1.2_ticket_auth",
	"tls1.2_ticket_fastauth",
}

m = Map(shadowsocksr, translate("Edit ShadowSocksR Server"))

m.redirect = luci.dispatcher.build_url("admin/services/shadowsocksr/server")
if m.uci:get(shadowsocksr, sid) ~= "server_config" then
	luci.http.redirect(m.redirect) 
	return
end




-- [[ Server Setting ]]--
s = m:section(NamedSection, sid, "server_config")
s.anonymous = true
s.addremove   = false

o = s:option(Flag, "enable", translate("Enable"))
o.default = 1
o.rmempty = false

o = s:option(Value, "server", translate("Server Address"))
o.datatype = "ipaddr"
o.default = "0.0.0.0"
o.rmempty = false

o = s:option(Value, "server_port", translate("Server Port"))
o.datatype = "port"
o.default = 8388
o.rmempty = false

o = s:option(Value, "timeout", translate("Connection Timeout"))
o.datatype = "uinteger"
o.default = 60
o.rmempty = false

o = s:option(Value, "password", translate("Password"))
o.password = true
o.rmempty = false

o = s:option(ListValue, "encrypt_method", translate("Encrypt Method"))
for _, v in ipairs(encrypt_methods) do o:value(v) end
o.rmempty = false

o = s:option(ListValue, "protocol", translate("Protocol"))
for _, v in ipairs(protocol) do o:value(v) end
o.rmempty = false


o = s:option(ListValue, "obfs", translate("Obfs"))
for _, v in ipairs(obfs) do o:value(v) end
o.rmempty = false

o = s:option(Value, "obfs_param", translate("Obfs param(optional)"))

o = s:option(Flag, "fast_open", translate("TCP Fast Open"))
o.rmempty = false

return m