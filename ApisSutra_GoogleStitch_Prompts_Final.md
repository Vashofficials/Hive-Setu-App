# 🐝 ApisSutra — Final Google Stitch Prompt Library
### App Suite: AgroSphere (Horticulture) | VanaSutra (Medicinal & Aromatic) | **ApisSutra (Beekeeping)**
### Flutter MVVM + BLoC | Organic Brutalism Design System | India Beekeeping Platform
### Architecture: Clean Architecture | Laravel 11 REST API | Drift SQLite Offline-First

> **How to use this document:**
> This is a task-based prompt library. Every TASK is a self-contained prompt to paste into
> [Google Stitch](https://stitch.withgoogle.com/) via MCP / Antigravity integration.
> Always run **TASK-00 (Master Prompt)** first to seed the design system.
> Then run each screen task individually in the order defined in the Execution Table.
> Tasks marked **[EXISTING — MATCH]** reconstruct screens from the MadhuMitra baseline app.
> Tasks marked **[NEW]** are net-new screens for ApisSutra.
> Tasks marked **[EXTEND]** modify an existing screen with new fields or sections.

---

## ══════════════════════════════════════════════════════
## TASK-00 — MASTER APP PROMPT
## Run This First — Seeds the Design System for All Subsequent Tasks
## ══════════════════════════════════════════════════════

```
APP NAME: ApisSutra
SUITE: Part of the AgroSphere suite (AgroSphere / VanaSutra / ApisSutra)
PURPOSE: India's beekeeping super-app for UP/national beekeepers, honey collectors,
         FPO admins, field extension officers, and government officials.

════════════════════════════════════
DESIGN SYSTEM: "Organic Brutalism — The Digital Apiary"
════════════════════════════════════

PHILOSOPHY:
This app moves away from rigid utility-app boxes to an editorial, organic flow.
Inspired by honeycomb geometry and the fluid nature of honey.
Strong geometric typography + soft, layered surfaces + intentional asymmetry.
Break the template look using exaggerated white space, overlapping elements,
and asymmetrical card placement. Prioritize storytelling over data entry.

COLOR TOKENS (ApisSutra palette — use these variable names everywhere):
  --color-primary:             #8C4F00   (Deep Amber Brown — text, bold labels)
  --color-primary-container:   #F7941D   (Sun Orange — buttons, CTAs, active icons, section titles)
  --color-secondary:           #1D6C2E   (Forest Green — success states, Honey Collector modules)
  --color-on-primary:          #FFFFFF   (White — text on orange CTA buttons)
  --color-surface:             #FAF9FF   (Base canvas — lightest)
  --color-surface-low:         #F4F3F9   (Grouped secondary content)
  --color-surface-lowest:      #FFFFFF   (Interactive cards — highest lift, draws focus)
  --color-on-surface:          #1A1B20   (Body text — NEVER pure #000000)
  --color-on-surface-variant:  #49454F   (Secondary text, placeholders)
  --color-outline-variant:     #E0D5C5   (Ghost border for inputs, 20% opacity)
  --color-error:               #D64045   (Error, Reject, Field Officer role)
  --color-inverse-surface:     #000000   (Bottom nav bar — "Night Hive" anchor)
  --color-amber-alert:         #F59B00   (Offline mode, Pending states)
  --color-govt-teal:           #0E7490   (Government Admin web portal)
  --color-buyer-blue:          #1967D2   (Buyer/Retailer role)
  --color-fpo-purple:          #6B21A8   (FPO Admin role)

THE "NO-LINE" RULE:
  1px solid borders for section dividers are STRICTLY PROHIBITED.
  Use background color shifts between --color-surface-low and --color-surface-lowest.
  Standard Material dividers are FORBIDDEN; use 12px vertical space or tonal shift instead.

THE "GLASS & GRADIENT" RULE:
  All primary CTAs: linear-gradient(135deg, #8C4F00, #F7941D) — deep amber to sun orange.
  Floating headers: --color-surface at 70% opacity + 20px backdrop-blur (glassmorphism).
  Flat solid orange CTAs are allowed only for secondary hierarchy buttons.

ELEVATION SYSTEM:
  Ambient shadows only — blur 24px+, 6% opacity, tinted with --color-primary (#8C4F00).
  NO pure black or grey drop shadows anywhere.
  Ghost Border for inputs: --color-outline-variant (#E0D5C5) at 20% opacity.

TYPOGRAPHY (three-font system):
  Display / Headlines:   GoogleFonts.poppins() — Bold/SemiBold — editorial, authoritative
  Body / Devanagari:     GoogleFonts.notoSansDevanagari() — 14sp — legible, human, bilingual
  Data / IDs / Coords:   GoogleFonts.robotoMono() — 13sp — precision, technical trust

SPACING SCALE (4px baseline grid — emphasize large steps):
  XS: 4px   (tight groupings, icon-to-text)
  SM: 8px   (icon-to-text padding)
  MD: 16px  (internal card padding)
  LG: 24px  (standard page horizontal margins)
  XL: 48px+ (hero section breathing room)

COMPONENT RULES:

  Buttons ("The Pollen Pill"):
    Primary CTA: rounded pill, gradient fill (#8C4F00 → #F7941D at 135°), white Poppins SemiBold 16sp, 56sp height.
    On press: gradient shifts 180° or darkens to #6B3B00.
    Secondary: ghost pill — no fill, --color-outline at 40% opacity, --color-on-surface text.
    Disabled: #E5E5E5 background, #9E9E9E text.
    Minimum tap target: 56sp for primary buttons, 48sp for all others.

  Input Fields ("The Clean Cell"):
    Height: 56sp. Background: white (#FFFFFF). Radius: 12px.
    Inactive border: Ghost Border (#E0D5C5 at 20% opacity).
    Active border: --color-primary-container (#F7941D).
    Short inputs (qty, ID, coordinates): centered text.
    Long inputs (notes, address): left-aligned text.

  Cards ("The Unbound Grid"):
    Standard cards: 16px radius, white (#FFFFFF) bg, ambient shadow (24px blur, 6%, #8C4F00 tint).
    Hero dashboard cards: 32px radius for "friendly" organic feel.
    NO divider lines between list items — use 12px vertical whitespace OR tonal background alternation.
    Images of honey/bees MAY overlap card boundaries slightly to create 3D depth.

  Header ("The Float Navigation"):
    Background: transparent (glassmorphism on scroll — surface 70% + 20px blur).
    Back button: black circle (32x32dp), white icon, placed asymmetrically left.
    Page title: centered "Pill Badge" (gray #E0D5C5 bg for neutral screens,
                orange #F7941D bg for active feature screens).
    Optional action: right-side icon circle (notification bell, filter icon).

  Bottom Navigation ("The Night Hive"):
    Background: pitch black (--color-inverse-surface #000000).
    Icons: pure white (#FFFFFF).
    Active tab indicator: --color-primary-container (#F7941D) circle glow behind icon.
    5 tabs: [Home] [Services] [Camera — center, raised 8dp] [Location] [More]

  Section Titles: --color-primary-container (#F7941D), Poppins SemiBold 16sp.
  List Buddy Items: person icon (line art, gray) + name left + "Add+" orange outlined pill right.
  "Add More+" buttons: orange outlined pill, white bg, #F7941D text + border.

ROLE SYSTEM (single app bundle, JWT role claims):
  Phase 1: 🐝 Beekeeper + Honey Collector (MERGED) — Orange #F7941D
  Phase 2: 🛒 Buyer / Retailer             — Blue   #1967D2
  Phase 2: 🏢 FPO Admin                    — Purple #6B21A8
  Phase 2: 🚨 Field Extension Officer      — Red    #D64045
  Phase 3: 🏛️ Government Admin (React Web) — Teal   #0E7490

TECH STACK:
  Frontend:  Flutter MVVM with BLoC/Cubit state management
  Fonts:     Poppins, Noto Sans Devanagari, Roboto Mono (GoogleFonts package)
  Offline:   Drift SQLite (all critical data stored locally first)
  Push:      Firebase Cloud Messaging
  Payments:  Razorpay (Buyer role)
  Storage:   AWS S3 (photos, PDFs, lab reports)
  API:       Laravel 11 REST API, JWT RS256 auth with role claims
  Maps:      Google Maps Flutter plugin
  Auth:      OTP via SMS (phone-number first, no password)
  Lang:      Bilingual Hindi + English throughout (toggle in Settings)

OFFLINE SYNC BAR (appears below AppBar on all Beekeeper screens):
  Online:  hidden (no bar shown)
  Syncing: orange (#F7941D) bar, "सिंक हो रहा है... / Syncing..." white 12sp
  Offline: amber (#F59B00) bar, "ऑफलाइन मोड — डेटा सुरक्षित है / Offline — Data Saved" white 12sp

UNIVERSAL SUFFIX (add to EVERY screen prompt when running in Stitch):
  "Generate Flutter code using MVVM architecture:
   - [ScreenName]View (StatelessWidget, BLoC consumer)
   - [ScreenName]ViewModel or [ScreenName]Cubit (ChangeNotifier/Cubit, no UI code)
   Use GoogleFonts.notoSansDevanagari() for all Hindi text.
   Use GoogleFonts.poppins() for all English/display text.
   Use GoogleFonts.robotoMono() for all IDs, GPS coordinates, timestamps, batch numbers.
   Minimum tap target: 56sp primary, 48sp secondary.
   All input fields: 56sp height, white bg, 12px radius, inactive border #E0D5C5,
   active border #F7941D orange.
   Offline sync bar below AppBar (see Master Prompt specification).
   NO 1px solid borders for section dividers — use tonal shifts only.
   NO pure black text — use --color-on-surface #1A1B20."

APP IDENTIFIER: ApisSutra (Package: com.agrosuite.apissutra)
```

---

## ══════════════════════════════════════════════════════
## SECTION A — ONBOARDING & AUTHENTICATION
## ══════════════════════════════════════════════════════

---

### TASK-A1 — Splash / Brand Screen
**[NEW — ApisSutra Brand Introduction]**

```
Flutter screen: ApisSutra splash screen with suite context.

Background: Full-screen gradient — top 60% deep amber (#8C4F00) to bottom 40% surface (#FAF9FF).

Center composition (asymmetric — offset slightly upward, 48px from center):
  - ApisSutra logo mark: illustrated bee silhouette in honeycomb hexagon, 96px, white.
  - App name: "ApisSutra" Poppins Bold 36sp, white (#FFFFFF).
  - Tagline: "मधुमक्खी पालक का डिजिटल साथी" Noto Sans Devanagari 14sp, white 80% opacity.
  - Suite badge row (bottom of card, horizontal): 3 small pill chips side-by-side:
      [🌾 AgroSphere] [🌿 VanaSutra] [🐝 ApisSutra ← active, orange fill]
    Inactive chips: white 30% opacity. Active chip: white fill, #8C4F00 text.

Bottom area: "Powered by ApisSutra Platform" Poppins Light 11sp, white 50% opacity, centered.

Animation:
  - Logo mark fades in + scales from 0.8 → 1.0 (400ms ease-out).
  - App name slides up 20px (600ms, 200ms delay).
  - Suite badges appear with stagger 80ms between each pill (800ms total).
  - After 2.5 seconds: navigate to Language Selection (A2).

MVVM: SplashViewModel with initializeApp(), checkAuthState() → routes to A2 or Home.
```

---

### TASK-A2 — Language Selection Screen
**[EXISTING — MATCH + ApisSutra branding]**

```
Flutter screen: ApisSutra language selection — first launch screen.

Background: top half BLACK (#000000), bottom half white rounded card (radius 24px top corners).

CENTER (within black half):
  - ApisSutra bee logo: illustrated bee + "Apis" white Poppins Bold 22sp + "Sutra" orange #F7941D 22sp + honeycomb pattern subtle bg.
  - Below logo: small suite row [AgroSphere] [VanaSutra] [ApisSutra ✓] in tiny white pills.

WHITE CARD (bottom half, rounds up into black area):
  - Title: "Welcome to ApisSutra" black Poppins SemiBold 20sp, centered.
  - Sub: "Select Your Language / अपनी भाषा चुनें" Poppins Medium 15sp gray, centered.

  Two language buttons (full width, rounded pill, 56sp height, 12px gap between):
    1. "English" — BLACK fill, white Poppins SemiBold 16sp (selected state)
    2. "हिन्दी" — white outlined (#E0D5C5 border), #49454F gray text (unselected state)
    On selection: chosen button → BLACK fill + white text. Other → ghost outlined.

  Below buttons: "or" gray small divider row.

  "Confirm" full-width pill button:
    Disabled: gray #E5E5E5 fill, #9E9E9E text.
    Active (language chosen): gradient pill (#8C4F00 → #F7941D), white Poppins SemiBold 16sp.

MVVM: LanguageViewModel with selectedLanguage (enum: hindi / english), confirmAndNavigate().
Navigates to: TASK-A3 (Phone Login).
```

---

### TASK-A3 — Phone Login Screen
**[EXISTING — MATCH EXACTLY]**

```
Flutter screen: ApisSutra phone number OTP login.

Background: --color-surface (#FAF9FF).
Center layout (vertically centered, 48dp side padding):
  - ApisSutra bee logo, 80px, centered.
  - "Welcome to ApisSutra" Poppins SemiBold 20sp, --color-on-surface (#1A1B20), centered.
  - "अपना 10 अंकों का मोबाइल नंबर दर्ज करें" Noto Sans Devanagari Medium 15sp, gray, centered.

Phone input field (white bg, Ghost Border, 56sp height, 12px radius):
  - Left: "+91" Poppins Medium 14sp gray + thin vertical divider (2px, #E0D5C5).
  - Right: text input, "0000000000" placeholder gray, centered numeric keyboard.
  - Active state: orange #F7941D border.

Below field (shown only after number entered):
  "मोबाइल नंबर बदलें / Change Number" — #F7941D underline text link, 13sp, centered.

Legal footer (Noto Sans 12sp gray, centered, 24dp from bottom):
  "साइन अप करके मैं " + "नियम और शर्तें" (orange link) + " और " + "गोपनीयता नीति" (orange link) + " स्वीकार करता हूं"

CTA "OTP भेजें / Generate OTP" button:
  Empty state: gray #E5E5E5, disabled.
  10 digits entered: gradient pill (#8C4F00 → #F7941D), white Poppins SemiBold 16sp, 56sp height.

MVVM: LoginViewModel with phoneNumber (String), isValid (bool), sendOtp() → navigate to A4.
```

---

### TASK-A4 — OTP Verification Screen
**[EXISTING — MATCH EXACTLY]**

```
Flutter screen: 4-digit OTP entry.

Background: --color-surface (#FAF9FF).
Center layout:
  - ApisSutra logo, 60px, centered.
  - "Welcome to ApisSutra" Poppins SemiBold 20sp.
  - "XXXXXXXXXX पर OTP भेजा गया" Noto Sans Devanagari Medium 14sp gray.

4 individual OTP digit boxes (Row, centered, 12px gap):
  Each box: 60x64sp, 12px radius.
  Empty: Ghost Border (#E0D5C5), gray placeholder digit.
  Active/Filled: #F7941D border, --color-on-surface digit, Poppins Bold 22sp.
  Auto-advance on digit entry. Backspace removes digit and returns focus.

Below boxes:
  "OTP नहीं मिला? X सेकंड में पुनः भेजें" Noto Sans 13sp gray, centered.
  "या / or" gray small.
  "मोबाइल नंबर बदलें" orange underline link.

"Login / लॉगिन" button at bottom:
  Incomplete (< 4 digits): ghost pill, gray.
  All 4 entered: gradient pill (#8C4F00 → #F7941D), white Poppins SemiBold 16sp, 56sp.

MVVM: OtpViewModel with otpDigits[4], timerSeconds (60→0), verifyOtp(), resendOtp().
Navigate: new user → A5 Profile Setup. Returning user → B1 Home Dashboard.
```

---

### TASK-A5 — Beekeeper Profile Setup (Empty State)
**[EXTEND — Add Honey Collector role fields + new data from Profile_of_Madhu_Mitra.docx]**

```
Flutter screen: ApisSutra profile setup — merged Beekeeper + Honey Collector role.

HEADER ZONE (top 200px, orange #F7941D gradient background):
  - Illustrated beekeeping scene (hives in mustard field, cartoon style), overlapping header bottom.
  - Back arrow: black circle 32dp, white icon, top-left asymmetric.
  - "प्रोफाइल सेटअप / Profile Set-Up" black Poppins SemiBold 20sp, centered pill badge.

WHITE FORM CARD (rounded 24px top, slides up over orange header, shadow ambient):

PERSONAL DETAILS section (orange section title "व्यक्तिगत जानकारी"):

  Field 1: "पूरा नाम / Full Name" → text input, 56sp, white, Ghost Border.
  Field 2: "WhatsApp नंबर / WhatsApp Number" → tel input, "+91" prefix.
  Field 3: "जन्मतिथि / Date of Birth" → date picker input, "DD/MM/YYYY" placeholder.
  Field 4: "आधार संख्या / Aadhaar Number" → numeric, "XXXX XXXX XXXX", masked.
  Field 5: "ईमेल / Email ID" → email input.
  Field 6: "आपातकाल संपर्क / Emergency Contact" → tel input.

  Gender Selector: "लिंग / Gender"
    Two pill chips side-by-side [👨 पुरुष / Male] [👩 महिला / Female]
    Selected: dark fill + white text. Unselected: white bg, Ghost Border.

SOCIAL CATEGORY (orange title "सामाजिक श्रेणी"):
  7-option chip group (wrap layout, 8dp gaps):
  [सामान्य / General] [OBC] [SC] [ST] [EBC] [अल्पसंख्यक / Minority] [अन्य / Other]
  Selected: #F7941D fill, white text. Unselected: white, #F7941D border.

SOCIAL STATUS (orange title "सामाजिक स्थिति"):
  6-option chip group:
  [BPL] [APL] [भूमिहीन / Landless] [लघु किसान / Marginal Farmer]
  [छोटे किसान / Small Farmer] [बड़े किसान / Large Farmer]

EDUCATION (orange title "शैक्षिक योग्यता"):
  Single-select chip row (scroll horizontal):
  [निरक्षर] [प्राथमिक] [माध्यमिक] [उच्च माध्यमिक] [स्नातक] [स्नातकोत्तर]

ADDRESS section (orange title "पता / Address"):
  Sub-fields stacked: Village | Post Office | Panchayat | Block | Police Station | District | Pin Code | State
  (These fields map to the geo-tagging system used in migration and harvest log)

BEEKEEPING ACTIVITY section (orange title "मधुमक्खी पालन गतिविधि"):
  "आप क्या करते हैं? / Your Activity:" — 3-chip selector (full-width wrap):
    [🐝 मधुमक्खी पालन / Beekeeping]
    [🌿 जंगली शहद संग्रह / Wild Honey Collection]
    [🐝🌿 दोनों / Both]
  Selected: gradient fill. Unselected: white bg, #F7941D border.

  "मधुमक्खी पालन कब से / Beekeeping Since:" → year input, "2015" placeholder.

  IF "जंगली शहद" OR "दोनों" is selected — expand 2 additional fields:
    "वन क्षेत्र / Forest Zone" dropdown: [Terai Belt] [Bundelkhand] [Eastern UP Forest] [Other]
    "मुख्य वन जिला / Primary Forest District" text input.

MEMBERSHIP section (orange title "सदस्यता"):
  "FPO/FPC नाम" text input.
  "NBB सदस्यता संख्या / National Bee Board Membership No." text input, Roboto Mono keyboard.

Generate ApisSutra ID note:
  Gray card (surface-low bg, 16px radius):
  Icon: bee + barcode. Text: "सबमिट करने पर आपका ApisSutra Beekeeper ID जनरेट होगा"
  Poppins Medium 13sp, #49454F.

Fixed Bottom:
  "रजिस्टर करें / Register" — gradient pill (#8C4F00 → #F7941D), white Poppins SemiBold 16sp, 56sp.
  Disabled until Name + Phone + Address + Activity fields are filled.

MVVM: ProfileViewModel with all fields, collectionType (enum), forestZone, submit() → generates BeeKeeperID.
```

---

### TASK-A6 — Profile Setup Filled State (Reference Screen)
**[EXISTING — MATCH for Stitch validation pass]**

```
Flutter screen: Profile setup with all fields completed — used for Stitch visual validation.

Same layout as TASK-A5, but all fields filled:
  - Name: "राम नारायण शर्मा"
  - WhatsApp: "9865413549"
  - Gender: Male chip active (gradient fill)
  - Social Category: OBC chip active
  - Social Status: Small Farmer chip active
  - Education: Graduate chip active
  - Address: Village = "बहराइच", District = "बहराइच", State = "Uttar Pradesh"
  - Activity: "दोनों / Both" chip active (both forest fields visible and filled)
  - Forest Zone: "Terai Belt"
  - Beekeeping Since: "2018"
  - FPO Name: "श्री राम किसान FPO"
  - NBB No: "NBB-UP-2024-00847"

All active input fields: orange #F7941D border.
"Register" button: fully active gradient pill.

MVVM: same ProfileViewModel — all valid, submit enabled.
```

---

## ══════════════════════════════════════════════════════
## SECTION B — BEEKEEPER + HONEY COLLECTOR CORE SCREENS
## ══════════════════════════════════════════════════════

---

### TASK-B1 — Home Dashboard
**[EXTEND — Add Wild Honey card, Activity Calendar strip, Hive Activity status]**

```
Flutter screen: ApisSutra merged-role home dashboard.

HEADER ROW (transparent, glassmorphism on scroll):
  Left: Beekeeper avatar illustration (warm Indian-style, 60px circle, orange border).
  Center-left text: "नमस्ते 🙏" Poppins Bold 20sp + "राम नारायण जी!" Poppins SemiBold 18sp.
  Right: notification bell (orange circle, 40px) + profile avatar circle (gray border).

WEATHER CARD (orange gradient #F7941D → #E8841A, 32px radius hero card, 48dp top margin):
  Left: large weather icon (sun/cloud, 64px) + "28°C" Poppins Bold 36sp + "बहराइच, UP" Noto Sans 12sp gray.
  Wind: 💨 12 km/h | Humidity: 💧 65%.
  Right: 4-day mini forecast (2×2 grid) — each: weather icon + "°C" small.
  Bottom strip: 5-icon horizontal: [☀️→⛅→🌧️→❄️→▶] scroll for weekly.
  NOTE: Ambient shadow 24px, 6% opacity, #8C4F00 tint. Card overflows 8px left asymmetrically.

PROFILE PROGRESS BAR (white card, 16px radius, 16dp margin top):
  "प्रोफाइल प्रगति / Profile Progress" Poppins SemiBold 14sp + "(प्रोफाइल पूरी करें)" gray small.
  5-step horizontal stepper:
    Filled circle + check: completed. Current: dark circle + step number. Remaining: empty ring + number.
    Labels below: [नाम] [पता] [WhatsApp] [ईमेल] [आधार]

MY APIARY SECTION (section title "मेरी एपियरी / My Apiary" #F7941D SemiBold 16sp):
  Hero card (32px radius, white, ambient shadow, image of beehives overlapping card top-right by 16px):
    - Apiary name "एपियरी 01" Poppins Bold 18sp.
    - Stats row: [🐝 45 छत्ते] [🍯 Apis mellifera] [📅 2018 से]
    - Orange "विस्तार देखें →" pill link right-bottom.

ACTIVITY CALENDAR STRIP (section title "इस माह की गतिविधि / This Month's Activity"):
  Derived from Honey Bee Hive Activity Calendar data.
  Horizontal scroll of 5 action chips for current month:
    (e.g., November) → [+ सुपर चैंबर] [रानी जांच] [रोग निरीक्षण] [माइग्रेशन प्लान] [शहद निष्कर्षण]
  Each chip: small icon + Noto Sans 12sp text. Active/pending: orange. Completed: green check.

MIGRATION SECTION (section title "माइग्रेशन / Migration" #F7941D):
  Illustrated card (beekeepers with hives on cart, forest background).
  Status pill: "सक्रिय — बहराइच → श्रावस्ती" green pill if active, "योजना बनाएं" orange pill if idle.
  Orange "→" arrow right-side.

WILD HONEY SECTION — Forest Green (#1D6C2E gradient card, 32px radius):
  ONLY shown if user role = collector OR both.
  Left: leaf + honey drop icon, white illustrated, 48px.
  "जंगली शहद लॉग करें" white Poppins SemiBold 16sp.
  "आज का नया संग्रह दर्ज करें" white Noto Sans 13sp.
  Right: white circle arrow button → navigates to B-HC1.

PHOTO IDENTIFICATION SECTION (section title "फोटो से पहचानें / Identify via Photo"):
  3-step flow row: [📷 फोटो लें] → [ℹ️ जानकारी पाएं] → [📱 कार्रवाई करें]
  "Capture" button: BLACK filled rounded pill, white Poppins SemiBold 15sp, full width.

QUICK ACCESS ROW ("अन्य / Others"):
  3 circular icon buttons (60px, white, ambient shadow):
  [🍯 Hive Products] [🐛 Bee Health] [🌸 Bee Flora]
  Labels below: Noto Sans 12sp.

BOTTOM NAVIGATION ("Night Hive" — #000000 bar):
  [🏠 Home (active, orange glow)] [🛠️ Services] [📷 Camera (center, raised 8dp)] [📍 Location] [⋮ More]

MVVM: HomeViewModel with userSubRole, weatherData, apiaryStats, monthlyCalendarTasks, navigate().
```

---

### TASK-B2 — My Apiary Management Screen
**[EXTEND — Incorporate full My_Apiary.docx data structure]**

```
Flutter screen: Detailed apiary setup and management.

Header: back arrow (black circle) + "मेरी एपियरी / My Apiary" orange pill badge.
Hero: cartoon apiary illustration (colorful hives in field), 180px, ambient shadow overflows 8px right.

APIARY DETAIL FORM (white card, 24px radius, 16dp padding):
  Section title: "एपियरी विवरण / Apiary Details" #F7941D SemiBold 16sp.

  "एपियरी का नाम / Apiary Name" → text input, "Apiary 01" placeholder.
  "बॉक्स का प्रकार / Type of Bee Box" → dropdown [Langstroth] [Newton] [ISI Standard] [Log Hive].
  "स्थापना वर्ष / Year Established" → year input, "2018".
  "कुल बी हाइव्स / Total Bee Hives" → numeric stepper [−][45][+].
  "ब्रूड वाले छत्ते / Hives with Brood" → numeric stepper [−][38][+].
  "ब्रूड + सुपर वाले छत्ते / Hives with Brood + Super" → numeric stepper [−][22][+].
  "प्रति चैंबर फ्रेम / Frames per Chamber" → numeric input "10".

BEE SPECIES SECTION (section title "मधुमक्खी की प्रजाति / Bee Species"):
  5-chip multi-select group (from My_Apiary.docx):
    [Apis dorsata 🐝] [Apis cerana indica 🐝] [Apis florea 🐝]
    [Apis mellifera 🐝] [Melipona iridipennis 🐝]
  Selected: gradient fill. Unselected: white, orange border.
  NOTE: Melipona is stingless bee — if selected, show info tooltip.

LOCATION GEO-TAG (section title "स्थान / Location"):
  Mini Google Maps embed, 150px height, 16px radius, showing current or entered GPS.
  Below map: "GPS: 27.5706°N, 81.5958°E" Roboto Mono 12sp gray. "स्थान बदलें" orange link.
  Address auto-fill from Profile: Village + Post Office + Block + District.

Fixed bottom: "पुष्टि करें / Confirm" gradient pill, white Poppins SemiBold 16sp, 56sp.

MVVM: ApiaryViewModel with name, boxType, hiveCount, broodCount, broodSuperCount,
       framesPerChamber, speciesList, gpsLocation, confirm().
```

---

### TASK-B3 — Hive Products Tracking Screen
**[EXTEND — Incorporate full Bee_products.docx data structure]**

```
Flutter screen: Complete hive product yield tracking with harvest diary.

Header: back arrow + "हाइव उत्पाद / Hive Products" gray pill.

PRODUCT ENTRY CARDS — 7 products (from Bee_products.docx):
  Each product section follows this pattern:
    Section title row: [product emoji] + "Product Name" #F7941D Poppins SemiBold 16sp + "लॉग जोड़ें +" orange pill right.

  Below each title: White card (16px radius, ambient shadow) with form row:
    [emoji icon 20px] | "Product Name" | [Qty input "00.0" Roboto Mono] | [kg/g/ml unit gray]

  7 products:
    1. 🍯 शहद / Honey                — unit: kg
    2. 🕯️ मोम / Beeswax              — unit: kg
    3. 🌸 पराग / Pollen               — unit: g
    4. 🔴 प्रोपोलिस / Propolis        — unit: g
    5. 👑 रॉयल जेली / Royal Jelly    — unit: g
    6. ⚡ मधुमक्खी विष / Bee Venom   — unit: ml
    7. 🍯 कॉम्ब हनी / Comb Honey     — unit: kg

HARVEST LOG ENTRY MODAL (triggered by "लॉग जोड़ें +"):
  Bottom sheet (white, 24px top radius, drag handle):
    "फसल विवरण / Harvest Details" Poppins SemiBold 18sp.
    "कटाई की तारीख / Date of Harvesting" → date picker.
    "कटाई की मात्रा / Quantity Harvested" → numeric + unit.
    "भंडारण / Stored In" → chip selector: [Bucket] [Tin] [Drum]
    "फ्लोरा/किस्म / Flora or Variety" → text input (e.g., "Litchi", "Mustard").
    "किसने काटा / Harvested By" → text input (beekeeper name or team).
    Confirm button: gradient pill, full width.

Fixed bottom: "सहेजें / Save All Products" gradient pill, 56sp.

MVVM: HiveProductsViewModel with productMap<ProductType, List<HarvestEntry>>, addEntry(), save().
```

---

### TASK-B4 — Beekeeping Do's and Don'ts Screen
**[NEW — Incorporate Beekeeping_Do_s_and_Don_ts.docx full data]**

```
Flutter screen: Best practices reference guide for beekeepers.

Header: back arrow + "सर्वोत्तम प्रथाएं / Best Practices" orange pill badge.

SEARCH BAR (white rounded, 48sp, orange icon):
  "खोजें / Search do's & don'ts..." placeholder.

TABS ROW (orange underline indicator):
  [✅ करें / Do's] [❌ न करें / Don'ts]

DO'S TAB (13 items from Beekeeping_Do_s_and_Don_ts.docx):
  Each item card (white, 16px radius, ambient shadow, 8dp vertical gap between cards):
    Left: green check circle icon (32px, #1D6C2E fill, white check).
    Content: "S.No. — Do statement" Noto Sans Devanagari 14sp --color-on-surface.
    Hindi + English both shown (stacked: Hindi primary, English secondary 12sp gray).

  Full list:
    1. नियमित मोम नवीनीकरण और यदि आवश्यक हो तो एसिटिक एसिड से धुमन का उपयोग करें।
    2. केवल ऑफ-सीजन या आपात स्थिति में भोजन दें।
    3. चारा तैयार करने के लिए हमेशा स्वच्छ जल का उपयोग करें।
    4. केवल पका और सील किया हुआ शहद ही काटें।
    5. ऐसे किसी भी रसायन से बचें जो शहद को दूषित कर सकते हैं।
    6. स्मोकर में प्राकृतिक उत्पादों का उपयोग करें, रसायनों से मुक्त।
    7. शहद निष्कर्षण बंद, मधुमक्खी-मुक्त क्षेत्र में करें।
    8. लूटपाट और दूषण से बचने के लिए सुपर चैंबर ढकें।
    9. उपयोग से पहले हमेशा उपकरण साफ करें।
    10. उचित वस्त्र पहनें और बी-वर्क के दौरान संदूषण से बचें।
    11. सुविधा में उचित कार्यशील प्रकाश होना चाहिए।
    12. शहद भंडारण के लिए हमेशा खाद्य-ग्रेड कंटेनर का उपयोग करें।
    13. शहद को स्वास्थ्यकर स्थिति में और धूप से दूर रखें।

DON'TS TAB (16 items from Beekeeping_Do_s_and_Don_ts.docx):
  Each item card: left: RED circle X icon (32px, #D64045 fill, white ×).

  Full list:
    1. पशु चिकित्सा दवाओं का उपयोग न करें।
    2. मोम पतंगे नियंत्रण के लिए कीटनाशकों का उपयोग न करें।
    3. शहद प्रवाह के दौरान भोजन न दें।
    4. शर्करा सिरप तैयार करने के लिए अपेय जल का उपयोग न करें।
    5. कच्चा शहद न काटें।
    6. शहद काटते समय प्रतिरोधक का उपयोग न करें।
    7. स्मोकर में विषाक्त रसायनों वाले पदार्थों का उपयोग न करें।
    8. खुले क्षेत्र में शहद न निकालें।
    9. बिना ढके सुपर चैंबर स्थानांतरित न करें।
    10. शहद के साथ काम करते समय गंदे उपकरण का उपयोग न करें।
    11. शहद निकालते समय घड़ी या आभूषण न पहनें।
    12. अंधेरे में काम न करें।
    13. मधुमक्खियों को शहद निष्कर्षण सुविधा में प्रवेश न करने दें।
    14. बिना साफ किए और गैर-खाद्य-ग्रेड कंटेनर का उपयोग न करें।
    15. शहद को अनुचित स्थिति में संग्रहीत न करें।
    16. भंडारण के दौरान शहद को गर्म न करें।

Fixed bottom FAB: orange circle "⭐ सहेजें / Save Favorites" for bookmarking key rules.

MVVM: BestPracticesViewModel with dosItems, dontsItems, searchQuery, bookmarked[].
```

---

### TASK-B5 — Activity Calendar Screen
**[EXTEND — Full 12-month data from Honey_Bee_Hive_Activity_Calendar.docx]**

```
Flutter screen: Honey Bee Hive Activity Calendar for Apis mellifera & Apis cerana indica.

Header: back arrow + "कैलेंडर / Calendar" orange pill badge.

CALENDAR YEAR VIEW (full-width, 12-month grid card, orange border 2px, 32px radius):
  Illustrated calendar: "2025 / 2026" in large Poppins Bold 36sp dark navy.
  12 mini month-grids in 4×3 layout (Jan–Dec).
  Current month highlighted: orange outline + darker grid.
  Activity dots on key dates: orange = honey flow, green = migration, red = pest alert.

MONTH ACTIVITY DETAIL (white card, 16px radius, below calendar):
  Month selector: horizontal scroll of 12 month pills (orange active, gray inactive).

  For each month, show the following data (from Honey_Bee_Hive_Activity_Calendar.docx):

  ─── JANUARY ───
  🌡️ Season: "शीतकाल / Winter (कम तापमान)"
  Key Activities (checklist cards):
    ✓ छत्तों को गर्म और ठंडी हवाओं से बचाएं।
    ✓ हाइव प्रवेश कम करें।
    ✓ यदि चारा न हो तो चीनी सिरप दें।
    ✓ रोग और रानी उपस्थिति के लिए निरीक्षण करें।
  Objective: "कालोनी की शक्ति बनाए रखें और भुखमरी रोकें।"

  ─── FEBRUARY ───
  🌱 Season: "पूर्व-वसंत / Pre-Spring (कालोनी निर्माण)"
  Key Activities:
    ✓ कॉम्ब फाउंडेशन और फ्रेम जोड़ें।
    ✓ प्रोटीन सप्लीमेंट (पराग विकल्प) देना शुरू करें।
    ✓ सरसों, धनिया जैसी फसलों के लिए तैयार हों।
  Objective: "आगामी शहद प्रवाह के लिए कालोनी बनाएं।"

  ─── MARCH ───
  🌸 Season: "मुख्य शहद प्रवाह / Main Honey Flow (लीची, सरसों, यूकेलिप्टस)"
  Key Activities:
    ✓ शहद भंडारण के लिए सुपर चैंबर जोड़ें।
    ✓ कालोनी को परेशान करने से बचें।
    ✓ झुंड के संकेतों की जांच करें।
    ✓ सील किया हुआ शहद काटना शुरू करें।
  Objective: "प्रवाह अवधि के दौरान शहद उत्पादन अधिकतम करें।"

  ─── APRIL ───
  🌿 Season: "शहद प्रवाह का अंत / End of Honey Flow"
  Activities: शहद निष्कर्षण पूरा करें। पुराने छत्ते बदलें। छाया और पानी दें। जामुन वनस्पति पर जाएं।
  Objective: "कटाई के बाद कालोनी की शक्ति बनाए रखें।"

  ─── MAY ───
  ☀️ Season: "गर्म और शुष्क / Hot & Dry"
  Activities: छत्तों को अधिक गर्म होने से रोकें। पर्याप्त पानी दें। कमजोर कालोनियों को मिलाएं। मोम पतंगे और चींटियों पर नजर रखें।
  Objective: "गर्मी में कालोनी का जीवित रहना सुनिश्चित करें।"

  ─── JUNE ───
  🌧️ Season: "पूर्व-मानसून / Pre-Monsoon"
  Activities: बारिश के दौरान प्रवास से बचें। हाइव बॉक्स और स्टैंड की मरम्मत करें। चीनी सिरप और पराग विकल्प दें। वेरोआ माइट नियंत्रण करें।
  Objective: "कम वनस्पति अवधि के दौरान ब्रूड पालन बनाए रखें।"

  ─── JULY ───
  🌊 Season: "मानसून / Monsoon (कमी अवधि)"
  Activities: छत्तों को शुष्क, ऊंचे स्थानों पर रखें। नमी प्रवेश से बचें। भोजन जारी रखें। तल बोर्ड नियमित साफ करें।
  Objective: "रोग और कालोनी हानि रोकें।"

  ─── AUGUST ───
  🌦️ Season: "देर मानसून / Late Monsoon"
  Activities: भोजन जारी रखें। रानी कोशिकाओं की जांच करें। कमजोर रानियों को बदलें। मानसून के बाद शहद प्रवाह की तैयारी करें।
  Objective: "अगले सीजन के लिए कालोनी मजबूत करें।"

  ─── SEPTEMBER ───
  🌱 Season: "मानसून के बाद / Post-Monsoon (वनस्पति वृद्धि)"
  Activities: नए चारे क्षेत्रों में कालोनी स्थानांतरित करें। हाइव उपकरण साफ और कीटाणुरहित करें। नए फ्रेम और फाउंडेशन शीट जोड़ें।
  Objective: "अगले शहद प्रवाह के लिए कालोनी तैयार करें।"

  ─── OCTOBER ───
  🍂 Season: "शरद / Autumn (चारा सुधरता है)"
  Activities: ब्रूड पालन को प्रोत्साहित करें। जरूरत पड़ने पर पूरक आहार दें। लूटपाट व्यवहार देखें। सरसों और यूकेलिप्टस प्रवाह की तैयारी शुरू करें।
  Objective: "शीत प्रवाह से पहले मजबूत चारागाह बनाएं।"

  ─── NOVEMBER ───
  🌾 Season: "शुरुआती शीत / Early Winter (मुख्य प्रवाह सीजन)"
  Activities: सरसों या यूकेलिप्टस फसलों के पास कालोनी रखें। मजबूत रानी और ब्रूड सुनिश्चित करें। भंडारण के लिए सुपर चैंबर जोड़ें। रोगों की नियमित जांच करें।
  Objective: "मुख्य शहद उत्पादन सीजन।"

  ─── DECEMBER ───
  ❄️ Season: "शीतकाल / Winter (कम गतिविधि)"
  Activities: हाइव प्रवेश कम करें। खाद्य भंडार जांचें। छत्ता और आसपास साफ करें। कालोनी को परेशान करने से बचें।
  Objective: "कालोनियों को ठंड से बचाने की तैयारी करें।"

MIGRATION PLANNING (section title "माइग्रेशन / Migration" orange):
  "माइग्रेशन तारीख" date range input: "24 जनवरी से 24 अप्रैल 2025" centered black.
  "वनस्पति विवरण / Flora Details" tappable input → navigates to Flora screen.

MVVM: CalendarViewModel with selectedMonth, activityData, migrationDates, navigate().
```

---

### TASK-B6 — Migration Planning Screen
**[EXTEND — Full Migration.docx data including Flora table]**

```
Flutter screen: Detailed migration entry form with flora database.

Header: back arrow + "माइग्रेशन / Migration" orange pill badge.
Hero: cartoon migration illustration (beekeepers with hives on bullock cart, forest background), 200px, ambient shadow.

MIGRATION FORM (white card, 24px radius):

  Section: "माइग्रेशन अवधि / Migration Period" (#F7941D SemiBold 16sp):
    "दिनों की संख्या / Number of Days" → numeric input "400".
    "प्रस्थान तारीख / Departure Date" → date picker.
    "वापसी तारीख / Return Date" → date picker. Auto-calculates days.

  Section: "गंतव्य / Destination" (#F7941D SemiBold 16sp):
    "स्थान / Location" → text input.
    Geo-tag capture sub-card:
      Auto-capture: Village | Post Office | Panchayat | Block | Police Station | District | Pin Code | State
      (Matches Migration.docx geo-tag specification exactly)
    Mini Google Maps embed (150px, rounded 16px) showing destination pin.

  Section: "बी-बॉक्स विवरण / Bee Box Details" (#F7941D SemiBold 16sp):
    "बी-बॉक्स की संख्या / No. of Bee Boxes" → numeric stepper [−][24][+].
    "ब्रूड वाले छत्ते / Hives with Brood" → numeric stepper [−][18][+].
    "ब्रूड + सुपर वाले छत्ते / Hives with Brood + Super" → numeric stepper [−][10][+].

  Section: "वनस्पति विवरण / Flora Details" (#F7941D SemiBold 16sp):
    Searchable dropdown of all flora from Migration.docx Flora table:

    PRIMARY FLORA TABLE (selectable chips, horizontal scroll, 2 rows):
      [सरसों / Mustard — Dec-Feb]
      [लीची / Litchi — Mar-Apr]
      [यूकेलिप्टस / Eucalyptus — Oct-Jan]
      [सूरजमुखी / Sunflower — Dec-Feb]
      [रबर / Rubber — Feb-Apr]
      [कॉफी / Coffee — Jan-Mar]
      [जामुन / Jamun — May-Jun]
      [बबूल / Acacia — Feb-Apr]
      [नीम / Neem — Apr-Jun]
      [महुआ / Mahua — Feb-Apr]
      [करंज / Karanj — Mar-May]
      [क्लोवर / Clover — Jan-Mar]
      [धनिया / Coriander — Feb-Apr]
      [अजवाइन / Ajwain — Dec-Feb]

    SECONDARY FLORA TABLE (smaller chips):
      [अमरूद/Guava — Feb-Apr] [सिट्रस/Citrus — Feb-Apr] [तिल/Sesame — Aug-Oct]
      [तोरिया/Toria — Nov-Jan] [कपास/Cotton — Jul-Sep] [मक्का/Maize — Jul-Aug]
      [अरहर/Pigeon Pea — Oct-Dec] [तुलसी/Basil — Year Round] [बेर/Ber — Jan-Mar]

    Selected flora chips: gradient fill. Botanical name shown in Roboto Mono 11sp below chip.

  Section: "माइग्रेशन फोटो / Migration Photos" (#F7941D SemiBold 16sp):
    Upload card (white, dashed border #E0D5C5, 100px height):
      "AI-सहायता के लिए फोटो अपलोड करें" Noto Sans 13sp gray, inside.
      "Capture" inner white pill button.

Fixed bottom: "सबमिट करें / Submit" gradient pill, white Poppins SemiBold 16sp, 56sp.

MVVM: MigrationViewModel with days, departure, returnDate, geoTag, beeboxCount, floraList, photos, submit().
```

---

### TASK-B7 — Products for Sale Screen
**[NEW — Full Product_for_Sale.docx data]**

```
Flutter screen: Hive products marketplace listing — what the beekeeper wants to sell.

Header: back arrow + "बिक्री के लिए उत्पाद / Products for Sale" orange pill.

TABS: [उपलब्ध / Available] [सूचीबद्ध / Listed] [बिके / Sold]

AVAILABLE TAB — New Listing Form:
  Section: "उत्पाद चुनें / Select Product" (#F7941D SemiBold):
    7-product chip grid (2 rows, from Product_for_Sale.docx):
    [🍯 शहद / Honey] [🍯 कॉम्ब हनी / Comb Honey] [🕯️ मोम / Beeswax]
    [🌸 पराग / Pollen] [🔴 प्रोपोलिस / Propolis] [👑 रॉयल जेली / Royal Jelly] [⚡ मधुमक्खी विष / Bee Venom]

  For HONEY (expanded when selected) — includes extra quality params:
    "वजन / Weight (kg)" → numeric + unit.
    "भंडारण / Stored In" → chip: [Bucket] [Tin].
    "फ्लोरा / Flora Variety" → text input (e.g., "Litchi Honey").
    "स्थान / Location (Geo Tag)" → auto-captured GPS + Village, District, State.

    QUALITY PARAMETERS section (#1D6C2E green section title):
      "नमी / Moisture Content (%)" → numeric, orange border when filled.
      "फोम / Foam Formation" → chip: [Yes] [No].
      "क्रिस्टलीकरण / Crystallisation" → chip: [Yes] [No].

    LAB TEST REPORT:
      "लैब रिपोर्ट / Lab Test Report" → toggle [Yes/No].
      IF Yes: Upload PDF button (dashed white card, "PDF अपलोड करें" gray text inside, 80px height).

    PHOTOS: "फोटो अपलोड करें / Upload Pics" with Geo Tag:
      Horizontal photo add strip: [+ फोटो 1] [+ फोटो 2] [+ फोटो 3] (each 80x80px rounded, dashed border).

  For ALL OTHER PRODUCTS (Comb Honey, Beeswax, Pollen, Propolis, Royal Jelly, Bee Venom):
    "वजन या मात्रा / Volume or Weight" → numeric + unit.
    "भंडारण / Stored In" → chip: [Bucket] [Tin].
    "फ्लोरा / Flora Variety" → text input.
    "स्थान / Location (Geo Tag)" → auto GPS.
    Photos section (same as honey).

  "FPO को सबमिट करें / Submit to FPO" → gradient pill 56sp.
  "मसौदा सहेजें / Save Draft" → ghost outlined pill.

LISTED TAB: Shows active marketplace listings with status badges + edit/delist options.
SOLD TAB: History with buyer name, price received, date.

MVVM: ProductSaleViewModel with selectedProduct, qualityParams, photos, geoTag, submit(), saveDraft().
```

---

### TASK-B8 — Alert & Companion Management
**[EXISTING — MATCH EXACTLY]**

```
Flutter screen: Emergency alert contacts and bee buddy network.

Background: --color-surface (#FAF9FF).
Header: back arrow (black circle) + "Alert" #F7941D orange pill (center) + "Help" green pill (#1D6C2E) (right).

SECTION 1 — "साथी जोड़ें / Adding Companion" (#F7941D Poppins SemiBold 18sp, left-aligned):
  Top-right: "Add More+" orange outlined pill button.

  Companion Form Block (white card, 16px radius, ambient shadow):
    "साथी का पूरा नाम / Full Name of Companion" → input showing "Nitin Deep".
    "साथी से संबंध / Relation" → input showing "Friend/Family".
    "साथी का ईमेल / Email" → input showing "nitindeep@gmail.com".
    "साथी का मोबाइल / Contact Number" → input showing "8794561589".

  IF "Add More+" tapped: duplicate form block appears below for 2nd companion.

SECTION 2 — "बी बडी जोड़ें / Adding Bee Buddy" (#F7941D Poppins SemiBold 18sp):
  Sub-label: "नजदीकी बडी / Nearby Buddy's" black Noto Sans 14sp.

  Buddy list (5 items, each row 48sp height):
    [person icon line art 24px gray] + [buddy name Noto Sans 14sp dark] + ["Add +" orange pill right]
    Items: [Aditya keeper] [Manoj keeper] [Prince keeper] [Katyy keeper] [Kartik keeper]
    Note: NO dividers between items — 8px vertical whitespace separation only.

Fixed bottom: "पुष्टि करें / Confirm" gradient pill, white Poppins SemiBold 16sp, 56sp.

MVVM: AlertViewModel with companions[], nearbyBuddies[], addCompanion(), addBuddy(), confirm().
```

---

### TASK-B9 — Flora Identification Screen
**[EXISTING — MATCH EXACTLY + Expand flora data from Migration.docx]**

```
Flutter screen: Bee flora identification, map, and camera capture.

Header: back arrow + "वनस्पति / Flora" gray pill + notification bell icon right.
Hero banner: full-width illustrated flower garden (colorful, cartoon style), 200px height, overflows 8px right asymmetrically.

Search bar (below hero, white rounded pill, 48sp, orange magnifier icon left):
  "वनस्पति खोजें / Search Flora..." placeholder.

"वनस्पति पहचान / Flora Identification" Poppins SemiBold 16sp black.

FLORA CARDS (white, 16px radius, ambient shadow, NO dividers):
  4 featured flora cards (representing all seasonal categories):

  Card 1 — सरसों / Mustard:
    Left: "सरसों / Mustard" Poppins Bold 20sp + "Brassica campestris" Roboto Mono 11sp gray.
    Season: "दिसंबर–फरवरी / Dec–Feb".
    Region: "उत्तर भारत / North India".
    Bee Attractiveness: 🐝🐝🐝 "High".
    Common in Region: "Yes".
    Right: 80x80px rounded photo of mustard flowers.

  Card 2 — लीची / Litchi (Mar–Apr, Bihar/JH/WB).
  Card 3 — यूकेलिप्टस / Eucalyptus (Oct–Jan, UP/Punjab/Haryana).
  Card 4 — जामुन / Jamun (May–Jun, North & Central India).

  "और देखें / View All 25+ Flora ▾" orange text link (expands to full searchable list with all Migration.docx flora).

FLORA MAP VIEW:
  "🗺️ वनस्पति मानचित्र / Flora Map View" — black filled pill button with location pin icon, full width.
  Navigates to Location screen with flora overlay enabled.

IDENTIFY VIA CAMERA (section title "कैमरे से पहचानें"):
  3-step row: [📷 फोटो लें] → [ℹ️ जानकारी पाएं] → [📱 कार्रवाई करें]
  "Capture" → BLACK filled rounded pill, white Poppins SemiBold 15sp, full width.
  Navigates to Camera screen (B10) in flora identification mode.

MVVM: FloraViewModel with floraList (all 25+ from Migration.docx), searchQuery, capturePhoto().
```

---

### TASK-B10 — Camera Screen (Bee/Hive Identification)
**[EXISTING — MATCH EXACTLY — two states]**

```
Flutter screen: Camera viewfinder for bee, hive, pest, and flora capture.

STATE 1 — Hive Capture Mode:
  Header: back arrow (black circle) + "Camera / कैमरा" gray pill + flash toggle circle (black, right).
  Full-screen camera viewfinder with live preview.
  Viewfinder overlay: rounded-corner bracket frame (4 corners, black rounded corner lines, 200x200px).
  Top overlay: "छत्ते की पहचान मोड / Hive Identification Mode" white pill, transparent dark bg.
  Bottom controls (on viewfinder, 16dp from bottom):
    [✕ black circle left — cancel] [⊙ large shutter center (white ring, dark center, 72px)] [▶ right — gallery]
  Bottom nav: Night Hive black bar, Camera tab active (orange glow).

STATE 2 — Flora/Pest Identification Mode:
  Header: same + camera rotate icon top-right on viewfinder.
  Top overlay: "वनस्पति/कीट पहचान / Flora/Pest ID Mode" white pill.
  Bracket overlay same size.
  Bottom controls: [gallery icon left] [⊙ shutter center] [AI-identify icon right (person + ✨)]
  AI indicator: top-right of viewfinder: pulsing green dot + "AI: तैयार / Ready" green small.

Post-capture flow: navigates to identification result overlay with AI confidence score.

MVVM: CameraViewModel with captureMode (enum: hive/flora/pest/general), photo, navigateToResult().
```

---

### TASK-B11 — Location Map Screen
**[EXISTING — MATCH EXACTLY]**

```
Flutter screen: GPS map of beekeeper's position, nearby buddies, and flora zones.

Header: back arrow + "स्थान / Location" gray pill + "Alert 🚨" BLACK filled pill (right).

Full-width Google Maps widget (55% screen height, 16px rounded corners):
  User marker: solid black teardrop pin with "आप / You" white label.
  Bee buddy markers: person stick-figure icon, orange.
  Flora markers: flower/lotus icon, green.
  Map tile: Google Maps standard style.
  Zoom controls: bottom-right of map widget.

LEGEND (below map, white card, 16px radius):
  Row 1: 🧑 person icon + "अन्य बी बडी / Other Bee Buddies" Noto Sans 14sp dark.
  Row 2: 🌸 flower icon + "मधुमक्खियों के लिए वनस्पति / Flora for Bees" Noto Sans 14sp dark.
  NOTE: NO divider line between rows — tonal background shift only.

"अलर्ट भेजें / Send Alert" button below legend:
  Black filled rounded pill, white Poppins SemiBold 15sp, full width.

Bottom nav (Night Hive): Location tab active (orange glow).

MVVM: LocationViewModel with userLocation, nearbyBuddies[], floraZones[], sendAlert().
```

---

### TASK-B12 — Bee Health / Pest Information Screen
**[EXISTING — MATCH EXACTLY]**

```
Flutter screen: Comprehensive pest and disease guide.

Header: back arrow + "मधुमक्खी स्वास्थ्य / Bee Health" gray pill.

"कीट जानकारी / Pest Information" Poppins SemiBold 18sp, left-aligned.
Description paragraph Noto Sans 14sp gray (from Bee Health data).

"कीट पहचानें / Identify Pest" Poppins SemiBold 18sp centered (section divider).

PEST CATEGORIES (clean list, NO card borders, tonal alternation only):

  1️⃣ परजीवी कण / Parasitic Mites (Poppins SemiBold 14sp):
    🔸 Varroa Destructor (Varroa Mite)
      • वैश्विक स्तर पर सबसे विनाशकारी मधुमक्खी कीट।
      • मधुमक्खियों के वसा निकायों और रक्त पर फ़ीड करता है।
      • मधुमक्खियों को कमजोर करता है और वायरस फैलाता है।
    🔸 Tropilaelaps Mite
      • वेरोआ के समान लेकिन तेज प्रजनन चक्र।
      • मुख्यतः एशिया में पाया जाता है।

  🐜 2️⃣ कीड़े / Insects:
    🔸 Wax Moths (Greater: Galleria mellonella, Lesser: Achroia grisella)
    🔸 Small Hive Beetle (Aethina tumida)
    🔸 Ants / चींटियां
    🔸 Wasps & Hornets / ततैया और भिड़

  🐀 3️⃣ कृन्तक और स्तनधारी / Rodents & Mammals (continues scrolling):
    🔸 Mice / चूहे
    🔸 Bears / भालू (where applicable, forest apiaries)

  🦠 4️⃣ रोग / Diseases:
    🔸 American Foulbrood (AFB)
    🔸 European Foulbrood (EFB)
    🔸 Nosema (Nosema apis / Nosema ceranae)
    🔸 Chalkbrood / चाकब्रूड

Camera identify CTA at bottom: "📷 कैमरे से पहचानें / Identify with Camera" — gradient pill.

MVVM: PestInfoViewModel with pestCategories[], searchQuery, captureForIdentification().
```

---

### TASK-B13 — Chat Support Screen
**[EXISTING — MATCH EXACTLY]**

```
Flutter screen: Support channel selection hub.

Background: --color-surface (#FAF9FF).
Header: back arrow (black circle) + "चैट सहायता / Chat Support" orange pill.

Large vertical spacing (screen breathes — support options centered with XL spacing).

Three circular icon buttons (Row, evenly spaced, white circles, 2px #F7941D border, 90px diameter, ambient shadow):
  1. Left: 🎤 Microphone icon (orange 32px) → "वॉयस सहायता / Voice Support" Poppins SemiBold 13sp below.
  2. Center: 💬 Chat bubble (orange) → "चैट सहायता / Chat Support" Poppins SemiBold 13sp below.
  3. Right: 📹 Video camera (orange) → "वीडियो सहायता / Video Support" Poppins SemiBold 13sp below.

No bottom nav (back arrow only navigation from this screen).

MVVM: ChatSupportViewModel with navigateToVoice(), navigateToChat(), navigateToVideo().
```

---

### TASK-B14 — Profile Screen
**[EXISTING — MATCH EXACTLY + ApisSutra ID]**

```
Flutter screen: User profile display page.

Header: back arrow + "प्रोफाइल / Profile" gray pill.
Hero: cartoon beekeeping background illustration (beekeeper with hive in forest), full width 180px,
      image bleeds 12px off right edge (Organic Brutalism asymmetry).

PROFILE CARD (white, 32px radius hero card, overlaps hero image bottom by 24px, ambient shadow):
  Left: profile avatar circle (bee-on-honeycomb illustrated, orange border, 70px).
  Right content:
    Name: "राम नारायण शर्मा" Poppins SemiBold 18sp + verified checkmark badge (orange circle, white tick).
    Phone: "9865413549" Noto Sans 14sp.
    Email: "ramnaran@gmail.com" Noto Sans 13sp.
    Aadhaar: "8954 XXXX XXXX" Noto Sans 13sp + eye icon (orange) to reveal.
    ApisSutra ID: "APS-UP-2024-7823" Roboto Mono 13sp #F7941D.
    "संपादित करें / Edit" orange outlined pill button with edit icon, small, right-aligned.

MENU LIST (white card, 16px radius, 16dp margin top):
  Each row: icon (orange 24px left) + label Poppins Medium 15sp + chevron ▶ right.
  NO dividers — 12px vertical whitespace between rows.
  Rows:
    ℹ️ मेरी जानकारी / My Information
    ⭐ रेट करें / Rate Us
    🐝 मधुमक्खी पालन के बारे में / About Beekeeping
    🤝 सहायता / Support
    ⚙️ सेटिंग / Settings
    ↩ लॉगआउट / Log Out

Footer: "नियम और शर्तें" gray + "© ApisSutra 2025" gray, Noto Sans 11sp centered.

MVVM: ProfileViewModel with userData, editProfile(), logout(), navigateTo().
```

---

### TASK-B15 — More Screen
**[EXISTING — MATCH EXACTLY]**

```
Flutter screen: More options / feature discovery menu.

Header: back arrow + "अधिक / More" gray pill.

4 large expandable feature cards (full width, 32px radius, 2px #F7941D border, 150px height, 20px gap between):
  Each card: full-width background illustration + black filled pill button left (label) + ▾ dropdown circle right.
  Image overflows top of card by 8px (Organic Brutalism depth).

  Card 1: Yellow/honey gradient bg + 🔬 "गुणवत्ता परीक्षण / Quality Testing" black pill.
  Card 2: Calendar illustration bg + 📅 "कैलेंडर / Calendar" black pill.
  Card 3: Forest/pest illustration bg + 🐛 "कीट और रोग / Pest & Disease" black pill.
  Card 4: Beekeeper outdoor illustration bg + 🐝 "अपनी मधुमक्खी जानें / Know Your Bee" black pill.

Bottom nav (Night Hive): More tab active (orange glow).

MVVM: MoreViewModel with navigateTo(section: enum CalendarScreen | PestScreen | QualityScreen | BeeInfoScreen).
```

---

### TASK-B16 — Settings Screen
**[EXTEND — Full bilingual settings from design system]**

```
Flutter screen: ApisSutra user settings — role-aware.

Header: #F7941D gradient, "सेटिंग / Settings" white Poppins SemiBold 20sp.

PROFILE SUMMARY CARD (white, 16px radius, 4px #F7941D left border):
  Avatar + "राम नारायण शर्मा" + "🐝 बी-कीपर + 🌿 संग्रहकर्ता" role badge + "APS-UP-2024-7823" Roboto Mono.

LANGUAGE SECTION (section title "भाषा / Language"):
  Row: 🌐 icon + "भाषा" label + right: pill toggle ["हिंदी" ↔ "English"] orange active.

NOTIFICATION PREFERENCES (section title "सूचनाएं / Notifications"):
  Each row: icon + label + right: iOS-style toggle (orange = ON, gray = OFF):
    🔔 कीट अलर्ट / Pest Alerts [ON]
    📅 मौसमी सलाह / Seasonal Advisory [ON]
    🛒 मार्केटप्लेस / Marketplace Updates [ON]
    📢 FPO प्रसारण / FPO Broadcasts [ON]
    🌿 जंगली शहद / Wild Honey Reminders [ON — only visible if collector role]

DATA SYNC (section title "डेटा सिंक / Data Sync"):
  Status row: "✓ अंतिम सिंक: आज 09:47 AM" green small + "अभी सिंक करें / Sync Now" orange text link right.
  Storage row: "📱 स्थानीय डेटा / Local Storage: 47 MB" + "साफ करें / Clear" gray link right.

SUPPORT (section title "सहायता / Support"):
  📞 WhatsApp हेल्पलाइन → "wa.me/18001234567" tappable.
  🐛 समस्या रिपोर्ट करें / Report Issue → navigates to bug report form.
  ⭐ ऐप रेट करें / Rate App → opens app store.

ACCOUNT (section title "खाता / Account" with red warning label):
  📥 डेटा निर्यात करें / Export My Data (DPDP compliance) → generates ZIP download.
  🗑️ खाता हटाएं / Delete Account → red text, confirmation dialog.
  ↩ लॉगआउट / Log Out → red outlined pill.

Footer: "v2.1.0 • Build 210 • ApisSutra" Roboto Mono 11sp gray centered.
       "AgroSphere Suite — ApisSutra | VanaSutra | AgroSphere" gray Noto Sans 10sp.

MVVM: SettingsViewModel with language, notifications, syncStatus, logout(), exportData(), deleteAccount().
```

---

## ══════════════════════════════════════════════════════
## SECTION B-HC — WILD HONEY COLLECTOR (NEW SCREENS)
## Forest Green #1D6C2E theme — merged into ApisSutra
## ══════════════════════════════════════════════════════

---

### TASK-HC1 — Wild Harvest Log Screen
**[NEW — Honey Collector Dashboard]**

```
Flutter screen: Wild Honey Harvest log for merged Beekeeper+Collector role.
Forest Green #1D6C2E theme. Matches ApisSutra MVVM style.

Header: Forest Green #1D6C2E gradient, "जंगली शहद लॉग / Wild Harvest Log" white Poppins SemiBold 20sp.
Back arrow (white circle). Filter icon (white, right) — date range / forest zone / FPO filter.

SUMMARY STRIP (white bg, 12px border-bottom tonal):
  3 stat chips in a row (pill shaped, 8dp gap):
    [🍯 कुल: 42 kg — #1D6C2E fill, white] [✓ FPO अनुमोदित: 38 kg — green] [⏳ लंबित: 4 kg — amber #F59B00]

OFFLINE SYNC BAR (below summary strip per universal spec).

HARVEST LIST (white cards, 16px radius, 12dp vertical gap, ambient shadow):
  Each card row:
    Left: color dot (8px circle) — Terai Belt = forest green, Bundelkhand = amber, Eastern UP = teal.
    Content:
      Harvest date: Roboto Mono 13sp #49454F.
      Forest zone + honey type: Poppins Medium 14sp --color-on-surface.
      Weight badge: "12.5 kg" #F7941D rounded pill.
    Right column:
      FPO status badge: "अनुमोदित ✓" #1D6C2E green pill / "समीक्षाधीन ⏳" amber / "अस्वीकृत ✗" red.
      Chevron ▶ (navigates to harvest detail).

EMPTY STATE:
  Illustrated forest scene with bee, centered.
  "अभी तक कोई संग्रह नहीं" Poppins SemiBold 16sp dark.
  "पहला संग्रह दर्ज करें!" Noto Sans 13sp gray.
  "नया संग्रह जोड़ें +" green gradient pill CTA.

FAB: Forest Green circle "+" (56dp, bottom-right, 24dp margin) → navigates to HC2.

MVVM: WildHarvestViewModel with harvestList, totalKg, approvedKg, pendingKg, filterState, navigate().
```

---

### TASK-HC2 — Geo-Tag Photo Capture Screen
**[NEW — Harvest site GPS + photo capture]**

```
Flutter screen: GPS geo-tag + photo capture for wild honey harvest site.
Matches ApisSutra camera UI style with Forest Green accents.

Full-screen camera viewfinder.

TOP OVERLAY BAR (semi-transparent dark, 60px height):
  Back arrow (white, left).
  "हार्वेस्ट साइट फोटो / Harvest Site Photo" white Poppins 18sp center.
  GPS indicator top-right: pulsing green dot + "GPS: सक्रिय / Active" green label.
  If acquiring: "GPS: खोज रहे हैं... / Acquiring..." amber blinking.

VIEWFINDER: same bracket overlay as Camera screen (B10). 4 corner marks.

BOTTOM CONTROL PANEL (dark gradient, 120px height):
  Left: gallery icon (white, pick existing photos).
  Center: shutter button — large white ring, dark center, 72px diameter. Same style as B10.
  Right: flash toggle icon (white).

GPS STAMP PREVIEW (appears after photo captured — white card, 24px radius, slides up from bottom):
  Left: Photo thumbnail (80x80px, 12px radius).
  Right content:
    GPS: "27.5706°N, 81.5958°E" Roboto Mono 13sp.
    Timestamp: "15 जुलाई 2025, 09:43 AM" Noto Sans 13sp.
    Forest Zone dropdown pill: [Terai Belt ▾] Forest Green fill, white text.
    "निर्देशांक बदलें / Override Coords" #1D6C2E underline text link (manual GPS entry).
  Drag handle top of card.

CTA: "आगे बढ़ें / Continue" Forest Green gradient pill, white Poppins SemiBold 16sp, 56sp. Fixed bottom.

MVVM: GeoTagViewModel with currentLocation, capturedPhoto, forestZone (enum), manualOverride.
Navigate to: HC3 Harvest Detail.
```

---

### TASK-HC3 — Harvest Detail Entry Screen
**[NEW — Full harvest data form]**

```
Flutter screen: Wild harvest detail form — step 2 of 3 in harvest submission flow.
Forest Green #1D6C2E header. White form with ApisSutra input style.

Header: Forest Green gradient, "संग्रह विवरण / Harvest Details" white Poppins SemiBold 20sp.
Back arrow white. Progress indicator: "चरण 2 / 3 — Step 2 of 3" white small right.

PHOTO STRIP (horizontal scroll, 80px height):
  First slot: auto-inserted geo-tagged photo from HC2 (checkmark overlay). "+ जोड़ें" dashed slots.

FORM SECTIONS (white card body, 24px top radius):

  "शहद का प्रकार / Honey Type" (#1D6C2E Forest Green label):
    3-option segmented pill selector (full width):
      [🌿 जंगली कॉम्ब / Wild Comb] [💧 तरल शहद / Liquid Honey] [🍯 मिश्रित / Mixed]
      Selected: Forest Green fill, white text. Unselected: white, green border.

  "अनुमानित वजन / Est. Weight (kg)" (#1D6C2E label):
    Row: [−] gray button + number input "0.0" (white, orange active border) + [+] gray button + "kg" gray suffix.

  "रंग ग्रेड / Colour Grade" (#1D6C2E label):
    5 honey-color swatches (horizontal row, 40px circles, 8dp gap):
      [🟡 Water White #FFF8E1] [🟡 Extra White #FFE57F] [🟠 White #FFCC02] [🟠 Amber #FF9800] [🟤 Dark Amber #795548]
      Label below each swatch: Noto Sans 11sp gray.
      Selected: Forest Green border ring (2px) + scale 1.1 effect.

  "विशेष नोट्स / Special Notes" (#1D6C2E label):
    Multiline text area, 4 lines, white bg, Ghost Border. Left-aligned text (long form).

  "वन क्षेत्र / Forest Zone" (#1D6C2E label):
    Dropdown (pre-filled from HC2 geo-tag, editable):
      Options: [Terai Belt] [Bundelkhand] [Eastern UP Forest] [Other — manual entry]

  GPS READ-ONLY (from HC2 geo-tag):
    Light gray bg card (surface-low), 12px radius, 8dp padding:
    "📍 27.5706°N, 81.5958°E" Roboto Mono 13sp #49454F.

  "संग्रह दिनांक / Collection Date":
    Date picker input, "DD/MM/YYYY" style.

PRIMARY CTA: "FPO को सबमिट करें / Submit to FPO" Forest Green gradient pill, 56sp, white text. Fixed bottom.
SECONDARY: "मसौदा सहेजें / Save Draft" outlined Forest Green ghost pill, above primary CTA.

MVVM: HarvestDetailViewModel with honeyType, weight, colorGrade, notes, forestZone, collectionDate, submit(), saveDraft().
```

---

### TASK-HC4 — Quality Submit to FPO Screen
**[NEW — Final FPO submission step]**

```
Flutter screen: Submit wild harvest to FPO for quality verification — step 3 of 3.
Forest Green theme.

Header: Forest Green gradient, "FPO सबमिशन / FPO Submission" white. Back arrow.
Progress: "चरण 3 / 3" white right.

SUBMISSION SUMMARY CARD (white, 16px radius, 4px #F7941D left border, ambient shadow):
  Left: harvest photo thumbnail (70x70px, 12px radius).
  Right (2-column micro-grid):
    📅 "तारीख" | "15 जुलाई 2025" Noto Sans 13sp.
    🌲 "वन क्षेत्र" | "Terai Belt" Noto Sans 13sp.
    🍯 "शहद प्रकार" | "जंगली कॉम्ब" Noto Sans 13sp.
    ⚖️ "वजन" | "12.5 kg" Poppins SemiBold 14sp orange.
  GPS: "📍 27.5706°N, 81.5958°E" Roboto Mono 12sp below content.

"FPO चुनें / Select FPO" (#1D6C2E section title):
  Radio list (max 4 FPOs, white card each, 56sp row):
    Left: FPO initials circle (orange 40px). FPO Name Poppins SemiBold 14sp + District Noto Sans 12sp gray.
    Rating: ★★★★☆ small. "127 सदस्य" count small right.
    Selected: Forest Green left border (3px) + green radio fill.

"डिजिटल हस्ताक्षर / Digital Signature" (#1D6C2E section title):
  Signature draw canvas (white, 2px dashed #E0D5C5 border, 120px height):
    Hint: "यहाँ हस्ताक्षर करें / Sign Here" gray Noto Sans 14sp centered.
  "मिटाएं / Clear" text link (#1D6C2E, below canvas).

SUBMIT CHECKLIST (must all be checked to enable CTA):
  3 rows (custom orange checkbox → Forest Green check when ticked):
    ☐ "दी गई जानकारी सही है / Information is accurate"
    ☐ "अपलोड की गई फोटो असली है / Photo is genuine"
    ☐ "मैं FPO समीक्षा से सहमत हूं / I agree to FPO review"

CTA: "सबमिट करें / Submit" — Forest Green gradient pill, disabled gray until all 3 checked. 56sp.

SUCCESS OVERLAY (animated, covers screen after submit):
  Large animated green checkmark (Lottie animation, 120px).
  "सबमिट हो गया! / Submitted!" Poppins Bold 24sp white.
  "FPO 24 घंटे में जवाब देगा / FPO will respond within 24 hours" Noto Sans 14sp white 80%.
  Forest Green gradient full-screen bg.
  "होम पर जाएं / Go Home" white outlined pill, bottom.

MVVM: FpoSubmitViewModel with selectedFpo, signature, checkboxStates[3], submit() → success overlay.
```

---

### TASK-HC5 — ApisSutra Digital Beekeeper ID Card
**[NEW — Digital identity for beekeepers and collectors]**

```
Flutter screen: Digital beekeeper + collector identity card.

Header: #F7941D orange gradient, "मेरी पहचान / My Identity" white Poppins SemiBold 20sp.

DIGITAL ID CARD (white, 2px #F7941D border, 20px radius, ambient shadow, subtle honeycomb hex pattern bg texture, 85% screen width, centered, aspect ratio 1.6:1):

  TOP STRIP (orange gradient, 36px height):
    ApisSutra bee icon (white, 20px) + "ApisSutra | AgroSphere Suite" white Poppins 10sp right.

  CARD BODY (white, 16dp padding):
    Left column:
      Profile photo circle (64px, 2px orange border ring).
      Below: ApisSutra ID "APS-UP-2024-7823" Roboto Mono 14sp bold #F7941D.

    Right column (60% width):
      Name: "राम नारायण शर्मा" Poppins Bold 16sp --color-on-surface.
      Role badge: "🐝 मधुमक्खी पालक + 🌿 संग्रहकर्ता" small #F7941D dual-label pill.
      District: "बहराइच, उत्तर प्रदेश" Noto Sans 12sp gray.
      Since: "2018 से / Since 2018" gray small.
      Colonies: "45 छत्ते / Colonies" Noto Sans 13sp dark.
      NBB No: "NBB-UP-2024-00847" Roboto Mono 11sp gray.

  BOTTOM ROW:
    Left: QR code (90x90px, black+white, links to verification URL: apissutra.com/verify/APS-UP-2024-7823).
    Right: "भारत सरकार • मधुमक्खी पालन विकास • NBB" teal #0E7490 Noto Sans 10sp.

ACTION BUTTONS (3 in a row, all orange outlined ghost pills, below card):
  [📥 PDF डाउनलोड] [📤 शेयर करें] [🔍 QR स्कैन करें]

FOOTER NOTE (gray Noto Sans 12sp, centered, below buttons):
  "किसी भी FPO या सरकारी कार्यालय में QR स्कैन कर सत्यापित करें।"

MVVM: IdentityViewModel with profile, qrUrl, downloadCard() → PDF, shareCard(), scanQr().
```

---

## ══════════════════════════════════════════════════════
## SECTION C — BUYER / RETAILER ROLE (PHASE 2)
## Blue #1967D2 theme
## ══════════════════════════════════════════════════════

---

### TASK-C1 — Buyer Marketplace Browse
**[NEW — Phase 2]**

```
Flutter screen: Buyer/Retailer honey marketplace home.
Role color: Buyer Blue #1967D2.

Header: Blue gradient, "ApisSutra बाज़ार / Marketplace" white Poppins Bold 22sp.
Sub: "शुद्ध शहद, सीधे मधुमक्खी पालक से / Pure Honey, Direct from Beekeeper" white Noto Sans 12sp.

SEARCH BAR (white rounded pill, 52sp, blue magnifier icon):
  "शहद खोजें / Search honey, variety, region..." placeholder.
  Filter icon (blue circle, right).

CATEGORY CHIPS (horizontal scroll, below search, 8dp gap):
  [🍯 सभी / All] [🌸 लीची] [🌿 सरसों] [🌲 जंगली] [🌳 यूकेलिप्टस] [🌻 सूरजमुखी] [⭐ FSSAI प्रमाणित]
  Active: Blue fill, white text. Inactive: white, blue border.

FILTER ROW (below chips, compact pill row):
  [₹ Price Range ▾] [State ▾] [Sort: Rating ▾]

PRODUCT GRID (2 columns, white cards, 16px radius, ambient shadow, 12dp gap):
  Each card:
    Product photo (140px height, rounded 16px top, image overlaps card top 4px).
    "FSSAI ✓" green pill badge top-left.
    "ट्रेसेबल 🔗" orange pill badge top-right (if blockchain trace available).
    Product name: Poppins Medium 14sp --color-on-surface.
    Beekeeper: "राम लाल • बहराइच" Noto Sans 12sp gray.
    Rating: ★★★★☆ 4.8 (32) small.
    Price: "₹320/kg" Poppins Bold 16sp #1967D2.
    "कार्ट में डालें / Add to Cart" blue filled rounded pill, 40sp, full width of card bottom.

Bottom nav (Night Hive with Blue active indicator):
  [🛒 बाज़ार (active)] [📦 मेरे ऑर्डर] [❤️ विशलिस्ट] [👤 प्रोफाइल]

MVVM: MarketplaceViewModel with productList[], filters, addToCart(productId), navigate().
```

---

### TASK-C2 — Product Detail + Farm-to-Buyer Traceability
**[NEW — Phase 2]**

```
Flutter screen: Full product page with verifiable traceability chain.

Sticky header: back arrow + "उत्पाद विवरण / Product Detail" gray pill + share icon right.
Hero photo gallery: PageView 260px height, dot indicators bottom-center.

PRODUCT INFO (white card, 20px padding, 32px top radius):
  Name: "लीची शहद — बहराइच, UP" Poppins Bold 22sp --color-on-surface.
  Price: "₹320 / kg" Blue #1967D2 Poppins Bold 26sp.
  Rating row: ★★★★★ 4.8 • (47 समीक्षाएं) Noto Sans 13sp.

  QUALITY CHIPS (horizontal scroll, Roboto Mono 12sp):
    [नमी: 18.2%] [HMF: 12 mg/kg] [रंग: अंबर] [फसल: अप्रैल 2025]

  "🔬 लैब रिपोर्ट PDF देखें" Blue underline link, 13sp.

BEEKEEPER CARD (#FFF1DC amber-light bg, 16px radius, 4px #F7941D left border):
  Avatar + ApisSutra ID badge "APS-UP-2024-7823" Roboto Mono 12sp orange.
  Name + District + Rating + "Follow करें" orange outlined pill.

TRACEABILITY CHAIN (section title "🔗 खेत से आप तक / Farm to You" Poppins SemiBold 18sp):
  Vertical orange dotted line connecting 5 steps (step icon left, content right):
    Step 1 🐝: "एपियरी — बहराइच, UP" + GPS mini-map thumbnail.
    Step 2 📅: "फसल — 15 अप्रैल 2025" + photo thumbnail 60x60px.
    Step 3 🏢: "FPO अनुमोदन — श्री राम FPO" + "अनुमोदित ✓" green stamp.
    Step 4 🔬: "लैब परीक्षण — FSSAI प्रमाणित" + cert icon.
    Step 5 🛒: "मार्केटप्लेस लिस्टिंग" + "Live 🟢" pulsing badge.

STICKY CTA BOTTOM (gradient above it, card blends in):
  "₹320/kg — कार्ट में डालें / Add to Cart" Blue filled pill, 56sp, white Poppins SemiBold 16sp.

MVVM: ProductDetailViewModel with product, traceabilityChain[], addToCart(), shareQr().
```

---

### TASK-C3 — Cart & Razorpay Checkout
**[NEW — Phase 2]**

```
Flutter screen: Shopping cart and payment gateway.

Header: Blue gradient, "मेरा कार्ट / My Cart (3 आइटम)" white Poppins SemiBold 20sp.

CART ITEMS (white cards, 16px radius, 12dp gap, NO dividers):
  Each item card (horizontal, 80px height):
    Thumbnail 70x70px (12px radius, left).
    Center: product name Poppins Medium 14sp + beekeeper Noto Sans 12sp gray + flora variety 12sp gray.
    Qty stepper: [−] white circle + "2 kg" Roboto Mono 14sp + [+] white circle.
    Price: "₹640" Poppins SemiBold 14sp Blue, right.

ORDER SUMMARY (surface-low bg card, 16px radius):
  Row pairs (label left, value right, 12dp vertical spacing):
    उप-कुल / Subtotal: ₹1,240
    डिलीवरी / Delivery: ₹80
    प्लेटफॉर्म शुल्क / Platform fee: ₹25
    GST 5%: ₹62
    ─────────────────────────────
    कुल / TOTAL: ₹1,407 Poppins Bold 20sp Blue

DELIVERY ADDRESS card + "नया पता जोड़ें / Add New Address" Blue text link.

PAYMENT METHOD chips: [UPI ✓] [कार्ड] [नेट बैंकिंग] — selected chip = Blue fill, white text.

ESCROW NOTE (gray italic Noto Sans 12sp):
  "किसान को भुगतान डिलीवरी सफल होने के बाद एस्क्रो से मिलेगा। / Payment to farmer released after successful delivery."

CTA: "₹1,407 — Razorpay से भुगतान करें / Pay via Razorpay" Blue gradient pill, 56sp.
Below: 🔒 "100% सुरक्षित भुगतान / Secure Payment" gray small centered.

MVVM: CartViewModel with items[], totals, deliveryAddress, paymentMethod, checkout().
```

---

## ══════════════════════════════════════════════════════
## SECTION D — FPO ADMIN ROLE (PHASE 2)
## Purple #6B21A8 theme
## ══════════════════════════════════════════════════════

---

### TASK-D1 — FPO Admin Dashboard
**[NEW — Phase 2]**

```
Flutter screen: FPO Admin main dashboard.
Role color: Purple #6B21A8.

Header: Purple gradient, "FPO डैशबोर्ड / FPO Dashboard" white Poppins Bold 22sp.
Sub: "श्री राम किसान FPO • लखीमपुर खीरी" white Noto Sans 13sp.

4 KPI METRIC CARDS (2×2 grid, white, 16px radius, ambient shadow):
  [🐝 कुल सदस्य: 127 — Purple left border 4px]
  [🍯 इस सीजन: 2,840 kg — Green left border]
  [📋 लंबित अनुमोदन: 8 — Amber left border]
  [💰 मार्केटप्लेस: ₹9.12L — Blue left border]
  Each: label Noto Sans 12sp gray + value Poppins Bold 24sp --color-on-surface.

MEMBER HEALTH (section title "सदस्य स्वास्थ्य / Member Health" purple):
  Horizontal bar: green 78% | amber 15% | red 7% (rounded pill, 16px height, full width, no labels inside bar).
  Below bar: 3 pill chips row: [🟢 स्वस्थ / Healthy 99] [🟡 ध्यान / Attention 19] [🔴 तत्काल / Urgent 9]

RECENT ALERTS (horizontal scroll, red border mini-cards, 100px height):
  Each alert card: "🚨 [Alert type]" red header + beekeeper name + "जवाब दें / Respond" red outlined pill.

QUICK ACTIONS (2×2 grid, purple-light #F3E8FF bg, 16px radius each):
  [📋 लिस्टिंग अनुमोदित करें] [📢 एडवाइजरी भेजें]
  [📊 रिपोर्ट निकालें] [📦 बंडल बनाएं]
  Each: large icon 36px + label Noto Sans Devanagari 13sp center-aligned.

Bottom nav (Night Hive, Purple active indicator):
  [🏠 डैशबोर्ड (active)] [👥 सदस्य] [✅ अनुमोदन] [📊 रिपोर्ट] [⚙️ सेटिंग]

MVVM: FpoAdminViewModel with stats, memberHealth, pendingCount, recentAlerts[], navigate().
```

---

### TASK-D2 — Member Management Screen
**[NEW — Phase 2]**

```
Flutter screen: FPO member list with health status monitoring.

Header: Purple gradient, "सदस्य प्रबंधन / Member Management (127)" white.
Filter chips: [सभी / All] [🔴 तत्काल 9] [🟡 ध्यान 19] [🟢 स्वस्थ 99] [📋 लंबित]

MEMBER LIST (white cards, 16px radius, 8dp gap, NO dividers):
  Each member card (horizontal, 72sp height):
    Left: avatar + health status dot (8px colored circle overlay: red/amber/green).
    Center: Name Poppins Medium 14sp + ApisSutra ID Roboto Mono 12sp + District Noto Sans 12sp gray.
    Right column: Colony count + last inspection date (Roboto Mono 11sp).
  Swipe LEFT: red background → "🚨 अलर्ट भेजें / Send Alert" action.
  Swipe RIGHT: green background → "📋 प्रोफाइल / View Profile" action.

Bottom sticky: "CSV/Excel निर्यात करें / Export" purple outlined pill, full width.

MVVM: MemberListViewModel with members[], activeFilter, exportData(), sendAlert(memberId).
```

---

### TASK-D3 — Bulk Listing Approval Queue
**[NEW — Phase 2]**

```
Flutter screen: Approve/reject beekeeper marketplace listings queue.

Header: Purple gradient, "लिस्टिंग अनुमोदन / Listing Approval (8 लंबित / Pending)" white.
Tabs: [सभी 8] [शहद 5] [मोम 2] [पराग 1]

LISTING CARDS (white, 4px purple left border, 16px radius, 16dp gap):
  Each card:
    Beekeeper info row: avatar + name + ApisSutra ID + "15 जुलाई 2025" date Roboto Mono.
    Quality param chips: [नमी: 19.1%] [HMF: 14] [रंग: Extra White] Roboto Mono 12sp.
    Buttons row: ["🔬 PDF देखें" purple ghost pill] + photo strip (3 thumbnails 50x50px).
    Traceability mini-chain: "✓ एपियरी GPS → ✓ फसल डायरी → ✓ लैब रिपोर्ट" green small Noto Sans 12sp.
    ACTION ROW: [✗ अस्वीकार / Reject — red outlined pill] [✓ अनुमोदित / Approve — purple gradient pill]

BULK ACTION BAR (bottom, white card with purple tint):
  Left: "सभी चुनें / Select All □" checkbox.
  Right: "8 चुने — सभी अनुमोदित करें / Bulk Approve" purple pill (active when any selected).

MVVM: ListingApprovalViewModel with listings[], approve(id), reject(id, reason), bulkApprove(ids[]).
```

---

### TASK-D4 — Broadcast Advisory Screen
**[NEW — Phase 2]**

```
Flutter screen: FPO sends advisory to all member beekeepers.

Header: Purple gradient, "एडवाइजरी भेजें / Send Advisory" white.

COMPOSE CARD (white, 16px radius, ambient shadow):
  "शीर्षक / Title" → text input, 56sp.
  Language toggle: [हिंदी ✓] [English] [दोनों / Both] — orange active pill.
  "संदेश / Message" → multiline textarea, 6 lines. Character counter: "247 / 500" right gray.

ATTACHMENTS (row of orange outlined ghost pills, 48sp, 8dp gap):
  [+ PDF संलग्न / Attach PDF] [+ वीडियो लिंक / Video Link]

URGENCY SELECTOR (section title "तात्कालिकता / Urgency"):
  3-chip selector: [🟢 सामान्य / Normal] [🟡 महत्वपूर्ण / Important] [🔴 अत्यावश्यक / Urgent]
  Selected: respective color fill, white text.

TARGET AUDIENCE chips: [सभी सदस्य ✓] [जिले द्वारा / By District] [प्रजाति द्वारा / By Bee Species]

SCHEDULE TOGGLE (row: label + iOS toggle):
  OFF: "अभी भेजें / Send Now".
  ON: shows date-time picker (date row + time row below toggle).

PREVIEW (section title "पूर्वावलोकन / Preview"):
  Phone notification mockup card (dark surface bg, white text, purple app icon):
    "ApisSutra Advisory" + title + first 100 chars of message.

CTA: "127 सदस्यों को भेजें / Send to 127 Members" purple gradient pill, 56sp.

MVVM: BroadcastViewModel with title, body, language, urgency, target, scheduleTime, send().
```

---

## ══════════════════════════════════════════════════════
## SECTION E — FIELD EXTENSION OFFICER (PHASE 2)
## Red #D64045 theme
## ══════════════════════════════════════════════════════

---

### TASK-E1 — Alert Feed Screen
**[NEW — Phase 2]**

```
Flutter screen: Field Officer's live pest/disease alert feed.
Role color: Red #D64045.

Header: Red gradient, "अलर्ट फ़ीड / Alert Feed" white Poppins Bold 22sp.
Sub: "लखीमपुर खीरी • आज 3 नए SEVERE अलर्ट / Today 3 new SEVERE alerts" white 13sp.

Tabs: [🔴 SEVERE (3)] [🟡 MODERATE (7)] [🟢 LOW (12)] [✅ हल / Resolved (45)]

SEVERE ALERT CARDS (4px red left border, 16px radius, 16dp gap):
  Header: "🚨 SEVERE — वेरोआ माइट / Varroa Mite" Red Poppins SemiBold 16sp + timestamp Roboto Mono right.
  Beekeeper row: avatar 40px + "राम नारायण" Poppins Medium 14sp + "APS-UP-2024-7823" Roboto Mono 12sp orange.
  Location: "📍 मितौली ब्लॉक, लखीमपुर" + "12 km दूर / 12km away" gray.
  Pest evidence: pest photo thumbnail 80x80px (12px radius) + "🤖 AI: 94% Varroa" confidence pill (purple).
  Impact: "18 में से 6 छत्ते प्रभावित / 6 of 18 hives affected" Noto Sans 13sp orange.
  ACTION ROW: [📞 कॉल / Call — red outlined] [🗺️ दिशा / Directions — gray outlined] [✅ जवाब दर्ज / Log Response — red filled pill]

Bottom nav (Night Hive, Red active):
  [🔔 अलर्ट (active)] [🗺️ मानचित्र] [📋 लॉग] [🎓 प्रशिक्षण] [👤 प्रोफाइल]

MVVM: AlertFeedViewModel with alerts[], activeSeverityFilter, respondToAlert(alertId).
```

---

### TASK-E2 — District Beekeeper Map
**[NEW — Phase 2]**

```
Flutter screen: GPS map of all registered beekeepers in the officer's district.

Header: Red gradient, "जिला मानचित्र / District Map (लखीमपुर खीरी)" white.
Filter chips: [🟢 स्वस्थ] [🟡 ध्यान] [🔴 तत्काल] [📋 सक्रिय माइग्रेशन]

FULL-SCREEN Google Maps (custom markers, clustering at zoom-out):
  Marker types: 🐝 green (healthy) | 🐝 amber (attention) | 🐝 red (urgent) | 📍 migration pinned.
  Cluster bubble: count number in colored circle (color = dominant severity).

BOTTOM SHEET (drag handle, collapsed = "156 मधुमक्खी पालक — खींचें / Pull Up" pill):
  Expanded: scrollable beekeeper list (same card style as D2, compact 56sp rows).
  TAP MARKER → bottom sheet snaps to that beekeeper's mini-profile:
    Name + ID + last inspection + [📞 कॉल] [📋 इतिहास / History] [🚨 अलर्ट भेजें / Send Alert]

MVVM: DistrictMapViewModel with beekeeperLocations[], activeFilter, selectedBeekeeper.
```

---

## ══════════════════════════════════════════════════════
## SECTION F — GOVERNMENT ADMIN (REACT WEB — PHASE 3)
## Govt Teal #0E7490 theme
## ══════════════════════════════════════════════════════

---

### TASK-F1 — Government Admin Web Dashboard (React)
**[NEW — Phase 3 — React Web, NOT Flutter]**

```
PLATFORM: React Web (NOT Flutter) — desktop/tablet browser.
Framework: React + TypeScript + Tailwind CSS + recharts + react-leaflet.
Role color: Govt Teal #0E7490.

LEFT SIDEBAR (240px, teal bg, sticky):
  Top: ApisSutra bee logo + "AgroSphere सरकारी पोर्टल / Govt Portal" white.
  User block: avatar + "श्रीमती अनिता सिंह" + "NBB — UP State Official" + "Uttar Pradesh Scope" — white text.
  NAV MENU (white text, teal-800 active highlight):
    [🗺️ कॉलोनी मानचित्र / Colony Map]
    [🍯 उत्पादन हीटमैप / Production Heatmap]
    [🐛 कीट ट्रैकर / Pest Tracker]
    [📋 योजना रिपोर्ट / Scheme Reports]
    [🔗 NBB डेटा / NBB Data Push]
    [📊 जिला नीति निर्यात / District Policy Export]
  Logout: bottom left.

MAIN CONTENT (calc(100vw - 240px)):

  KPI ROW (4 cards, white, teal left border):
    [🐝 3.2M कॉलोनी / Colonies] [👥 1,02,847 पंजीकृत / Registered]
    [🍯 46,200 MT उत्पादन / Production] [🚨 127 SEVERE अलर्ट / Alerts]

  CENTER: Interactive India Map (react-leaflet, ~55% main area height):
    Districts color-coded (green → yellow → orange → red by colony health %).
    Hover tooltip: district name + colony count + health % + top pest.
    Click: drill down National → State → District → Apiary list panel (right sidebar).

  RIGHT PANEL (320px, white card):
    "शीर्ष 10 जिले / Top 10 Districts" table: Rank | Name | Colonies | Harvest | Alerts.
    "सक्रिय प्रकोप / Active Outbreaks" 3-card stack (red).

  BOTTOM ROW (2 charts side-by-side, recharts, teal scheme):
    Left: "मासिक उत्पादन ट्रेंड / Monthly Production Trend" — line chart, 12 months.
    Right: "योजना उपयोग / Scheme Uptake" — bar chart per state (NABARD/MIDH/KVIC).

NOTE: This is a React component, NOT Flutter. Use Tailwind for styling.
      All teal color: #0E7490. Active states: teal-700 darken.
      Recharts: teal-500 fills. Maps: react-leaflet v4+ with custom markers.
```

---

## ══════════════════════════════════════════════════════
## EXECUTION TABLE — RUN IN THIS ORDER IN GOOGLE STITCH
## ══════════════════════════════════════════════════════

```
PASS 1 — Foundation (Always first — seeds design system and validates style)
  TASK-00   Master App Prompt (design system, tokens, universal rules)
  TASK-A3   Phone Login         (validates orange button + ghost border)
  TASK-A2   Language Selection  (validates black/white contrast + pill chips)
  TASK-B1   Home Dashboard      (reference screen — most comprehensive single screen)

PASS 2 — Complete Onboarding Flow
  TASK-A1   Splash / Brand Screen
  TASK-A4   OTP Verification
  TASK-A5   Profile Setup (Empty)
  TASK-A6   Profile Setup (Filled — validation pass)

PASS 3 — Core Beekeeper Screens
  TASK-B2   My Apiary Management
  TASK-B3   Hive Products Tracking
  TASK-B4   Do's and Don'ts Guide
  TASK-B5   Activity Calendar (12 months)
  TASK-B6   Migration Planning
  TASK-B7   Products for Sale
  TASK-B8   Alert & Companion
  TASK-B9   Flora Identification
  TASK-B10  Camera Screen
  TASK-B11  Location Map
  TASK-B12  Bee Health / Pest Info
  TASK-B13  Chat Support Hub
  TASK-B14  Profile Screen
  TASK-B15  More Screen
  TASK-B16  Settings Screen

PASS 4 — Wild Honey Collector (New Merged Screens)
  TASK-HC1  Wild Harvest Log Dashboard
  TASK-HC2  Geo-Tag Photo Capture
  TASK-HC3  Harvest Detail Entry Form
  TASK-HC4  Quality Submit to FPO
  TASK-HC5  ApisSutra Digital ID Card

PASS 5 — Buyer Role (Phase 2)
  TASK-C1   Marketplace Browse
  TASK-C2   Product Detail + Traceability
  TASK-C3   Cart & Razorpay Checkout

PASS 6 — FPO Admin Role (Phase 2)
  TASK-D1   FPO Dashboard
  TASK-D2   Member Management
  TASK-D3   Bulk Listing Approval Queue
  TASK-D4   Broadcast Advisory

PASS 7 — Field Extension Officer (Phase 2)
  TASK-E1   Alert Feed
  TASK-E2   District Beekeeper Map

PASS 8 — Government Admin (React Web, Phase 3)
  TASK-F1   Government Admin Web Dashboard

TOTAL: 35 tasks
  Onboarding:      6 tasks  (A1–A6)
  Beekeeper Core: 16 tasks  (B1–B16)
  Honey Collector: 5 tasks  (HC1–HC5)
  Buyer:           3 tasks  (C1–C3)
  FPO Admin:       4 tasks  (D1–D4)
  Field Officer:   2 tasks  (E1–E2)
  Govt Admin:      1 task   (F1)
```

---

## ══════════════════════════════════════════════════════
## UNIVERSAL STITCH SUFFIX
## Paste this at the END of every individual screen prompt in Stitch
## ══════════════════════════════════════════════════════

```
UNIVERSAL STITCH SUFFIX — Add to EVERY screen prompt:

"Generate Flutter code using MVVM architecture:
 - [ScreenName]View (StatelessWidget, BLoC/Cubit consumer)
 - [ScreenName]Cubit (ChangeNotifier/Cubit, no UI code)

FONTS: GoogleFonts.notoSansDevanagari() → Hindi. GoogleFonts.poppins() → English/display.
       GoogleFonts.robotoMono() → IDs, coordinates, timestamps, batch numbers.

TAP TARGETS: 56sp primary CTAs, 48sp secondary, minimum 44sp for icons.

INPUT FIELDS: 56sp height | white bg | 12px radius | inactive border #E0D5C5 (20% opacity)
              | active border #F7941D | short fields: centered text | long fields: left-aligned.

DESIGN SYSTEM RULES:
  - NO 1px solid borders for section dividers → use tonal background shifts only.
  - NO pure black (#000000) text → use --color-on-surface #1A1B20.
  - NO standard Material dividers → use 12px vertical white space or alternating surface tones.
  - Ambient shadows only: blur 24px+, 6% opacity, tinted with #8C4F00.
  - All primary CTA buttons: linear-gradient(135deg, #8C4F00, #F7941D) pill shape, white Poppins SemiBold.
  - Hero/dashboard cards: 32px radius. Standard cards: 16px radius.

OFFLINE SYNC BAR (below AppBar on all Beekeeper/Collector screens):
  Online: hidden. Syncing: orange #F7941D. Offline: amber #F59B00.

BOTTOM NAV: pitch black #000000 bg. White icons. Orange #F7941D active circle glow.

FOR EXISTING SCREENS: Match baseline MadhuMitra app design exactly. Add ApisSutra rebranding only.
FOR NEW HC SCREENS: Match ApisSutra base style but use Forest Green #1D6C2E as section accent.
FOR BUYER SCREENS: Use Buyer Blue #1967D2 as primary role color.
FOR FPO SCREENS: Use FPO Purple #6B21A8 as primary role color.
FOR FIELD OFFICER SCREENS: Use Red #D64045 as primary role color."
```

---

*Document: ApisSutra Google Stitch Prompt Library — Final Version*
*Suite: AgroSphere | VanaSutra | ApisSutra*
*Version: 4.0 | April 2026 | Bahraich / Lucknow / Varanasi, Uttar Pradesh*
*Design System: Organic Brutalism — The Digital Apiary*
*Architecture: Flutter MVVM + BLoC | Clean Architecture | Laravel 11 REST API | Drift SQLite*
*Roles: Merged Beekeeper+Honey Collector (Phase 1) | Buyer | FPO | Field Officer | Govt Admin*
*Data Sources: Bee_products.docx | Beekeeping_Do_s_and_Don_ts.docx | Hive_Managment.docx*
*              Honey_Bee_Hive_Activity_Calendar.docx | Migration.docx | My_Apiary.docx*
*              Product_for_Sale.docx | Profile_of_Madhu_Mitra.docx | DESIGN.md | HiveSetu_v3.md*
