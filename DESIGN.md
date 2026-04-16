# Design System Document: Editorial Beekeeping & Digital Craft

## 1. Overview & Creative North Star
**The Creative North Star: "The Digital Apiary"**
This design system moves away from the rigid, boxy constraints of traditional utility apps to embrace an editorial, organic flow. We treat the interface not as a screen, but as a living ecosystem. Inspired by the meticulous structure of a honeycomb and the fluid nature of honey, the system utilizes **Organic Brutalism**—combining strong, geometric typography with soft, layered surfaces and intentional asymmetry.

We break the "template" look by using exaggerated white space, overlapping elements (e.g., cards bleeding off-center), and a sophisticated hierarchy that prioritizes storytelling over mere data entry.

---

## 2. Colors: Tonal Depth & The "No-Line" Rule
The palette transitions from the earthy `secondary` (#1D6C2E) to the vibrant, sun-drenched `primary_container` (#F7941D). 

### The "No-Line" Rule
To achieve a premium feel, **1px solid borders are strictly prohibited for sectioning.** Boundaries must be defined solely through background color shifts. For example, a `surface_container_low` section should sit directly on a `surface` background. The eye should perceive structure through value changes, not "boxes."

### Surface Hierarchy & Nesting
Treat the UI as a series of physical layers. We use the Material 3 surface tiers to create "nested" depth:
- **Base Layer:** `surface` (#FAF9FF) – The canvas.
- **Sectioning:** `surface_container_low` (#F4F3F9) – For grouping secondary content.
- **Interactive Cards:** `surface_container_lowest` (#FFFFFF) – The highest "lift" to draw immediate focus.

### The "Glass & Gradient" Rule
Flat colors are for utility; gradients are for soul. 
- **CTAs:** Use a linear gradient from `primary` (#8C4F00) to `primary_container` (#F7941D) at a 135° angle.
- **Floating Headers:** Use Glassmorphism. Apply `surface` at 70% opacity with a 20px Backdrop Blur to create a frosted-glass effect that allows content to bleed through elegantly.

---

## 3. Typography: The Editorial Voice
Our typography balances the modern structure of **Poppins** with the technical precision of **Roboto Mono**.

*   **Display & Headlines (Poppins):** Use `headline-lg` for section titles to establish an authoritative, editorial tone. The bold weight conveys the "strength" of the beekeeping community.
*   **Body (Noto Sans / Noto Sans Devanagari):** Chosen for its exceptional legibility in both English and Devanagari scripts at 14sp (`body-md`). It feels approachable and human.
*   **Data/IDs (Roboto Mono):** Used for Hive IDs, Batch Numbers, and sensor data. The monospaced nature signals "accuracy" and "technical data," providing a sophisticated contrast to the organic headings.

---

## 4. Elevation & Depth: Tonal Layering
Traditional drop shadows are often heavy and dated. This system utilizes **Ambient Shadows** and **Tonal Lift**.

*   **The Layering Principle:** Depth is achieved by stacking. A `#FFFFFF` card (`surface_container_lowest`) placed on a `#F0EFF5` background provides enough natural contrast that shadows are often unnecessary.
*   **Ambient Shadows:** If a shadow is required for a floating CTA, use a highly diffused blur (24px+) at 6% opacity, tinted with `primary` (#8C4F00). Avoid pure black or grey shadows.
*   **The "Ghost Border" Fallback:** For input fields where a boundary is mandatory, use a "Ghost Border"—the `outline_variant` token at 20% opacity. It should be felt, not seen.

---

## 5. Components

### Buttons (The "Pollen" Pill)
*   **Primary:** Rounded pill shape (`roundedness.full`). Gradient fill (`primary` to `primary_container`). White bold text. 
*   **Secondary:** Ghost style. No fill, `outline` token at 40% opacity, `on_surface` text.
*   **Behavior:** On press, the gradient should shift 180° or darken slightly to `on_primary_container`.

### Input Fields (The "Clean Cell")
*   **Style:** White background, 12px rounded corners.
*   **Boundary:** A 1px Ghost Border using `#E0D5C5` (outline-variant).
*   **Alignment:** Text is centered for unique brand identity in short inputs (e.g., quantities, IDs), but left-aligned for long-form notes.

### Cards & Lists (The "Unbound" Grid)
*   **Rule:** Forbid the use of divider lines.
*   **Separation:** Separate list items using 12px of vertical white space or by alternating background tones between `surface_container_low` and `surface_container_lowest`.
*   **Shape:** 16px radius for standard cards; 32px (`lg`) for hero dashboard cards to create a "friendly" organic feel.

### Headers (The "Float" Navigation)
*   **Composition:** Transparent background with a central "Pill Badge" for the page title. 
*   **Back Button:** A black circle (32x32dp) with a white icon, positioned asymmetrically to break the grid.

### Bottom Navigation (The "Night Hive")
*   **Style:** Pitch black background (`inverse_surface`) to provide a heavy "anchor" to the light, airy UI above.
*   **Icons:** Pure white icons with `primary_container` (Orange) as the active indicator glow.

---

## 6. Do’s and Don’ts

### Do:
*   **Do** use asymmetrical padding (e.g., 24px left, 16px right) on certain display elements to create an editorial look.
*   **Do** use `secondary` (Forest Green) exclusively for success states and "Honey Collector" specific modules.
*   **Do** allow images of honey/bees to overlap card boundaries slightly to create 3D depth.

### Don’t:
*   **Don’t** use pure black (#000000) for text. Use `on_surface` (#1A1B20) to maintain a soft, premium feel.
*   **Don’t** use standard Material dividers. If you need a line, use a 4px wide, 50% opaque `primary_fixed` vertical bar to the left of the content.
*   **Don’t** crowd the interface. If a screen feels "full," increase the `surface` spacing. This system thrives on "breathing room."

---

## 7. Spacing Scale
We follow a 4px baseline grid, but emphasize large steps for layout:
- **XS:** 4px (tight groupings)
- **SM:** 8px (icon to text)
- **MD:** 16px (internal card padding)
- **LG:** 24px (standard page margins)
- **XL:** 48px+ (hero section breathing room)