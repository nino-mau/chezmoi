# Elephant
A service providing various datasources which can be triggered to perform actions.

Run `elephant -h` to get an overview of the available commandline flags and actions.
## Elephant Configuration
`~/.config/elephant/elephant.toml`
#### ElephantConfig
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|auto_detect_launch_prefix|bool|true|automatically detects uwsm, app2unit or systemd-run|
|overload_local_env|bool|false|overloads the local env|
|ignored_providers|[]string|<empty>|providers to ignore|
|git_on_demand|bool|true|sets up git repositories on first query instead of on start|
|before_load|[]common.Command||commands to run before starting to load the providers|
#### Command
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|must_succeed|bool|false|will try running this command until it completes successfully|
|command|string||command to execute|


## Provider Configuration
### Elephant Bookmarks

URL bookmark manager

#### Features

- create / remove bookmarks
- import bookmarks from installed browsers
- cycle through categories
- customize browsers and set per-bookmark browser
- git integration (requires ssh access)

#### Requirements

- `jq` for importing from chromium based browsers
- `sqlite3` for importing from firefox based browsers

#### Git Integration

You can set

```toml
location = "https://github.com/abenz1267/elephantbookmarks"
```

This will automatically try to clone/pull the repo. It will also automatically comimt and push on changes.

#### Usage

##### Adding a new bookmark

By default, you can create a new bookmark whenever no items match the configured `min_score` threshold. If you want to, you can also configure `create_prefix`, f.e. `add`. In that case you can do `add:bookmark`.

URLs without `http://` or `https://` will automatically get `https://` prepended.

Examples:

```
example.com                       -> https://example.com
github.com GitHub                 -> https://github.com (with title "Github")
add reddit.com Reddit             -> https://reddit.com (with title "Reddit")
w:work-site.com                   -> https://work-site.com (in "work" category)
```

##### Categories

You can organize bookmarks into categories using prefixes:

```toml
[[categories]]
name = "work"
prefix = "w:"

[[categories]]
name = "personal"
prefix = "p:"
```

##### Browsers

You can customize browsers used for opening bookmarks like this:

```toml
[[browsers]]
name = "Zen"
command = "zen-browser"

[[browsers]]
name = "Chromium"
command = "chromium"

[[browsers]]
name = "Chromium App"
command = "chromium --app=%VALUE%"
```


`~/.config/elephant/bookmarks.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|name_pretty|string|depends on provider|displayed name for the provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|hide_from_providerlist|bool|false|hides a provider from the providerlist provider. provider provider.|
|location|string|elephant cache dir|location of the CSV file|
|categories|[]main.Category||categories|
|browsers|[]main.Browser||browsers for opening bookmarks|
|set_browser_on_import|bool|false|set browser name on imported bookmarks|
|history|bool|true|make use of history for sorting|
|history_when_empty|bool|false|consider history when query is empty|
#### Category
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|name|string||name for category|
|prefix|string||prefix to store item in category|

#### Browser
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|name|string||name of the browser|
|command|string||command to launch the browser|
|icon|string||icon to use|


### Elephant Calc

Perform calculation and unit-conversions.

#### Features

- save results
- copy results

#### Requirements

- `libqalculate`
- `wl-clipboard`

#### Usage

Refer to the official [libqalculate docs](https://github.com/Qalculate/libqalculate).


`~/.config/elephant/calc.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|name_pretty|string|depends on provider|displayed name for the provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|hide_from_providerlist|bool|false|hides a provider from the providerlist provider. provider provider.|
|max_items|int|100|max amount of calculation history items|
|placeholder|string|calculating...|placeholder to display for async update|
|require_number|bool|true|don't perform if query does not contain a number|
|min_chars|int|3|don't perform if query is shorter than min_chars|
|command|string|wl-copy -n %VALUE%|default command to be executed. supports %VALUE%.|
|async|bool|true|calculation will be send async|
|autosave|bool|false|automatically save results|

### Elephant Clipboard

Store clipboard history.

#### Features

- saves images and text history
- filter to show images only
- edit saved content
- localsend support

#### Requirements

- `wl-clipboard`
- `imagemagick`


`~/.config/elephant/clipboard.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|name_pretty|string|depends on provider|displayed name for the provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|hide_from_providerlist|bool|false|hides a provider from the providerlist provider. provider provider.|
|max_items|int|100|max amount of clipboard history items|
|image_editor_cmd|string||editor to use for images. use '%FILE%' as placeholder for file path.|
|text_editor_cmd|string||editor to use for text, otherwise default for mimetype. use '%FILE%' as placeholder for file path.|
|command|string|wl-copy|default command to be executed|
|ignore_symbols|bool|true|ignores symbols/unicode|
|auto_cleanup|int|0|will automatically cleanup entries entries older than X minutes|

### Elephant Desktop Applications

Run installed desktop applications.

#### Features

- history
- pin items
- alias items
- auto-detect `uwsm`/`app2unit`


`~/.config/elephant/desktopapplications.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|name_pretty|string|depends on provider|displayed name for the provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|hide_from_providerlist|bool|false|hides a provider from the providerlist provider. provider provider.|
|launch_prefix|string||overrides the default app2unit or uwsm prefix, if set.|
|locale|string||to override systems locale|
|action_min_score|int|20|min score for actions to be shown|
|show_actions|bool|false|include application actions, f.e. 'New Private Window' for Firefox|
|show_generic|bool|true|include generic info when show_actions is true|
|show_actions_without_query|bool|false|show application actions, if the search query is empty|
|history|bool|true|make use of history for sorting|
|history_when_empty|bool|false|consider history when query is empty|
|only_search_title|bool|false|ignore keywords, comments etc from desktop file when searching|
|icon_placeholder|string|applications-other|placeholder icon for apps without icon|
|aliases|map[string]string||setup aliases for applications. Matched aliases will always be placed on top of the list. Example: 'ffp' => '<identifier>'. Check elephant log output when activating an item to get its identifier.|
|blacklist|[]string|<empty>|blacklist desktop files from being parsed. Regexp.|
|window_integration|bool|false|will enable window integration, meaning focusing an open app instead of opening a new instance|
|ignore_pin_with_window|bool|true|will ignore pinned apps that have an opened window|
|window_integration_ignore_actions|bool|true|will ignore the window integration for actions|
|wm_integration|bool|false|Moves apps to the workspace where they were launched at automatically. Currently Niri only.|
|score_open_windows|bool|true|Apps that have open windows, get their score halved. Requires window_integration.|
|single_instance_apps|[]string|["discord"]|application IDs that don't ever spawn a new window. |

### Elephant Providerlist

Lists all installed providers and configured menus.


`~/.config/elephant/providerlist.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|name_pretty|string|depends on provider|displayed name for the provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|hide_from_providerlist|bool|false|hides a provider from the providerlist provider. provider provider.|
|hidden|[]string|<empty>|hidden providers|

### Elephant Snippets

Create and access text snippets.

#### Features

- multiple keywords per snippet
- define command for pasting yourself

#### Requirements

- `wtype`

#### Example snippets

```toml
[[snippets]]
keywords = ["search", "this"]
name = "example snippet"
content = "this will be pasted"
```


`~/.config/elephant/snippets.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|name_pretty|string|depends on provider|displayed name for the provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|hide_from_providerlist|bool|false|hides a provider from the providerlist provider. provider provider.|
|command|string|wtype %CONTENT%|default command to be executed. supports %VALUE%.|
|snippets|[]main.Snippet||available snippets|
|delay|int|100|delay in ms before executing command to avoid potential focus issues|
#### Snippet
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|keywords|[]string||searchable keywords|
|name|string||displayed name|
|content|string||content to paste|


### Elephant Symbols

Search for emojis and symbols

#### Requirements

- `wl-clipboard`


#### Possible locales
af,ak,am,ar,ar_SA,as,ast,az,be,bew,bg,bgn,blo,bn,br,bs,ca,ca_ES,ca_ES_VALENCIA,ccp,ceb,chr,ckb,cs,cv,cy,da,de,de_CH,doi,dsb,el,en,en_001,en_AU,en_CA,en_GB,en_IN,es,es_419,es_MX,es_US,et,eu,fa,ff,ff_Adlm,fi,fil,fo,fr,fr_CA,frr,ga,gd,gl,gu,ha,ha_NE,he,hi,hi_Latn,hr,hsb,hu,hy,ia,id,ig,is,it,ja,jv,ka,kab,kk,kk_Arab,kl,km,kn,ko,kok,ku,ky,lb,lij,lo,lt,lv,mai,mi,mk,ml,mn,mni,mr,ms,mt,my,ne,nl,nn,no,nso,oc,om,or,pa,pa_Arab,pap,pcm,pl,ps,pt,pt_PT,qu,quc,rhg,rm,ro,root,ru,rw,sa,sat,sc,sd,si,sk,sl,so,sq,sr,sr_Cyrl,sr_Cyrl_BA,sr_Latn,sr_Latn_BA,su,sv,sw,sw_KE,ta,te,tg,th,ti,tk,tn,to,tr,tt,ug,uk,ur,uz,vec,vi,wo,xh,yo,yo_BJ,yue,yue_Hans,zh,zh_Hant,zh_Hant_HK,zu,

`~/.config/elephant/symbols.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|name_pretty|string|depends on provider|displayed name for the provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|hide_from_providerlist|bool|false|hides a provider from the providerlist provider. provider provider.|
|locale|string|en|locale to use for symbols|
|history|bool|true|make use of history for sorting|
|history_when_empty|bool|false|consider history when query is empty|
|command|string|wl-copy|default command to be executed. supports %VALUE%.|

### Elephant Todo

Basic Todolist

#### Features

- basic time tracking
- create new scheduled items
- notifications for scheduled items
- mark items as: done, active
- urgent items
- clear all done items
- git integration (requires ssh access)

#### Requirements

- `notify-send` for notifications

#### Git Integration

You can set

```toml
location = "https://github.com/abenz1267/elephanttodo"
```

This will automatically try to clone/pull the repo. It will also automatically comimt and push on changes.

#### Usage

##### Creating a new item

If you want to create a scheduled task, you can prefix your item with f.e.:

```
+5d > my task
in 10m > my task
in 5d at 15:00 > my task
jan 1 at 13:00 > my task
january 1 at 13:00 > my task
1 jan at 13:00 > my task
```

Adding a `!` suffix will mark an item as urgent.

##### Time-based searching

Similar to creating, you can simply search for like `today` to get all items for today.


`~/.config/elephant/todo.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|name_pretty|string|depends on provider|displayed name for the provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|hide_from_providerlist|bool|false|hides a provider from the providerlist provider. provider provider.|
|urgent_time_frame|int|10|items that have a due time within this period will be marked as urgent|
|duck_player_volumes|bool|true|lowers volume of players when notifying, slowly raises volumes again|
|categories|[]main.Category||categories|
|location|string|elephant cache dir|location of the CSV file|
|time_format|string|02-Jan 15:04|format of the time. Look at https://go.dev/src/time/format.go for the layout.|
|title|string|Task Due|title of the notification|
|body|string|%TASK%|body of the notification|
#### Category
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|name|string||name for category|
|prefix|string||prefix to store item in category|


### Elephant Unicode

Search for unicode symbols

#### Requirements

- `wl-clipboard`


`~/.config/elephant/unicode.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|name_pretty|string|depends on provider|displayed name for the provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|hide_from_providerlist|bool|false|hides a provider from the providerlist provider. provider provider.|
|locale|string|en|locale to use for symbols|
|history|bool|true|make use of history for sorting|
|history_when_empty|bool|false|consider history when query is empty|
|command|string|wl-copy|default command to be executed. supports %VALUE%.|

