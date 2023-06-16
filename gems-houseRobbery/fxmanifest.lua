fx_version 'cerulean'

game 'gta5'

author 'Gems'

version '1.0.0'

client_scripts{
	'client/*.lua',
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
}

server_scripts{
	'server/*.lua',
}

shared_script {
	'@qb-core/shared/locale.lua',
	'config.lua'
}

lua54 'yes'