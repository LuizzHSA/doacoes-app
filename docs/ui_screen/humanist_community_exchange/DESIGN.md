---
name: Humanist Community Exchange
colors:
  surface: '#f9f9ff'
  surface-dim: '#d0daf0'
  surface-bright: '#f9f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f0f3ff'
  surface-container: '#e7eeff'
  surface-container-high: '#dee8ff'
  surface-container-highest: '#d9e3f9'
  on-surface: '#121c2c'
  on-surface-variant: '#414751'
  inverse-surface: '#273141'
  inverse-on-surface: '#ebf1ff'
  outline: '#717783'
  outline-variant: '#c1c7d3'
  surface-tint: '#0060ac'
  primary: '#005da7'
  on-primary: '#ffffff'
  primary-container: '#2976c7'
  on-primary-container: '#fdfcff'
  inverse-primary: '#a4c9ff'
  secondary: '#006a67'
  on-secondary: '#ffffff'
  secondary-container: '#74f7f1'
  on-secondary-container: '#00706d'
  tertiary: '#805200'
  on-tertiary: '#ffffff'
  tertiary-container: '#a16900'
  on-tertiary-container: '#fffbff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
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
  background: '#f9f9ff'
  on-background: '#121c2c'
  surface-variant: '#d9e3f9'
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
  base: 8px
  xs: 4px
  sm: 12px
  md: 16px
  lg: 24px
  xl: 32px
  container_margin: 20px
  gutter: 16px
---

## Brand & Style

The design system is centered on the concept of **Transparent Empathy**. It targets a community-driven audience looking for reliable, clear, and emotionally resonant ways to provide support. The visual language balances professional reliability with a warm, humanist touch.

The style is **Modern Humanist**, characterized by:
- **Clarity:** Uncluttered layouts that prioritize the human story over technical data.
- **Softness:** Rounded corners and diffused shadows to avoid "institutional" coldness.
- **Transparency:** Clear visual indicators of progress and impact to build trust.
- **Energy:** Strategic use of accent colors to highlight urgent needs without inducing anxiety.

## Colors

This design system utilizes a palette designed for emotional resonance and functional clarity:

- **Primary (#4A90E2):** Used for main actions, navigation, and core branding elements to evoke trust.
- **Secondary (#48D1CC):** Represents growth and hope; primarily used for progress indicators and success states.
- **Accent (#F5A623):** Reserved for "Urgent" labels and calls-to-action requiring immediate attention.
- **Neutral:** A deep navy-gray scale provides a sophisticated foundation that remains legible across both modes.

The color mode is adaptive, with the **Dark Mode** utilizing elevated surface grays rather than pure black to maintain a soft, accessible aesthetic during low-light use.

## Typography

The typography uses **Nunito Sans** for its balanced, rounded terminals which reinforce the friendly brand personality. 

- **Headers:** Always bold (`700` or `800`) to provide a strong structural anchor for content.
- **Body:** Use `400` weight for long-form reading to ensure maximum legibility.
- **Labels/Buttons:** Utilize `600` weight (Semi-Bold) to distinguish interactive elements from static text.
- **Mobile Adjustments:** Headlines above 24px should transition to `headline-md` on mobile devices to prevent excessive line-breaking.

## Layout & Spacing

The design system follows a **Fluid Mobile-First** layout model based on an 8px grid system.

- **Margins:** Standard side margins are set to `20px` to give content room to breathe.
- **Grid:** Use a 4-column grid for mobile and an 8-column grid for tablet.
- **Vertical Rhythm:** Use `md` (16px) for related elements and `lg` (24px) for separating distinct sections or cards.
- **Generous Whitespace:** Content blocks should avoid crowding; use `xl` padding for page headers to emphasize a calm, non-frantic experience.

## Elevation & Depth

Hierarchy is established through **Soft Ambient Shadows** and **Tonal Layering**:

- **Level 0 (Background):** Base layer using the background color token.
- **Level 1 (Cards):** Standard surface color with a soft, diffused shadow (`0px 4px 20px rgba(0,0,0,0.05)`).
- **Level 2 (Interactive/Floating):** Used for active states or floating action buttons, featuring a slightly deeper shadow to signify "closeness" to the user.
- **Glassmorphism:** Use a subtle backdrop blur (12px) on the Bottom Navigation bar to maintain context of the content scrolling beneath it.

## Shapes

The shape language is primarily **Rounded**, prioritizing a friendly and approachable feel.

- **Small Elements (8px):** Buttons, Input Fields, and Chips use a smaller radius to maintain a sense of precision and control.
- **Large Elements (16px):** Campaign Cards and Impact Cards use a larger radius to feel like "containers" of value.
- **Progress Bars:** Should always be fully rounded (Pill-shaped) to represent a fluid, continuous journey.

## Components

### Buttons
- **Primary:** Filled with `primary_color_hex`, white text, 8px radius. High emphasis.
- **Secondary:** Outlined with `primary_color_hex`, 1.5px border width, 8px radius. Medium emphasis.

### Cards
- **Campaign Card:** 16:9 aspect ratio for images. Content includes a category tag (Label-sm), a title (Headline-sm), and a horizontal progress bar using `secondary_color_hex` for the fill.
- **Impact Card:** Surface-colored background, no image. Focused on `body-md` text updates with a `secondary_color_hex` checkmark or icon to denote completion.

### Tracking Timeline
A vertical line (2px wide, neutral-light) with circular nodes. Completed stages are filled with `secondary_color_hex`, while upcoming stages are outlined.

### Input Fields
Outlined with `neutral_text_secondary` at 1px. Upon focus, the border shifts to `primary_color_hex` at 2px. Radius is fixed at 8px.

### Bottom Navigation
Fixed position with `blur` background. Active icons use `primary_color_hex`; inactive icons use `text_secondary`. Icons are accompanied by `label-sm` text.