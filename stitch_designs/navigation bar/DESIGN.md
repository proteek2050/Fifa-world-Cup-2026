# Design System Document: The Midnight Pitch

## 1. Overview & Creative North Star
**The Creative North Star: "The Crimson Theatre"**
This design system moves away from the sterile, grid-locked nature of standard sports apps. It embraces the high-stakes drama of the FIFA World Cup 2026 through a "Crimson Theatre" lens—an editorial, high-end mobile experience designed specifically for the Bangladeshi audience. 

The aesthetic is defined by **Intended Depth** and **Asymmetric Elegance**. Instead of a flat list of scores, we treat the mobile screen as a dark stage where information is spotlighted through layered "frosted" surfaces. We break the template look by using oversized typography, overlapping player imagery, and a tonal palette that mimics the transition from a sunset over Dhaka to the stadium lights of North America.

---

## 2. Colors & Surface Architecture
The palette is rooted in deep maroon and reddish-purples, creating a premium "night mode" default that reduces eye strain while elevating content.

### The "No-Line" Rule
**Explicit Instruction:** Designers are prohibited from using 1px solid borders to section content. Boundaries must be defined solely through background shifts. For example, a `surface-container-low` section sitting on a `background` provides all the separation needed.

### Surface Hierarchy & Nesting
Depth is built through "Tonal Stacking." To create a nested card effect:
1.  **Base:** `background` (#1a1113)
2.  **Section:** `surface-container-low` (#22191b)
3.  **Primary Card:** `surface-container-high` (#31272a)
4.  **Floating Element:** `surface-bright` (#413639)

### The "Glass & Gradient" Rule
To capture the "modern sports" feel, use **Glassmorphism**. Floating navigation bars or quick-action buttons should use `surface` colors at 70% opacity with a `20px` backdrop blur. 
*   **Signature Texture:** Hero backgrounds (like match countdowns) should utilize a linear gradient from `primary_container` (#800021) to `surface` (#1a1113) at a 135-degree angle.

---

## 3. Typography: Editorial Bengali
The typography system prioritizes the beauty of the Bengali script, utilizing clean, high-contrast pairings to ensure readability under stadium lights.

*   **Display (Lexend):** Used for massive scorelines and group letters. It brings a "Global Sports" authority.
*   **Headlines (Lexend):** High-impact, used for match titles (e.g., "ব্রাজিল বনাম আর্জেন্টিনা").
*   **Body & Titles (Plus Jakarta Sans):** These provide a technical, modern counterpoint for player stats and news articles.

**Visual Identity Tip:** Use `display-lg` for single-digit scores and `headline-sm` for team names. The contrast in scale creates an editorial, "magazine" feel rather than a generic app feel.

---

## 4. Elevation & Depth
Traditional drop shadows are too "dirty" for this aesthetic. We use **Ambient Glows** and **Tonal Layering**.

*   **The Layering Principle:** A `surface-container-lowest` card placed on a `surface-container-low` section creates a natural "sunken" effect.
*   **Ambient Shadows:** For "floating" match-day cards, use a shadow with a 32px blur, 0px offset, and 6% opacity, tinted with the `on-surface` (#f0dee1) color.
*   **The "Ghost Border" Fallback:** If a boundary is visually required for accessibility, use the `outline-variant` (#584141) at **15% opacity**. Never use a 100% opaque stroke.
*   **Glassmorphism:** Apply a 0.5px "inner glow" using `primary_fixed_dim` at 10% opacity on the top edge of glass cards to simulate light hitting the edge of a lens.

---

## 5. Components

### Cards (The Core Unit)
*   **Styling:** Use a radius of `1rem` (16px) for standard cards and `1.5rem` (24px) for featured hero cards.
*   **Rules:** No dividers. Use `surface-container-highest` for the header area of a card and `surface-container` for the body to create separation.

### Buttons
*   **Primary:** Solid `primary` (#ffb3b5) with `on-primary` (#680019) text. Shape: `full` (pill-shaped).
*   **Secondary:** Glassmorphism style. `surface-container-high` background at 40% opacity with a subtle `outline-variant` ghost border.
*   **States:** On press, scale the button down to 96% to provide tactile feedback.

### Chips (Tournament Stats)
*   **Match Status Chips:** Use `tertiary_container` (#c9a900) for "Live" indicators with a pulse animation. 
*   **Filtering:** Use `secondary_container` for unselected and `secondary` for selected states.

### Input Fields (Polls & Search)
*   **Style:** Minimalist. No bottom line. A soft `surface-container-highest` pill-shaped background. 
*   **Focus:** Transition the background to `primary_container` at 20% opacity.

### Match Timeline (Custom Component)
*   Avoid a vertical line. Use a series of `surface-container-high` dots. Overlapping the team flags slightly over the edge of the card to break the "box" feel.

---

## 6. Do's and Don'ts

### Do:
*   **Do** use asymmetrical margins. For example, give a headline 24px left padding but 40px right padding to create a "pushed" editorial look.
*   **Do** use `primary_fixed_dim` for small captions to give them a subtle reddish glow.
*   **Do** ensure all Bengali text has a line-height of at least 1.5 to prevent vowel signs (kar/juktakkhor) from touching.

### Don't:
*   **Don't** use pure black (#000000). The `background` (#1a1113) is a deep maroon that feels much more expensive.
*   **Don't** use standard Material Design dividers. If you need to separate content, use an 8px vertical gap.
*   **Don't** use high-contrast white text on the dark background. Use `on-surface` (#f0dee1), which is a soft "bone white" that feels more premium and is easier on the eyes.