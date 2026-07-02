# Avo 3 → 4 upgrade checklist (ticketing.avodemo.com)

Baseline: Avo **3.18.1.tw4** → **4.0.3**. Test suite: **0 runs, 0 failures** (before and after).

Pre-flight: all incremental Avo 3 API migrations from the [2→3 guide](https://docs.avohq.io/3.0/avo-2-avo-3-upgrade.html) were already applied (`Avo::Resources::*`, `def fields` / `def actions` / `def scopes`, etc.).

---

## Get started / Upgrade your gems

**Status: applied**

- Replaced `avo` 3.18.1.tw4 + `avo-advanced` meta-gem with `avo >= 4.0.0.beta` and individual feature gems under `packager.dev`: `avo-menu`, `avo-advanced_search`, `avo-scopes`, `avo-dynamic_filters`.
- Bumped `bootsnap` to `>= 1.18` (1.16.0 failed native compile on Ruby 3.3.0 / this toolchain).
- Bumped `view_component` to `>= 3.7`.
- Ran `bundle install` and `bin/rails avo:update`.

## Icons (Heroicons → Tabler)

**Status: applied**

- Updated `config.main_menu` icons to `tabler/outline/*` prefixes (`clipboard-check`, `ticket`, `user-circle`, `user`, `settings`).

## Avatars and initials

**Status: skipped — NOT USED**

- No `profile_photo`, `cover_photo`, `avatar`, or `cover` resource configuration.

## Search

**Status: applied (partial)**

| Sub-item | Status | Notes |
|----------|--------|-------|
| Resource search behavior change | N/A | No app code changes required |
| Global search rewrite | N/A | No custom global search UI |
| `results_count` removed | NOT USED | |
| Avo Pro mount point removal | NOT USED | No hardcoded `/avo-pro/` URLs |
| `disabled_features` → `global_search` | NOT USED | Was commented out only |
| `help` option removed | NOT USED | |
| `result_path` → `item.path` | NOT USED | |
| `search_type` vs `via_association` / `for_kanban_board` | NOT USED | No branching on those params |
| `params[:q]` → `q` in search procs | applied | `ticket.rb`, `user.rb` |

## Actions — `no_confirmation` → `confirmation`

**Status: skipped — NOT USED**

- `Avo::Actions::ChangeUser` does not set `no_confirmation`.

## Layout

**Status: applied (partial)**

| Sub-item | Status | Notes |
|----------|--------|-------|
| `main_panel` → `panel` + `card` | applied | `app/avo/resources/user.rb` (had sidebar) |
| `Avo::PanelComponent` → `Avo::UI::PanelComponent` | applied | `app/views/avo/tools/settings.html.erb`; `with_body` → `with_card`, `name:` → `title:` |
| `field_container` → `ui.description_list` | NOT USED | |
| `with_tools` → `with_controls` | NOT USED | |
| `panel "Title"` → `panel title:` | NOT USED | |
| `tab "Title"` → `tab title:` | NOT USED | |

## Branding renamed to Appearance

**Status: applied**

- `config.branding` → `config.appearance` in `config/initializers/avo.rb`.
- Only `logo` / `logomark` were set; no `colors:` hash to migrate.

## Components — renamed view type components

**Status: skipped — NOT USED**

- No `self.components` overrides.

## avo-pro and avo-advanced split into feature gems

**Status: applied**

- Gems added match features in use: menu, advanced search, scopes, dynamic filters.
- Not added (not used): `avo-dashboards`, `avo-authorization`, `avo-record_reordering`, `avo-custom_controls`, `avo-nested`, `avo-kanban`, etc.

## Nested association forms

**Status: skipped — NOT USED**

- No `nested:` on association fields.

## Searchable association picker (Algolia → Hotwire)

**Status: skipped — NOT USED**

- No custom CSS targeting `.aa-*` selectors.
- `ChangeUser` action uses `fetch_values_from` (custom endpoint); verify manually in UI.

## Pagination — `size` → `slots`

**Status: skipped — NOT USED**

## Breadcrumbs API

**Status: applied**

- `add_breadcrumb "Settings"` → `add_breadcrumb title: "Settings"` in `Avo::ToolsController`.

## Renamed `profile_photo` → `avatar` / `cover_photo` → `cover`

**Status: skipped — NOT USED**

## Grid item badge DSL

**Status: skipped — NOT USED**

## Discreet information updates

**Status: skipped — NOT USED**

## Removed `cluster` / `row` → `width`

**Status: skipped — NOT USED**

## Map view tweaks

**Status: skipped — NOT USED**

## Cards `description` → `discreet_description`

**Status: skipped — NOT USED**

## `full_width_index_view` → `container_width`

**Status: skipped — NOT USED** (commented out only)

## Silent behavior changes (flagged)

| Change | Applies? | Action |
|--------|----------|--------|
| `explicit_authorization` default `true` | **No runtime impact** | `avo-authorization` gem not installed; `authorization_client` not configured. Pundit policies exist but Avo authorization is inactive. |
| Action `confirmation` default flipped | NOT USED | |
| `params[:via_association]` removed | NOT USED | |
| Dynamic filters `always_expanded` default `true` | **Yes — silent** | App uses `filterable:` fields; filters bar will show expanded by default. No explicit `always_expanded = false` set. |
| Association frames default to `:lazy` loading | **Yes — silent** | `User#tickets` has_many on edit view will lazy-load when scrolled into view. |

---

## Manual verification needed

- **Menu / action icons**: confirm Tabler icons render (no missing/exploded icons in sidebar).
- **Settings tool**: `Avo::UI::PanelComponent` layout and breadcrumbs on `/admin/settings`.
- **User show/edit**: panel + sidebar + lazy-loaded tickets association.
- **Ticket index**: dynamic filters bar expanded by default; filterable columns still work.
- **Ticket/User search**: resource search and `ChangeUser` tags picker (`/admin/resources/users/get_users`).
- **Branding**: logo / logomark on login and admin chrome.
- **Custom CSS**: no `--avo-*` or Algolia `.aa-*` overrides in this app — nothing to migrate.

---

## Post-merge fix: Tailwind / assets (2026-07-02)

**Status: applied**

Deploy failed on `assets:precompile` because the app still used the Avo 3 Tailwind setup:

- `app/assets/stylesheets/avo/tailwind.css` imported `tmp/avo/avo.base.css` (generated only by `avo:sym_link`, not present on Hatchbox deploys).
- `config/avo/tailwind.config.js` required `tmp/avo/tailwind.preset.js`.
- `Procfile.dev` / `package.json` ran legacy yarn tailwind scripts instead of `tailwindcss-rails` 4.

**Changes:**

- Removed Avo 3 tailwind files (`app/assets/stylesheets/avo/tailwind.css`, `config/avo/tailwind.config.js`, `config/tailwind.config.js`).
- Switched dev to `bin/rails tailwindcss:watch` (Tailwind v4 via `tailwindcss-rails ~> 4.2`).
- Set `config.tailwindcss_integration_enabled = true` (default) — host overrides in `app/assets/stylesheets/avo/custom.css`, built to `app/assets/builds/avo/application.css` on precompile.
- `Rakefile` — no custom hooks; Avo 4 hooks `avo:tailwindcss:build` into `assets:precompile` automatically ([docs](https://docs.avohq.io/4.0/tailwindcss-integration.html)).
- Simplified `bin/dev`, `Procfile.dev`, and `package.json` (removed legacy yarn tailwind scripts).
