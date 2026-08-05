---
type: Rule
title: Frontend Performance Checklist
description: Prioritized checklist of frontend performance best practices covering page weight, load time, caching, assets, and delivery
tags: [performance, frontend, web, optimization, checklist]
timestamp: 2026-08-05T00:00:00Z
id: rule-rules-performance-frontend_performance_checklist
cdr_ref: CDR-2026-029
created: 2026-08-05
modified: 2026-08-05
verified: 2026-08-05
age_days: 0
evidence: []
---

# Rule: Frontend Performance Checklist

Run through this checklist when building or reviewing any web frontend. Items are ordered by priority — high-priority items have the largest impact on load time, user experience, and Core Web Vitals.

For React/Next.js-specific rendering and bundling guidance, see the `react-best-practices` skill. For accessibility and UX audits, see the `web-design-guidelines` skill. This rule covers the underlying transport, asset, and markup-level practices that apply regardless of framework.

## High Priority Checklist

Delivery, weight, and blocking-resource fundamentals. Violating these has the most direct impact on load time and Core Web Vitals.

- [ ] Keep total page weight < 1500 KB (ideally < 500 KB)
- [ ] Keep page load time < 3 seconds
- [ ] Enable GZIP / Brotli compression
- [ ] Minimize the number of HTTP requests
- [ ] Compress images / keep image count low
- [ ] Set HTTP cache headers properly
- [ ] Keep Time To First Byte (TTFB) < 1.3 seconds
- [ ] Non-blocking JavaScript: use `async` / `defer`
- [ ] Minify JavaScript
- [ ] Minify CSS — remove comments, whitespace, etc.
- [ ] Inline the critical CSS (above-the-fold CSS)
- [ ] Ensure CSS files are non-blocking
- [ ] Use HTTPS on the website
- [ ] Choose the appropriate image format for the content (e.g., WebP/AVIF for photos, SVG for icons)
- [ ] Avoid requesting unreachable files (404s)
- [ ] Serve all files from the same protocol (avoid mixed content)
- [ ] Minimize the number of iframes
- [ ] Avoid embedded / inline CSS
- [ ] Analyze stylesheet complexity (selector depth, specificity, unused rules)

## Medium Priority Checklist

Secondary optimizations that reduce payload size and improve perceived performance.

- [ ] Minify HTML — remove comments and whitespace
- [ ] Use a Content Delivery Network (CDN)
- [ ] Prefer vector images (SVG) over bitmap images where possible
- [ ] Set `width` and `height` attributes on images (preserve aspect ratio, avoid layout shift)
- [ ] Avoid Base64-encoded images
- [ ] Lazy-load offscreen images
- [ ] Serve images sized close to their display dimensions (responsive images / `srcset`)
- [ ] Avoid multiple inline `<script>` snippets
- [ ] Keep dependencies up to date
- [ ] Check for performance problems in JavaScript files (long tasks, unnecessary re-renders, memory leaks)
- [ ] Use Service Workers for caching / offloading heavy tasks
- [ ] Keep cookie size under 4096 bytes
- [ ] Keep the cookie count under 20

## Low Priority Checklist

Fine-tuning and marginal gains — apply once high- and medium-priority items are addressed.

- [ ] Preload URLs where possible (`<link rel="preload">`)
- [ ] Concatenate CSS into a single file
- [ ] Remove unused CSS
- [ ] Use the WOFF2 font format
- [ ] Use `preconnect` to load fonts faster
- [ ] Keep total web font size under 300 KB
- [ ] Prevent Flash of Invisible Text (FOIT) — use `font-display: swap` or similar
- [ ] Keep an eye on the size of third-party dependencies

## References

- `skills/react-best-practices` — React/Next.js rendering, bundling, and data-fetching performance patterns
- `skills/web-design-guidelines` — accessibility, UX, and interface-level performance guidelines
- `@rule:style-guides/file_organization.md` — general code structure standards that keep JS/CSS bundles maintainable
