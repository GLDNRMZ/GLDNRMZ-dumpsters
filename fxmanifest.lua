fx_version 'cerulean'
game 'gta5'
lua54 'yes'

client_script 'client/*.lua'
server_script 'server/*.lua'
shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'config.lua'
}