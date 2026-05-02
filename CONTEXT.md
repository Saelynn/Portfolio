# Portfolio Website — Project Context

## Overview
A single-page portfolio website for **Dustin N.**, a senior Mechanical Engineering student at Northeastern University (Boston). The site showcases his work in CNC machining, CAD/CAM manufacturing, and cinematography/YouTube content creation.

**File:** `index.html` (single self-contained file — all CSS, HTML, and JS inline; images embedded as base64)

---

## Tech Stack
- Pure HTML/CSS/JavaScript — no frameworks or build tools
- Google Fonts: `Cormorant Garamond` (serif, headings) + `Outfit` (sans-serif, body)
- No external JS libraries

---

## Design System

### Color Palette
| Variable | Value | Usage |
|---|---|---|
| `--chalk` | `#D9D9D9` | Page background |
| `--chalk-lt` | `#E8E8E4` | Light surface |
| `--chalk-dk` | `#C8C8C4` | Dark surface / image bg |
| `--white` | `#F5F5F2` | Card backgrounds |
| `--ink` | `#1A1A18` | Primary text / dark elements |
| `--ink-mid` | `#3A3A36` | Secondary text |
| `--ink-soft` | `#7A7A74` | Muted text / labels |
| `--border` | `rgba(26,26,24,0.12)` | Borders and dividers |

### Typography
- **Headings:** Cormorant Garamond (serif) — light/bold/italic weights
- **Body/UI:** Outfit (sans-serif) — light/regular/medium weights
- Section titles use `clamp()` for fluid sizing

### Layout
- Fixed nav: `68px` height (`--nav-h`)
- Full-viewport-height sections (`100vh - var(--nav-h)`)
- CSS Grid for most layouts (hero, about, projects, YouTube)

---

## Site Structure / Sections

| Section | ID | Notes |
|---|---|---|
| Navigation | `nav` | Fixed top bar; logo, links with dropdown for Projects, social icons (YouTube, LinkedIn) |
| Hero | `#home` | 60/40 grid split — text left, photo right; animated fade-in entries |
| About | `#about` | Bio text + stat numbers + skill cards; white background |
| Projects | `#projects` | Multiple full-viewport rows, each with image gallery + info panel |
| YouTube | `#youtube` | Embedded video + channel stats |
| Skills/Toolkit | `#skills` / `#toolkit` | Pill-style skill tags grouped by category |
| Contact | `#contact` | Dark background CTA with email/social links |
| Footer | `footer` | Minimal copyright bar |

### Projects (nav dropdown entries)
1. **Silvern** — `#silvern-row`
2. **Cable Combs** — `#combs-row`
3. **D5 Pump Bracket** — `#d5-row`
4. **5090 Terminal** — `#gpu-row`
5. **3D Printed Case** — `#printed-row`
6. **Distribution Plates** — `#distro-row`
7. **Sunset Distro** — `#sunset-distro-row`

Project rows alternate layout (`.flip` class swaps gallery/info order). The distro plates project uses a special grid layout (`.distro-row`) with a 4-column photo grid and lightbox.

---

## Key Components

### Gallery (per project)
- Main image + thumbnail strip
- Prev/next arrow buttons (appear on hover)
- Dot indicators
- JS-driven active state on thumbnails

### Distro Lightbox
- Full-screen overlay on image click
- Prev/next navigation
- Close button

### Nav Dropdown
- Hover-triggered dropdown for Projects
- Invisible hover bridge (CSS `::after`) prevents gap-triggered close

### Scroll Reveal
- `.reveal` class + IntersectionObserver (implied by `.visible` toggle)
- Delay utility classes: `.d1` through `.d5`

---

## Social / External Links
- **YouTube:** https://www.youtube.com/@Sae.Dustin
- **LinkedIn:** https://www.linkedin.com/in/sae-dustin/

---

## Change Log

| Date | Change |
|---|---|
| 2026-05-01 | Initial project context document created |
| 2026-05-01 | Added "Sunset Distro" as project #07 — 5 photos embedded as base64, uses `.distro-row` layout with its own lightbox (`#sunset-distro-lightbox`) and JS functions (`openSunsetLightbox`, `sunsetLbNav`, `closeSunsetLightbox`) |
