# ~/.config/qutebrowser/config.py
# A cool, opinionated qutebrowser config
# Load defaults first so unset options fall back sanely
config.load_autoconfig(False)

# ---------------------------------------------------------------------------
# Appearance — dark, minimal, Dracula-inspired
# ---------------------------------------------------------------------------
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = 'dark'

c.colors.completion.fg = '#f8f8f2'
c.colors.completion.odd.bg = '#282a36'
c.colors.completion.even.bg = '#21222c'
c.colors.completion.category.fg = '#bd93f9'
c.colors.completion.category.bg = '#282a36'
c.colors.completion.item.selected.fg = '#282a36'
c.colors.completion.item.selected.bg = '#50fa7b'

c.colors.statusbar.normal.bg = '#282a36'
c.colors.statusbar.normal.fg = '#f8f8f2'
c.colors.statusbar.insert.bg = '#50fa7b'
c.colors.statusbar.insert.fg = '#282a36'
c.colors.statusbar.command.bg = '#282a36'
c.colors.statusbar.url.fg = '#f8f8f2'
c.colors.statusbar.url.success.http.fg = '#8be9fd'
c.colors.statusbar.url.success.https.fg = '#50fa7b'
c.colors.statusbar.url.warn.fg = '#f1fa8c'
c.colors.statusbar.url.error.fg = '#ff5555'

c.colors.tabs.bar.bg = '#21222c'
c.colors.tabs.odd.bg = '#282a36'
c.colors.tabs.even.bg = '#21222c'
c.colors.tabs.selected.odd.bg = '#44475a'
c.colors.tabs.selected.even.bg = '#44475a'
c.colors.tabs.odd.fg = '#f8f8f2'
c.colors.tabs.even.fg = '#f8f8f2'

c.fonts.default_family = 'JetBrains Mono, Iosevka, monospace'
c.fonts.default_size = '11pt'

# Tabs: slim, on top, no title bar clutter
c.tabs.position = 'top'
c.tabs.show = 'multiple'
c.tabs.padding = {'top': 4, 'bottom': 4, 'left': 6, 'right': 6}
c.statusbar.padding = {'top': 2, 'bottom': 2, 'left': 4, 'right': 4}
c.window.hide_decoration = True  # frameless, tiling-WM friendly

# ---------------------------------------------------------------------------
# Behavior
# ---------------------------------------------------------------------------
c.auto_save.session = True
c.tabs.last_close = 'close'
c.scrolling.smooth = True
c.downloads.location.suggestion = 'both'
c.content.autoplay = False
c.content.notifications.enabled = False
c.content.pdfjs = True
c.content.geolocation = False

# Search engines (bind `open <keyword> query` or just type in url bar)
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'g': 'https://www.google.com/search?q={}',
    'yt': 'https://www.youtube.com/results?search_query={}',
    'gh': 'https://github.com/search?q={}',
    'w': 'https://en.wikipedia.org/w/index.php?search={}',
    'aw': 'https://wiki.archlinux.org/index.php?search={}',
}
c.url.default_page = 'https://duckduckgo.com'
c.url.start_pages = ['https://duckduckgo.com']

# Ad/tracker blocking
c.content.blocking.enabled = True
c.content.blocking.method = 'both'  # hosts file + adblock lists
c.content.blocking.adblock.lists = [
    'https://easylist.to/easylist/easylist.txt',
    'https://easylist.to/easylist/easyprivacy.txt',
    'https://easylist-downloads.adblockplus.org/easylistdutch.txt',
    'https://www.i-dont-care-about-cookies.eu/abp/',
]

# ---------------------------------------------------------------------------
# Keybindings
# ---------------------------------------------------------------------------
config.unbind('d')  # avoid accidental tab close, rebind below

# Tab management (Vim-ish)
config.bind('d', 'tab-close')
config.bind('D', 'tab-close -o')  # close, focus tab to the left
config.bind('u', 'undo')
config.bind('U', 'undo -w')  # restore last closed window
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
config.bind('<Ctrl-p>', 'tab-pin')

# Quick reload / hard reload
config.bind('r', 'reload')
config.bind('R', 'reload -f')

# Clipboard helpers
config.bind('yy', 'yank')
config.bind('yt', 'yank title')
config.bind('ym', 'yank -s')  # copy markdown-style link
config.bind('pp', 'open -t -- {clipboard}')

# Video speed control (great for lecture/podcast videos)
config.bind('<Ctrl-Up>', 'jseval --quiet (function(){let v=document.querySelector("video"); if(v) v.playbackRate=Math.min(v.playbackRate+0.25,4);})()')
config.bind('<Ctrl-Down>', 'jseval --quiet (function(){let v=document.querySelector("video"); if(v) v.playbackRate=Math.max(v.playbackRate-0.25,0.25);})()')
config.bind('<Ctrl-0>', 'jseval --quiet (function(){let v=document.querySelector("video"); if(v) v.playbackRate=1;})()')

# Password manager integration (requires `qute-keepassxc` userscript + keepassxc)
# Replace ABC1234 with your GPG key id, or remove if unused
# config.bind('<Ctrl-Shift-u>', 'spawn --userscript qute-keepassxc --key ABC1234', mode='insert')
# config.bind('pw', 'spawn --userscript qute-keepassxc --key ABC1234')

# Toggle reader-friendly dark mode per-page
config.bind(',d', 'jseval --quiet document.documentElement.style.filter = document.documentElement.style.filter ? "" : "invert(1) hue-rotate(180deg)"')

# Quick private window
config.bind(',p', 'open -p')

# ---------------------------------------------------------------------------
# Per-site tweaks (URL patterns)
# ---------------------------------------------------------------------------
with config.pattern('*://www.youtube.com/*') as p:
    p.content.autoplay = False

with config.pattern('*://docs.google.com/*') as p:
    p.content.javascript.clipboard = 'access'

with config.pattern('*://github.com/*') as p:
    p.content.javascript.clipboard = 'access'

# ---------------------------------------------------------------------------
# Editor (for editing text fields / config with :config-edit)
# ---------------------------------------------------------------------------
c.editor.command = ['nvim', '{file}']  # change to your editor, e.g. ['code', '-w', '{file}']
