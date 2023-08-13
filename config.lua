Config = {}

-----------
----BIN----
-----------
Config.Props = {
    `prop_dumpster_4b`,
    `prop_dumpster_4a`,
    `prop_dumpster_3a`,
    `prop_dumpster_02b`,
    `prop_dumpster_02a`,
    `prop_dumpster_01a`,
    `prop_snow_dumpster_01`,
    'prop_bin_14a',
    'prop_recyclebin_05_a',
    'prop_bin_14b',
    'prop_skip_05a',
    'prop_skip_04',
    'prop_skip_08a',
    'prop_skip_10a',
    'prop_skip_02a',
    'prop_skip_06a',
    'prop_skip_03',
    'prop_pile_dirt_06',
    'prop_pile_dirt_03',
    'prop_rub_pile_01',
    'prop_rub_pile_02',
}

-- ## Reset Configs
Config.ResetOnReboot = false
Config.ResetTime = 1 -- If Config.ResetOnReboot = false. In minutes

-- ## Minigame Configs
Config.Minigame = false -- Available options: false, 'qb-lock', 'memorygame', 'ps-ui'

-- ## Time Configs
Config.ProgressTime = 3 -- In secondes

-- ## Police Configs
Config.Illegal = false -- True will send an alert using the % on Config.AlertChance
Config.AlertChance = 10
Config.Dispatch = 'ps-dispatch' -- Available options: 'ps-dispatch' or 'qb-core'

-- ## Hurting Configs
Config.Hurting = true -- True will give a chance to the player to be hurt
Config.HurtChance = 20 -- If Config.Hurting = true. In percentage
Config.CanBleed = true -- Can the player bleed? / Requires qb-ambulancejob
Config.BleedChance = 30 -- If Config.CanBleed = true. In percentage
Config.HurtDamage = {
    min = 5,
    max = 15,
}

-- ## Loot table
Config.CanLootMultiple = true -- Can the player loot multiple items?
Config.MaxLootItem = 1 -- If Config.CanLootMultiple = true. Max items the player can loot

-- Tiered loot system
Config.LootTiers = {
    ['tier1'] = {
        chances = 75, -- The chances for this tier to be selected (out of 100)
        loottable = {
            {item = 'cd',              min = 1,    max = 2},
            {item = 'newspaper',       min = 1,    max = 2},
            {item = 'wrapper',         min = 1,    max = 2},
            {item = 'rat',             min = 1,    max = 2},
            {item = 'roach',           min = 1,    max = 2},
            {item = 'gum',             min = 1,    max = 2},
            {item = 'napkin',          min = 1,    max = 2},
            {item = 'safetypin',       min = 1,    max = 2},
            {item = 'scrapwood',       min = 1,    max = 2},
            {item = 'cardboard',       min = 1,    max = 2},
            {item = 'bottle',          min = 1,    max = 2},
            {item = 'can',             min = 1,    max = 2},
            {item = 'wires',           min = 1,    max = 2},
            {item = 'ducttape',        min = 1,    max = 2},
            -- Add more items to this tier as needed
        }
    },
    ['tier2'] = {
        chances = 25,
        loottable = {
            {item = 'metalscrap',       min = 2,    max = 5},
            {item = 'steel',            min = 2,    max = 5},
            {item = 'copper',           min = 2,    max = 5},
            {item = 'aluminum',         min = 2,    max = 5},
            {item = 'iron',             min = 2,    max = 5},
            {item = 'rubber',           min = 2,    max = 5},
            {item = 'tosti',            min = 1,    max = 3},
            {item = 'water_bottle',     min = 1,    max = 3},
            {item = 'vodka',            min = 1,    max = 3},
            {item = 'lockpick',         min = 1,    max = 3},
            -- Add more items to this tier as needed
        }
    },
    ['tier3'] = {
        chances = 15,
        loottable = {
            { item = 'emptyvape',          min = 1,    max = 1 },
            { item = 'broken_handcuffs',   min = 1,    max = 1 },
            { item = 'weapon_bat',         min = 1,    max = 1 },
            -- Add more items to this tier as needed
        }
    },
    ['tier4'] = {
        chances = 5,
        loottable = {
            { item = 'pistol_ammo',      min = 1,    max = 3 },
            { item = 'thermite',          min = 1,    max = 3 },
            { item = 'joint',            min = 1,    max = 3 },
            -- Add more items to this tier as needed
        }
    },
    ['tier5'] = {
        chances = 3,
        loottable = {
            { item = 'cocainekey',      min = 1,    max = 1 },
            { item = 'methkey',         min = 1,    max = 1 },
            { item = 'weedkey',         min = 1,    max = 1 },
            -- Add more items to this tier as needed
        }
    },
    ['tier6'] = {
        chances = 1,
        loottable = {
            { item = 'weapon_pistol',      min = 1,    max = 1 },
            { item = 'weapon_knuckle',     min = 1,    max = 1 },
            { item = 'thermite',           min = 1,    max = 3 },
            -- Add more items to this tier as needed
        }
    },

}

-----------
----BUM----
-----------
Config.pedModels = {
    'a_f_m_tramp_01',
    'a_f_m_trampbeac_01',
    'a_m_m_tramp_01',
    'a_m_m_trampbeac_01',
    'a_m_o_tramp_01',
    'u_m_o_tramp_01',
    'a_m_o_soucent_03',
    'a_m_o_soucent_02',
}

Config.ItemsSell = {
    ['cd']              = {['price'] = math.random(10, 15)},
    ['newspaper']       = {['price'] = math.random(10, 15)},
    ['wrapper']         = {['price'] = math.random(10, 15)},
    ['rat']             = {['price'] = math.random(10, 15)},
    ['roach']           = {['price'] = math.random(10, 15)},
    ['gum']             = {['price'] = math.random(10, 15)},
    ['napkin']          = {['price'] = math.random(10, 15)},
    ['cardboard']       = {['price'] = math.random(10, 15)},
    ['safetypin']       = {['price'] = math.random(10, 15)},
    ['scrapwood']       = {['price'] = math.random(10, 15)},
}

Config.StealChance = 50
Config.ItemsSteal = {
    ['ambeer'], 
    ['dusche-beer'], 
    ['logger-beer'], 
    ['stronzo-beer'], 
    ['meth'],
    ['coke'],
    ['lsd'],
    ['heroin'],
    ['joint'],  
    ['tosti'],			
    ['twerks_candy'],	
    ['snikkel_candy'],	
    ['sandwich'],
}
