---
name: Modern Humanist Dark
colors:
  surface: '#2D3748'
  surface-dim: '#0d131f'
  surface-bright: '#333946'
  surface-container-lowest: '#080e1a'
  surface-container-low: '#161c27'
  surface-container: '#1a202c'
  surface-container-high: '#242a36'
  surface-container-highest: '#2f3542'
  on-surface: '#dde2f3'
  on-surface-variant: '#c1c7d3'
  inverse-surface: '#dde2f3'
  inverse-on-surface: '#2a303d'
  outline: '#8b919d'
  outline-variant: '#414751'
  surface-tint: '#a4c9ff'
  primary: '#a4c9ff'
  on-primary: '#00315d'
  primary-container: '#4d93e5'
  on-primary-container: '#002a51'
  inverse-primary: '#0060ac'
  secondary: '#53dad5'
  on-secondary: '#003735'
  secondary-container: '#00ada9'
  on-secondary-container: '#003a38'
  tertiary: '#ffb955'
  on-tertiary: '#452b00'
  tertiary-container: '#c68200'
  on-tertiary-container: '#3c2500'
  error: '#FC8181'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#d4e3ff'
  primary-fixed-dim: '#a4c9ff'
  on-primary-fixed: '#001c39'
  on-primary-fixed-variant: '#004883'
  secondary-fixed: '#74f7f1'
  secondary-fixed-dim: '#53dad5'
  on-secondary-fixed: '#00201f'
  on-secondary-fixed-variant: '#00504d'
  tertiary-fixed: '#ffddb4'
  tertiary-fixed-dim: '#ffb955'
  on-tertiary-fixed: '#291800'
  on-tertiary-fixed-variant: '#633f00'
  background: '#0d131f'
  on-background: '#dde2f3'
  surface-variant: '#2f3542'
  text-primary: '#E2E8F0'
  text-secondary: '#A0AEC0'
  border: '#4A5568'
typography:
  display-lg:
    fontFamily: Nunito Sans
    fontSize: 32px
    fontWeight: '800'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Nunito Sans
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 32px
  headline-md-mobile:
    fontFamily: Nunito Sans
    fontSize: 20px
    fontWeight: '700'
    lineHeight: 28px
  headline-sm:
    fontFamily: Nunito Sans
    fontSize: 20px
    fontWeight: '700'
    lineHeight: 28px
  body-lg:
    fontFamily: Nunito Sans
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Nunito Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: Nunito Sans
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
  label-sm:
    fontFamily: Nunito Sans
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  xs: 4px
  base: 8px
  sm: 12px
  md: 16px
  lg: 24px
  xl: 32px
  margin: 20px
  gutter: 16px
---

## Brand & Style

The design system is centered on the concept of **Transparent Empathy**, re-imagined for a high-clarity dark environment. It targets a community-driven audience looking for reliable, clear, and emotionally resonant ways to provide support. The visual language balances professional reliability with a warm, humanist touch, optimized for reduced eye strain and high legibility.

The style is **Modern Humanist Dark**, characterized by:
- **Depth through Luminance:** Utilizing elevated surface grays instead of pure black to maintain a soft, accessible aesthetic.
- **Vibrant Accents:** Strategic use of high-contrast primary and turquoise colors to draw attention to progress and calls-to-action.
- **Clarity:** Uncluttered layouts that prioritize the human story, using soft white typography to ensure readability against dark backgrounds.
- **Softness:** Rounded corners and subtle tonal layering to avoid the "sharp" or "industrial" feel often found in dark interfaces.

## Colors

This palette is optimized for dark mode accessibility, ensuring a minimum contrast ratio of 4.5:1 for all functional elements.

- **Primary (#4A90E2):** The core brand blue, used for high-emphasis actions and active states.
- **Secondary (#48D1CC):** A vibrant turquoise used for growth, success, and positive progress indicators.
- **Tertiary (#F5A623):** An amber accent reserved for urgent alerts or immediate attention.
- **Background (#1A202C):** A deep blue-grey that provides a softer, more premium foundation than pure black.
- **Surface (#2D3748):** Used for cards, sheets, and elevated containers to create a clear visual hierarchy.
- **Typography:** Primary text uses a soft white (#E2E8F0) to prevent the "haloing" effect of pure white on dark backgrounds, while secondary text (#A0AEC0) provides a clear hierarchy for metadata.

## Typography

The typography uses **Nunito Sans** for its balanced, rounded terminals which reinforce the friendly brand personality. In dark mode, the slightly wider tracking of Nunito Sans helps maintain legibility.

- **Weighting:** Headers are bold (`700` or `800`) to provide strong structural anchors. Interactive labels use `600` weight to distinguish them from static body text.
- **Color Application:** Use `text-primary` for all headlines and primary body content. Use `text-secondary` for labels, captions, and supporting information.
- **Mobile Scale:** On mobile devices, `display-lg` should scale down to `headline-md` to maintain optimal line lengths.

## Layout & Spacing

The design system follows a **Fluid Mobile-First** layout model based on an 8px grid system.

- **Margins:** Standard side margins are set to `20px` to give content room to breathe against the dark background.
- **Grid:** Use a 4-column grid for mobile and an 8-column grid for tablet/desktop.
- **Vertical Rhythm:** Use `md` (16px) for related elements and `lg` (24px) for separating distinct sections or cards.
- **Generous Whitespace:** Content blocks should avoid crowding; the dark color palette benefits from increased negative space to reduce visual density.

## Elevation & Depth

In this dark mode system, depth is primarily conveyed through **Tonal Layering** and **Subtle Inner Glows**:

- **Level 0 (Background):** The base `#1A202C` layer.
- **Level 1 (Cards/Surfaces):** The elevated `#2D3748` surface. Shadows should be darker and more spread than in light mode (`0px 8px 24px rgba(0,0,0,0.4)`) to remain visible.
- **Level 2 (Overlays/Modals):** A further lightened version of the surface color or a subtle 1px border (`#4A5568`) to define edges.
- **Backdrop Blur:** Navigation bars and sticky headers should use a 12px blur with a 70% opacity fill of the background color to maintain context without sacrificing legibility.

## Shapes

The shape language is primarily **Rounded**, prioritizing a friendly and approachable feel.

- **Small Elements:** Buttons, Input Fields, and Chips use a 0.5rem (8px) radius.
- **Large Elements:** Campaign Cards and Impact Cards use a 1rem (16px) radius to feel like approachable "containers."
- **Progress Bars:** Should always be fully rounded (Pill-shaped) to represent a fluid, continuous journey.

## Components

### Buttons
- **Primary:** Filled with `primary_color_hex` (#4A90E2), text in `#FFFFFF`. High emphasis.
- **Secondary:** Outlined with `primary_color_hex`, 1.5px border width. Medium emphasis.
- **Success/Progress:** Use `secondary_color_hex` (#48D1CC) for success-related actions.

### Cards
- **Container:** Uses the `surface` color (#2D3748) with a 16px radius.
- **Campaign Card:** Includes a category tag (Label-sm in turquoise), a title (Headline-sm in soft white), and a horizontal progress bar using `secondary_color_hex` for the fill.

### Input Fields
- **Default:** Outlined with `#4A5568` (border) at 1px. Background is a slightly darker shade than the surface.
- **Focus:** The border shifts to `primary_color_hex` at 2px with a subtle outer glow.
- **Text:** Input text uses `text-primary`, while placeholders use `text-secondary`.

### Tracking Timeline
- A vertical line (2px wide, `#4A5568`). Completed stages use a `secondary_color_hex` filled circle; upcoming stages use an outlined circle.

### Bottom Navigation
- Fixed position with a `background` fill at 80% opacity and 12px backdrop blur. Active icons use `primary_color_hex`; inactive icons use `text_secondary`.