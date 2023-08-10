local Translations = {
    target = {
        label = 'Dive In'
    },
    notifies = {
        you_got = 'You searched through the trash and found %{items}',
        got_nothing = 'You searched the dumpster and got nothing',
        failed_minigame = 'You failed to dive into the dumpster and got nothing.',
        canled_progress = 'You cancelled the diving.',
        hurt_yourself = 'You hurt yourself searching through the trash.',
        already_dived = 'This trash was already searched.',
    },
    progress = {
        diving = 'Searching Through the Trash',
    },
    police = {
        message = 'Criminal Activity',
        code = '10-00',
        bliptitle = 'Dumpster Diving',
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})